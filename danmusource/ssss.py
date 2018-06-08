# -*- coding:utf-8 -*-
import Tkinter
import os
import threading
import MySQLdb
import getTextTest

class MainFrame(Tkinter.Frame):   #主框架
    def __init__(self, master=None):    #初始化
        Tkinter.Frame.__init__(self, master)

        self.grid(row=0, column=0, sticky="nsew")
        self.createFrame()                 #创建这个框架

    def createFrame(self):      #创建框架
        label_frame_top = Tkinter.LabelFrame(self)
        # label_frame_top.pack()

        label_frame_center = Tkinter.LabelFrame(self)
        label_frame_center.pack(fill="x")

        lfc_field_1 = Tkinter.LabelFrame(label_frame_center)
        lfc_field_1.pack(fill="x")



        ##########文本框与滚动条
        self.lfc_field_1_t_sv = Tkinter.Scrollbar(lfc_field_1, orient=Tkinter.VERTICAL)  # 文本框-竖向滚动条
        self.lfc_field_1_t_sh = Tkinter.Scrollbar(lfc_field_1, orient=Tkinter.HORIZONTAL)  # 文本框-横向滚动条

        self.lfc_field_1_t = Tkinter.Text(lfc_field_1, height=55, yscrollcommand=self.lfc_field_1_t_sv.set,
                                          xscrollcommand=self.lfc_field_1_t_sh.set, wrap='none')  # 设置滚动条-不换行


        ###########读取数据库########
        # 连接数据库
        db = MySQLdb.connect(user="root", db="dmmonitor", port=3306, passwd='aninstein', charset='utf8')
        cursor = db.cursor()

        # SQL语句
        getaa = cursor.execute("select Aroom from artable;")
        info = cursor.fetchmany(getaa)
        for ii in info:

            self.lfc_field_1_t.insert(Tkinter.INSERT,ii)
            self.lfc_field_1_t.insert(Tkinter.INSERT,'\n')
        ###########################



        self.lfc_field_1_l = Tkinter.Label(lfc_field_1, text="监控列表：", width=10)
        self.lfc_field_1_l.pack(fill="y", expand=0, side=Tkinter.LEFT)
        #print text1
        #self.lfc_field_1_b = Tkinter.Button(lfc_field_1, text="开始监控：", width=10, height=1, command=self.clearText)
        self.lfc_field_1_b = Tkinter.Button(lfc_field_1, text="开始监控", width=10, height=1, command=self.addreads)
        self.lfc_field_1_b.pack(fill="none", expand=0, side=Tkinter.RIGHT, anchor=Tkinter.SE)

        # 滚动事件
        self.lfc_field_1_t_sv.config(command=self.lfc_field_1_t.yview)
        self.lfc_field_1_t_sh.config(command=self.lfc_field_1_t.xview)

        # 布局
        self.lfc_field_1_t_sv.pack(fill="y", expand=0, side=Tkinter.RIGHT, anchor=Tkinter.N)
        self.lfc_field_1_t_sh.pack(fill="x", expand=0, side=Tkinter.BOTTOM, anchor=Tkinter.N)
        self.lfc_field_1_t.pack(fill="x", expand=1, side=Tkinter.LEFT)

        # 绑定事件
        self.lfc_field_1_t.bind("<Control-Key-a>", self.selectText)
        self.lfc_field_1_t.bind("<Control-Key-A>", self.selectText)

        ##########文本框与滚动条end



        label_frame_bottom = Tkinter.LabelFrame(self)
        # label_frame_bottom.pack()

        pass

        # 文本全选

    def addreads(self):
        threads = []
        t1 = threading.Thread(target=self.inText)
        threads.append(t1)
        t1.setDaemon(True)
        t1.start()
        return
    def selectText(self, event): #文本全选
        self.lfc_field_1_t.tag_add(Tkinter.SEL, "1.0", Tkinter.END)
        # self.lfc_field_1_t.mark_set(Tkinter.INSERT, "1.0")
        # self.lfc_field_1_t.see(Tkinter.INSERT)
        return 'break'  # 为什么要return 'break'

    def gettext(self):
        return self.lfc_field_1_t.get('1.0',Tkinter.END+'-1c')
    # 文本清空0.
    def clearText(self):
        self.lfc_field_1_t.delete(0.0, Tkinter.END)
    def inText(self):

        from getTextTest import dorun

        alltext = self.gettext()
        f1 = open(u"anthor_list.txt", 'w')
        f1.write(alltext)
        f1.close()
        #os.system('E:\Python\机器学习')
        # os.system('python getTextTest.py')
        dorun()

def main():
    '''
    f1 = open(u"c:\\d1\\anthor_list.txt",'r')
    line = f1.readline()
    while line:1
    4
        print line
        line = f1.readline()
    '''

    root = Tkinter.Tk()
    root.columnconfigure(0, weight=1)
    root.rowconfigure(0, weight=1)
    root.title("直播弹幕监控")
    root.geometry('640x360')  # 设置了主窗口的初始大小960x540 800x450 640x360

    main_frame = MainFrame(root)
    main_frame.mainloop()


if __name__ == "__main__":
    main()

