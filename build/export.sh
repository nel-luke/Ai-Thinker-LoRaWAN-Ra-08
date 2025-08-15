#/bin/sh

export TREMO_SDK_PATH=$(realpath $(dirname $(realpath $0))/../)
source $TREMO_SDK_PATH/../.asr/bin/activate

export PATH="$TREMO_SDK_PATH/build/scripts:$PATH"