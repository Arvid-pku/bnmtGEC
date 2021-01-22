来自 https://github.com/bert-nmt/bert-nmt
主体为fairseq
首先得到了bpe分词版本及为bert准备的未分词版本——存于oridata
然后使用myprocess命令
然后使用mytrain中的命令:把warmup去掉。。我们不用nmt的参数
然后就可以训练了
主要更改在：myprecess.sh, mytrain.sh, mygenerate.sh 和 m2scrore/scripts/m2scrore.py, pkunlp/reform.py 中的路径变量设置

ps: 一些大文件没有上传，具体见.gitignore

更改modeling，使之可以运行finetune的bert