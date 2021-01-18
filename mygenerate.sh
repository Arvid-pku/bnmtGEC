# TODO
# bert-model-name will change
python bertnmt/generate.py bertnmt/data/  \
    --path checkpoints/checkpoint_best.pt \
    --bert-model-name bert-base-chinese \
    --gen-subset test \
    --beam 12  \
    --max-tokens 4096  \
    --max-len-b 100  \
    --remove-bpe > result/re.txt

cd ../pkunlp/
python reform.py
cd ../bertnmt/
cd m2scorer/scripts/
source activate m2s
python m2scorer.py