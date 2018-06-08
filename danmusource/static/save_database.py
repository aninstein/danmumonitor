#!/usr/bin/env python
# -*- coding:UTF-8 -*-


import MySQLdb
import os
import json
import codecs

os.chdir("../")
from mysql_util import MysqlClient


def read_txt(filepath):
    txt_list = []
    with codecs.open(unicode(filepath, encoding="utf-8"), "rb") as n_file:
        for line in n_file:
            txt_list.append(unicode(line.replace("\n", ""), encoding="gbk"))
    return txt_list


def save_word(tablename, wordlist):
    mysql_client = MysqlClient()
    mysql_client.insert_keytable(tablename, wordlist)


if __name__ == '__main__':
    wordlist = read_txt("G:\\tjutmygithub\\danmumonitor\\danmusource\\static\\pos.txt")
    save_word("key_pos", wordlist)
