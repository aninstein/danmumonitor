# -*- coding:utf-8 -*-
# 语义分析
import csv
from douyu.chat.room import ChatRoom
from multiprocessing import Process
import Random 


def on_chat_message(msg):
    print ("(%s) [%s]:%s" % (msg.attr('level'),msg.attr('nn'),msg.attr('txt')))
    # print "(", msg.attr('level'), ") [", msg.attr('nn'), "]:", msg.attr('txt')


'''
def getContent():
    f = open(u"c:\\d1\\pot_comment.txt","r")
    while True:
        line = f.readline()
        if line:
            #pass  # do something here
            line = line.strip()
            #p = line.rfind('.')
            #filename = line[0:p]
            return line.
        else:
            break
    f.close()

'''


def getlineNum():
    f = open(u"anthor_list.txt", 'r')
    content = csv.reader(f)
    lineNum = 0
    for line in content:
        lineNum += 1
    f.close()
    return (lineNum)  # lineNum就是你要的文件行数


def run(number):
    Number = number
    # print Number
    room = ChatRoom(Number)
    room.on('chatmsg', on_chat_message)
    room.knock()


'''
def works(func):
    proc_record = []
    p = Process(target=func, args=(58428,))
    p.start()
    proc_record.append(p)
    p1 = Process(target=func, args=(340032, ))
    p1.start()
    proc_record.append(p1)
    p2 = Process(target=func, args=(217331, ))
    p2.start()
    proc_record.append(p2)

    for p in proc_record:
        p.join()
'''


def creatXC(func):
    xcNum = getlineNum()
    f = open(u"anthor_list.txt", 'r')
    proc_record = []
    while True:
        line = f.readline()
        if line:
            line = line.strip()
            p = Process(target=func, args=(line,))
            p.start()
            proc_record.append(p)
        else:
            break
    for p in proc_record:
        p.join()


def dorun():
    creatXC(Random.run)

if __name__ == '__main__':
    creatXC(Random.run)
    # works(run)
