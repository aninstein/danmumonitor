# -*- coding:utf-8 -*-
# 语义分析
from douyu.chat.room import ChatRoom
import MySQLdb
import time
import jieba
import jieba.posseg as pseg
import jieba.analyse
import pickle
import Feature_selection
import getname
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

jieba.load_userdict("static/a1.txt")
jieba.load_userdict("static/b2.txt")
#建立连接

db = MySQLdb.connect(user="root",db="dmmonitor",port=3306,passwd='aninstein',charset='utf8')
# 使用cursor()方法获取操作游标
cursor = db.cursor()
n = 0
m = 0
roomnumber = str('')
table = str('')

##  使用分类器
##默认选取前1000个特征  可修改
Feature_selection.number=1000
clf = pickle.load(open('static/classifier1.pkl'))  # 载入分类器
def extract_features(data):
    feat = []
    for i in data:
        me = Feature_selection.best_word_features_oat(i)
        feat.append(me)

    return feat

def loadDict(fileName,score):
    wordDict = {}
    with open(fileName) as fin:        #with open 可以处理异常
         #data = fin.read()
         for line in fin:
             word = line.strip().decode('iso-8859-1')
             wordDict[word] = score     #组成了一个字典
    return wordDict

pot_comment = loadDict(u"static/pot_comment.txt", 1)
neg_comment = loadDict(u"static/neg_comment.txt", -1)
degree_level = loadDict(u"static/degree_level.txt", 2)
denial_word = loadDict(u"static/denial_word.txt", -1)
key_sex = loadDict(u"static/key_sex.txt", -1)
key_violence = loadDict(u"static/key_violence.txt", -1)
key_abuse = loadDict(u"static/key_abuse.txt", -1)
key_react = loadDict(u"static/key_react.txt", -1)
key_other = loadDict(u"static/key_other.txt", -1)

#爬取弹幕，处理，插入数据库
def on_chat_message(msg):
    global n
    global m
    global table
    print '(%s) [%s]:%s' % (msg.attr('level'),msg.attr('nn'),msg.attr('txt'))
    n +=1
    a = msg.attr('level')
    b = msg.attr('nn')
    c = msg.attr('txt')
    d = time.strftime('%Y/%m/%d %H:%M:%S',time.localtime(time.time()))
    sum = 0
    flag = 0
    words = pseg.cut(c)

    for w in words:
        print w.word

    for i in pot_comment:  # 要分成单独的 就是utf-8
        if w.word in i:
            sum += 1
            print '-----pos----'
            print w.word
            for i in denial_word:  # 要分成单独的 就是utf-8
                if w.word in i:
                    sum *= -1
                    print '-----no---'
                    print w.word
            break

    for i in key_sex:  # 要分成单独的 就是utf-8
        if w.word in i:
            flag = 1
            sum = -1
            print '-----1-----'
            print w.word
            break
    for i in key_violence:  # 要分成单独的 就是utf-8
        if w.word in i:
            flag = 2
            sum = -1
            print '-----2-----'
            print w.word
            break
    for i in key_abuse:  # 要分成单独的 就是utf-8
        if w.word in i:
            flag = 3
            sum = -1
            print '-----3-----'
            print w.word
            break
    for i in key_react:  # 要分成单独的 就是utf-8
        if w.word in i:
            flag = 4
            sum = -1
            print '-----4-----'
            print w.word
            break
    for i in key_other:  # 要分成单独的 就是utf-8
        if w.word in i:
            flag = 5
            sum = -1
            print '-----5-----'
            print w.word
            break


    print '当前得分 %d' % (sum)
    m += sum
    print '累计得分 %d' % (m)
    print '累计弹幕数 %d'%(n)
    print '弹幕类型 %d' % (flag)
    bili = float(n+m) / float(n)
    print  "弹幕优劣比 %0.2f" % (bili)

    moto = [c]
    moto_features = extract_features(moto)  # 把文本转化为特征表示的形式
    getlistpred = clf.prob_classify_many(moto_features)#积极率：str(i.prob('pos')) 消极率：str(i.prob('neg'))
    for i in getlistpred:
        pred = i

    try:
        cursor.execute("INSERT INTO %s(level,id,content,date,pos,neg,mark,sum,ratio,flag) VALUES('%s','%s','%s','%s','%s','%s','%d','%d','%0.2f','%d')" %(str(table),str(a),str(b),str(c),str(d),str(pred.prob('pos')),str(pred.prob('neg')),sum,m,bili,flag))
        db.commit()

    except:

        # Rollback in case there is any error
        db.rollback()

#创建主播弹幕表
def setable(number):
    global table
    table = "table"+str(number)
    print table
    try:
        #if not exists
        cursor.execute(
            "create table if not exists %s("
            "number int(255) primary key not null auto_increment,"
            "level varchar(255),"
            "id varchar(255),"
            "content varchar(255),"
            "date varchar(255),"
            "pos varchar(255),"
            "neg varchar(255),"
            "sum int(255),"
            "mark int(255),"
            "ratio float(255,2),"
            "flag int(2)"
            ");"%(str(table)))
        db.commit()
        return True
    except:
        db.rollback()
        return False

def run(roomnumber):
    #roomnumber = "1164160"
    if(setable(roomnumber)):
        #将主播信息插入总表
        #获取主播名字
        get1 = getname.getNum()
        name = get1.start(roomnumber)
        #
        print name
        print roomnumber
        print table
        try:
            sql = "select Aname from artable where Aname='" + str(name) + "'"
            cursor.execute(sql)
            result = cursor.fetchall()
            if not result:
                cursor.execute("insert into artable values('%s','%s','%s');"%(str(name), str(roomnumber), str(table)))
                db.commit()
        except Exception as e:
            print "Exception======>", e

        room = ChatRoom(roomnumber)
        room.on('chatmsg',on_chat_message)
        room.knock()
'''
if __name__ == '__main__':
    run()
'''




