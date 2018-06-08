#encoding: utf-8
import pickle
import Feature_selection

##  使用分类器

##默认选取前1000个特征  可修改
Feature_selection.number=1000

def extract_features(data):
    feat = []
    for i in data:
        me = Feature_selection.best_word_features_oat(i)
        feat.append(me)

    return feat
def get_p_n_words(strname):
    moto = [strname]
    moto_features = extract_features(moto) #把文本转化为特征表示的形式
    clf = pickle.load(open('classifier1.pkl')) #载入分类器
    pred = clf.prob_classify_many(moto_features)
    return pred   #积极率：str(i.prob('pos')) 消极率：str(i.prob('neg'))
