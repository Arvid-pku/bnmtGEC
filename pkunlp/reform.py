#!/usr/bin/python
# encoding: utf-8

from __future__ import unicode_literals, print_function

import os
# import jieba
# import pkuseg
from pkunlp import Segmentor, NERTagger, POSTaggerV2, SyntaxParser, SemanticParser


pkunlp_seg = Segmentor("feature/segment.feat", "feature/segment.dic")
# pku_seg = pkuseg.pkuseg()


def cut_sentence(sentence, method="pkunlp"):
    if method=="pkunlp":
        word_list = pkunlp_seg.seg_string(sentence)
    # elif method=="pkuseg":
    #     word_list = pku_seg.cut(sentence)
    # else:
    #     word_list = jieba.cut(sentence)
    return word_list


def read_data(file_path):
    if not os.path.exists(file_path):
        print("File not exists")
        return []
    data = []
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f.readlines():
            line = line.strip()
            if line=="":
                continue
            data.append(line)
    return data


def get_src_pred(data):
    data = data[6:-2]
    print("The length of data is %d" % len(data))

    src_list = ["" for _ in range(2000)]
    pred_list = ["" for _ in range(2000)]

    for x in range(2000):
        line = data[x*4+2]
        idx = int(line.split("\t")[0].split("-")[-1])
        src_sent = data[x*4].split("\t")[-1].split(" ")
        pred_sent = line.split("\t")[2].split(" ")

        src_sent = "".join(src_sent)
        pred_sent = "".join(pred_sent)

        src_list[idx] = src_sent
        pred_list[idx] = pred_sent

    return src_list, pred_list


def write_data(data, file_path):
    if os.path.exists(file_path):
        os.remove(file_path)
    with open(file_path, "a", encoding="utf-8") as f:
        for line in data:
            f.write("%s\n" % line)


if __name__ == "__main__":
    
    method = "pkunlp"
    input_file = "../bertnmt/result/re.txt"
    output_file = "../bertnmt/result/re-%s.txt" % method

    src_data, pred_data = get_src_pred(read_data(input_file))
    seg_data = [" ".join(cut_sentence(x, method)) for x in pred_data]
    
    write_data(seg_data, output_file)
    # print(cut_sentence("我爱北京天安门，天安门上太阳升"))

