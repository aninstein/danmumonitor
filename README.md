# 通过弹幕分析主播行为
## 就是通过弹幕能够分析一些主播行为的偏向，色情淫秽、侮辱谩骂、血腥暴力、反动政治、其他
---
作者：13132208596@163.com
---

## 1、这玩意儿是我大三时候写的，这个代码也比较次
## 2、荡下来代码后，要跑起来步骤如下：
### （1）开发软件和环境：
#### 1）先搭好环境
- intellij idea
- pycharm
- tomcat8.5
- mysql
- 数据库可视化软件mysql navicat
- python2.7、java7
#### 2）百度一下：如何使用idea运行tomcat
- idea右上角的运行摁纽旁边的下拉框
- =》edit configurations
- =》弹出窗口的左上角的加号
- =》选择tomcat local
- =》点击左边的“configure”摁纽
- =》tomcat home选择你tomcat的解压目录
- =》底下的libraries要把tomcat安装目录下的lib文件夹里面的jsp-api.jar和servlet-api.jar加上
- =》确认，退回到上个窗口，就edit configurations那个窗口
- =》右下角的apply按钮上面有一个fix摁纽，这个是设置你网站打包方式的，随便起个名字就行，右边就是“\”不用改
#### 3）百度一下：如何用idea跑servlet项目
- file =》project structure =》modules
- 右边scope旁边那个“+”，选择library=》java
- 把<你的目录>\danmumonitor\web\WEB-INF\lib
- 和tomcat目录
- 添加进去，这时候servlet页面就不会报错了

#### 4）这时候用tomcat运行项目应该能弹出来登陆界面，当然数据库都没有自然不可能登陆

### （2）删除以下几个文件夹所有东西
- <你的目录>\danmumonitor\web\WEB-INF\classes
- <你的目录>\danmumonitor\out\artifacts
- <你的目录>\danmumonitor\out\production

### （3）更改数据库信息
#### 1）以下两个位置需要更改数据库信息的，主要是用户名密码：
- java连接数据库：<你的目录>\danmumonitor\src\jdbc.properties
- python连接数据库：<你的目录>\danmumonitor\danmusource\ssss.py

#### 2）运行数据库文件：
- 用navicat新建名叫dmmonitor的数据库
- 开启数据库后右击，运行以下文件：
  - <你的目录>\danmumonitor\dbscript\dmmonitor.sql
 
#### 3）数据库建好后重新把网站跑一下，就能登陆了，默认用户名密码是：
 - 用户名：li
 - 密码：li

怎么添加用户？抱歉，没有，懒得写了
### （4）python部分
 - 所有python代码都在<你的目录>\danmumonitor\danmusource
 - 用pycharm打开这个文件夹，修改ssss.py文件里面的数据库信息
 - 把相关的依赖装上，就只有numpy和nltk和jieba分词，还有操作数据库的MysqlClient
 - 直接右键运行ssss.py文件
 - 弹出的窗口中是以前监控过的主播房间号
 - 到斗鱼页面上，寻找一个正在直播的房间号
 - 粘贴到弹出的窗口上，这玩意儿挺耗资源的，所以建议就只监控一个主播
 - 然后控制台就会输出主播弹幕内容和分析结果
 
### （5）建议先跑起来python再打开网页
### （6）页面使用步骤：
- 运行python部分代码
- 跑起来网站
- 登陆 》主页 》 主播列表 》刷新（不刷新没有新监控的主播） 》 找到刚才监控的那个主播 》点击主播列表的名字会跳到个人监控页面
- 点击打开房间，把房间放小了，诶就可以装逼展示了
 
 
 