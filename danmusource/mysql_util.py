#!/usr/bin/env python
#-*- coding: utf-8 -*-


import MySQLdb


_user = "root"
_dbname = "dmmonitor"
_port = 3306
_passwd = "aninstein"
_charset = "utf8"


class MysqlClient(object):
    def __init__(self, user=_user, dbname=_dbname, port=_port, passwd=_passwd, charset=_charset):
        self.conn = MySQLdb.connect(user=_user,db=dbname, port=port, passwd=passwd, charset=charset)
        self.cursor = self.conn.cursor()

    def _select(self, sql):
        result = None
        try:
            self.cursor.execute(sql)
            result = self.cursor.fetchall()
        except Exception as e:
            print e
        return result


    def create_anchor_table(self, tablename):
        global table
        table = "table_" + str(tablename)
        sql = "create table if not exists %s(" \
              "number int(255) primary key not null auto_increment," \
              "level varchar(255),id varchar(255)," \
              "content varchar(255)," \
              "date varchar(255)," \
              "pos varchar(255)," \
              "neg varchar(255)," \
              "sum int(255)," \
              "mark int(255)," \
              "ratio float(255,2)," \
              "flag int(2)" \
              ");" % (str(table))
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            print "create table: %s" % table
            return True
        except:
            self.conn.rollback()
            return False

    def insert_keytable(self, tablename, wordlist):
        sql = "insert into "+ tablename +"(word) values(%s)"
        try:
            self.cursor.executemany(sql, wordlist)
            self.conn.commit()
            return True
        except Exception as e:
            self.conn.rollback()
            return False

    def select_keytable(self, tablename, score):


        sql = "select word from %s" % tablename
        result_set = self._select(sql=sql)






if __name__ == '__main__':
    pass
