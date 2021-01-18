# TODO data will change to character level



TEXT=oridata/char
DEST=bertnmt/data/char
lng=src
lan=zh
echo "src lng $lng"
for sub  in ${TEXT}/train ${TEXT}/valid ${TEXT}/test
do
    sed -r 's/(@@ )|(@@ ?$)//g' ${sub}.${lng} > ${sub}.bert.${lng}.tok
    ./requirement/mosesdecoder/scripts/tokenizer/detokenizer.perl -l $lan < ${sub}.bert.${lng}.tok > ${sub}.bert.${lng}
    rm ${sub}.bert.${lng}.tok
done



python bertnmt/preprocess.py --source-lang src --target-lang tgt \
  --trainpref $TEXT/train --validpref $TEXT/valid --testpref $TEXT/test \
  --destdir $DEST  --joined-dictionary --bert-model-name bert-base-chinese