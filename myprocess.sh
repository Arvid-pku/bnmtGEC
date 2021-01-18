# TODO data will change to character level



filep=oridata/
lng=src
lan=zh
echo "src lng $lng"
for sub  in ${filep}train ${filep}valid ${filep}test
do
    sed -r 's/(@@ )|(@@ ?$)//g' ${sub}.${lng} > ${sub}.bert.${lng}.tok
    requirement/mosesdecoder/scripts/tokenizer/detokenizer.perl -l $lan < ${sub}.bert.${lng}.tok > ${sub}.bert.${lng}
    rm ${sub}.bert.${lng}.tok
done


TEXT=oridata
python bertnmt/preprocess.py --source-lang src --target-lang tgt \
  --trainpref $TEXT/train --validpref $TEXT/valid --testpref $TEXT/test \
  --destdir bertnmt/data  --joined-dictionary --bert-model-name bert-base-chinese