SAVEDIR=checkpoints
mkdir -p $SAVEDIR
if [ ! -e "$SAVEDIR/checkpoint_last.pt" ]
then
warmup="--warmup-from-nmt --reset-lr-scheduler"
else
warmup=""
fi
echo $warmup