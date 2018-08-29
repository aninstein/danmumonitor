# -*- coding:utf-8 -*-
#生成分类器
import Feature_selection_li #引入
import pickle
from nltk.classify.scikitlearn import SklearnClassifier
from sklearn.svm import SVC, LinearSVC, NuSVC
from sklearn.naive_bayes import MultinomialNB, BernoulliNB
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

#1.载入数据
def get_word(filename):
    list_sum = []
    f = open(filename, 'r')
    for ou_line in f:
        list_now = []
        #ou_line = ou_line.decode("gbk")
        ou_line = ou_line.rstrip().lstrip().strip()
        for word in ou_line:
            list_now.append(word)
        list_sum.append(list_now)
    return list_sum

pos_review = get_word('pos00.txt')
neg_review = get_word('neg00.txt')
#2.使积极文本的数量和消极的文本的数量一样
sumnum = 500
pos = pos_review[:sumnum]
neg = neg_review[:sumnum]

#3.第三步，赋予类标签。
def pos_features(feature_extraction_method):
    posFeatures = []
    for i in pos:
        posWords = [feature_extraction_method(i),'pos'] #为积极文本赋予"pos"
        posFeatures.append(posWords)
    return posFeatures

def neg_features(feature_extraction_method):
    negFeatures = []
    for j in neg:
        negWords = [feature_extraction_method(j),'neg'] #为消极文本赋予"neg"
        negFeatures.append(negWords)
    return negFeatures


##################
#三、分类器及其准确度
##################
##默认选取前1000个特征  可修改
Feature_selection_li.number=1000
####计算信息量丰富的词和双词搭配，并以此作为特征
posFeatures = pos_features(Feature_selection_li.best_word_features_oat)#手机非常好用  “手机”“非常”/“非常”“好用”
negFeatures = neg_features(Feature_selection_li.best_word_features_oat)

####计算信息量丰富的词，并以此作为分类特征
#posFeatures = pos_features(Feature_selection.best_word_features)
#negFeatures = neg_features(Feature_selection.best_word_features)

##### 使用所有词作为特征
#posFeatures = pos_features(Feature_selection.bag_of_words)
#negFeatures = neg_features(Feature_selection.bag_of_words)

##### 使用双词作为特征(有问题，除数不能为0)
#posFeatures = pos_features(Feature_selection.bigram)
#negFeatures = neg_features(Feature_selection.bigram)

# 4.第四步、把特征化之后的数据数据分割为开发集和测试集
table1 = int(sumnum * 0.2)
table2 = int(sumnum-(sumnum * 0.64))
train = posFeatures[table2:] + negFeatures[table2:]
devtest = posFeatures[table1:table2] + negFeatures[table1:table2]
testSet = posFeatures[:table1] + negFeatures[:table1]
# 这里把前124个数据作为测试集，中间50个数据作为开发测试集，最后剩下的大部分数据作为训练集。

# 1.一、分割人工标注的标签和数据
dev, tag_dev = zip(*devtest)
#二到四、可以用一个函数来做
def score(classifier):
    ####
    classifier = SklearnClassifier(classifier) #在nltk 中使用scikit-learn 的接口
    classifier.train(train) #训练分类器
    #pred = classifier.classify_many(devtest) #对开发测试集的数据进行分类，给出预测的标签
    pred = classifier.classify_many(dev) #对开发测试集的数据进行分类，给出预测的标签
    return accuracy_score(tag_dev, pred) #对比分类预测结果和人工标注的正确结果，给出分类器准确度

###使用测试集测试分类器的最终效果
test, tag_test = zip(*testSet)
def final_score(classifier):
    classifier = SklearnClassifier(classifier)
    classifier.train(train)
    pred_1 = classifier.classify_many(test)
    return accuracy_score(tag_test, pred_1)


trainSet = posFeatures + negFeatures

BernoulliNB_classifier = SklearnClassifier(BernoulliNB())
BernoulliNB_classifier.train(trainSet)
pickle.dump(BernoulliNB_classifier, open('classifier1.pkl','wb+'))
def getgood():
    print('BernoulliNB`s accuracy is %f' % score(BernoulliNB()))
    print(final_score(BernoulliNB()))  # 使用开发集中得出的最佳分类器
    print('MultinomiaNB`s accuracy is %f' % score(MultinomialNB()))
    print(final_score(MultinomialNB()))
    print('LogisticRegression`s accuracy is %f' % score(LogisticRegression()))
    print(final_score(LogisticRegression()))
    print('SVC`s accuracy is %f' % score(SVC()))
    print(final_score(SVC()))
    print('LinearSVC`s accuracy is %f' % score(LinearSVC()))
    print(final_score(LinearSVC()))
    print('NuSVC`s accuracy is %f' % score(NuSVC()))
    print(final_score(NuSVC()))

print('BernoulliNB`s accuracy is %f' %score(BernoulliNB()))
print(final_score(BernoulliNB())) #使用开发集中得出的最佳分类器
print('MultinomiaNB`s accuracy is %f' %score(MultinomialNB()))
print(final_score(MultinomialNB()))
print('LogisticRegression`s accuracy is %f' %score(LogisticRegression()))
print(final_score(LogisticRegression()))
print('SVC`s accuracy is %f' %score(SVC()))
print(final_score(SVC()))
print('LinearSVC`s accuracy is %f' %score(LinearSVC()))
print(final_score(LinearSVC()))
print('NuSVC`s accuracy is %f' %score(NuSVC()))
print(final_score(NuSVC()))





















