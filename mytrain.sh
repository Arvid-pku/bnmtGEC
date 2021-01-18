src=src
tgt=tgt
bedropout=0.5
ARCH=transformer
DATAPATH=bertnmt/data
SAVEDIR=checkpoints
mkdir -p $SAVEDIR

CUDA_VISIBLE_DEVICES=1 python bertnmt/train.py $DATAPATH \
-a $ARCH --optimizer adam --lr 0.0005 -s $src -t $tgt --label-smoothing 0.1 \
--reset-dataloader --num-workers 0 --bert-model-name 'bert-base-chinese' \
--dropout 0.3 --max-tokens 4000 --min-lr '1e-09' --lr-scheduler inverse_sqrt --weight-decay 0.0001 \
--criterion label_smoothed_cross_entropy --max-update 150000 --warmup-updates 4000 --warmup-init-lr '1e-07' \
--adam-betas '(0.9,0.98)' --save-dir $SAVEDIR --share-all-embeddings \
--encoder-bert-dropout --encoder-bert-dropout-ratio $bedropout | tee -a $SAVEDIR/training.log