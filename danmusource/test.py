# -*- coding:utf-8 -*-
#encoding=utf-8
# 语义分析
from douyu.chat.room import ChatRoom
from multiprocessing import Process
def on_chat_message(msg):
    print '(%s) [%s]:%s' % (msg.attr('level'),msg.attr('nn'),msg.attr('txt'))

def run(number):
    Number = number
    #print Number
    room=ChatRoom(Number)
    room.on('chatmsg',on_chat_message)
    room.knock()
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
threads = []
num1 = 532152
num2 = 208114
num3 = 74751
t1 = threading.Thread(target=run,args=num1)
threads.append(t1)
t2 = threading.Thread(target=run,args=num2)
threads.append(t2)
t3 = threading.Thread(target=run,args=num3)
threads.append(t3)
    for t in threads:
        t.setDaemon(True)
        t.start()
'''

if __name__ == '__main__':
    works(run)




