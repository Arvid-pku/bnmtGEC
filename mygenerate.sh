# TODO
# bert-model-name will change

DATAPATH=bertnmt/data/char/
CHECK=checkpoints/char/checkpoint_best.pt
CUDA_VISIBLE_DEVICES=3 python bertnmt/generate.py $DATAPATH  \
    --path $CHECK \
    --bert-model-name bert-base-chinese \
    --gen-subset test \
    --beam 12  \
    --max-tokens 4096  \
    --max-len-b 100  \
    --remove-bpe > result/re.txt

cd requirement/pkunlp/
python reform.py
cd ../../
cd m2scorer/scripts/
source activate m2s
python m2scorer.py