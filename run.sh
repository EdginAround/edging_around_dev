#!/bin/sh

function usage() {
    echo 'Commands:'
    echo ' - clones - clones all `edgin_around` repos'
    echo ' - setup - sets build up'
}

function run_clone() {
    name=$1
    if test -d $name; then
        echo "'$name' is already initialized"
    else
        git clone git@github.com:EdginAround/$name.git
    fi
}

function run_create_links() {
    TARGET_DIR="`pwd`/edgin_around_rendering/target"
    JNI_DIR="`pwd`/edgin_around_android/edgin_around/src/main/jniLibs"

    rm -rf $JNI_DIR $TEST_DIR
    mkdir -p $JNI_DIR/arm64-v8a/ $JNI_DIR/armeabi/ $JNI_DIR/x86_64/ $JNI_DIR/x86/ $TEST_DIR

    ln -sf "$TARGET_DIR/aarch64-linux-android/release/libedgin_around_android.so" "$JNI_DIR/arm64-v8a/"
    ln -sf "$TARGET_DIR/armv7-linux-androideabi/release/libedgin_around_android.so" "$JNI_DIR/armeabi/"
    ln -sf "$TARGET_DIR/i686-linux-android/release/libedgin_around_android.so" "$JNI_DIR/x86/"
    ln -sf "$TARGET_DIR/x86_64-linux-android/release/libedgin_around_android.so" "$JNI_DIR/x86_64/"
}

if (( $# > 0 )); then
    command=$1
    shift

    case $command in
        'clone')
            run_clone edgin_around_android
            run_clone edgin_around_api
            run_clone edgin_around_desktop
            run_clone edgin_around_rendering
            run_clone edgin_around_resources
            run_clone edgin_around_server
            run_clone edgin_around_tools
            ;;
        'setup')
            run_create_links
            echo 'DONE'
            ;;
        *)
            echo "Command \"$command\" unknown."
            echo
            usage
            ;;
    esac
else
    echo 'Please give a command.'
    echo
    usage
fi

