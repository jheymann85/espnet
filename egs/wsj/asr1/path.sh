MAIN_ROOT=$PWD/../../..
KALDI_ROOT=$MAIN_ROOT/tools/kaldi
SPNET_ROOT=$MAIN_ROOT/src
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$MAIN_ROOT/tools/chainer_ctc/ext/build

[ -f $KALDI_ROOT/tools/env.sh ] && . $KALDI_ROOT/tools/env.sh
export PATH=$PWD/utils/:$KALDI_ROOT/tools/openfst/bin:$KALDI_ROOT/tools/sctk/bin:$PWD:$PATH
[ ! -f $KALDI_ROOT/tools/config/common_path.sh ] && echo >&2 "The standard file $KALDI_ROOT/tools/config/common_path.sh is not present -> Exit!" && exit 1
. $KALDI_ROOT/tools/config/common_path.sh
export LC_ALL=C

rm utils
ln -s $KALDI_ROOT/egs/wsj/s5/utils utils
rm steps
ln -s $KALDI_ROOT/egs/wsj/s5/steps steps

export PATH=$SPNET_ROOT/utils/:$SPNET_ROOT/bin/:$PATH
source $MAIN_ROOT/tools/venv/bin/activate
export PYTHONPATH=$SPNET_ROOT/nets/:$SPNET_ROOT/utils/:$SPNET_ROOT/bin/:$PYTHONPATH

export OMP_NUM_THREADS=1
if [[ $(hostname -f) == *.clsp.jhu.edu ]] ; then
    export CUDA_VISIBLE_DEVICES=$(/usr/local/bin/free-gpu)
fi
