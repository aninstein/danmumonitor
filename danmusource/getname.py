# -*- coding:utf-8 -*-

'''

根据房间号获取主播名

'''

import urllib2
import urllib
import re
class getNum:
    def __init__(self):

        self.user_agent ='Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
        self.header ={'User-Agent': self.user_agent}
    def getPage(self,pageIndex):
        try:
            url = 'http://www.douyu.com/' + str(pageIndex)
            request = urllib2.Request(url, headers=self.header)
            response = urllib2.urlopen(request)
            pageCode = response.read().decode('utf-8')
            return pageCode
        except urllib2.URLError, e:
            if hasattr(e, "reason"):
                print u"连接失败,错误原因", e.reason
                return None

    def getPageItems(self, pageIndex):
            pageCode = self.getPage(pageIndex)
            if not pageCode:
                print "未发现页面"
                return None
            #pattern = re.compile('<a class.*?rid=(.*?)".*?',re.S)
            pattern = re.compile('<a.class="zb-name">(.*?)</a>', re.S)
            result = re.search(pattern,pageCode)
            if result:
                #print result.group(1)  #测试输出
                return result.group(1).strip()
            else:
                return None

    def start(self,roomnumber):
        #print 'name'
        name = self.getPageItems(roomnumber)
        name = name.replace("<h1>", "").replace("</h1>", "")
        return name
#get1 = getNum()
#get1.start()