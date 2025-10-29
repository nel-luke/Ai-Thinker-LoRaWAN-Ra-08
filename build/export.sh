#!/bin/sh

# Try to resolve the script path safely, even if sourced
# This works for most sh-compatible shells (bash, dash, zsh, etc.)

# Check if $BASH_SOURCE is available (bash only) and we're being sourced
if [ -n "$BASH_SOURCE" ]; then
    SCRIPT="$BASH_SOURCE"
else
    # Fallback to $0, but it might be -bash or -sh if sourced
    SCRIPT="$0"
fi

# If SCRIPT is a relative path, make it absolute
case "$SCRIPT" in
    /*) SCRIPT_PATH="$SCRIPT" ;;
    *) SCRIPT_PATH="$(pwd)/$SCRIPT" ;;
esac

# Resolve symlinks (if any), and get parent dir
# Use Python as a portable realpath alternative if needed
if command -v realpath >/dev/null 2>&1; then
    SCRIPT_DIR="$(dirname "$(realpath "$SCRIPT_PATH")")"
else
    # macOS fallback: use Python to resolve the realpath
    SCRIPT_DIR="$(dirname "$(python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$SCRIPT_PATH")")"
fi

# Your original logic
TREMO_SDK_PATH="$(realpath "$SCRIPT_DIR/..")"
export TREMO_SDK_PATH

# Activate the environment
. "$TREMO_SDK_PATH/.asr/bin/activate"

# Update PATH
export PATH="$TREMO_SDK_PATH/build/scripts:$PATH"
