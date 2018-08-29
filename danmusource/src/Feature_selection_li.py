#encoding: utf-8
import pickle
from nltk.probability import FreqDist, ConditionalFreqDist
import itertools
from nltk.metrics import BigramAssocMeasures
from nltk.collocations import BigramCollocationFinder
#语句分词
###############################
#特征提取
###############################
#1. 把所有词作为特征
def bag_of_words(words):
    return dict([(word, True) for word in words])

#2. 把双词搭配（bigrams）作为特征      beta 1.0
def bigram(words, score_fn=BigramAssocMeasures.chi_sq, n=1500):
    bigram_finder = BigramCollocationFinder.from_words(words)  #把文本变成双词搭配的形式-------
    bigrams = bigram_finder.nbest(score_fn, n) #使用了卡方统计的方法，选择排名前1000的双词
    return bag_of_words(bigrams)

#3. 把所有词和双词搭配一起作为特征
def bigram_words(words, score_fn=BigramAssocMeasures.chi_sq, n=1500):
    bigram_finder = BigramCollocationFinder.from_words(words)
    bigrams = bigram_finder.nbest(score_fn, n)# -------------------
    return bag_of_words(words + bigrams)  #所有词和（信息量大的）双词搭配一起作为特征

###############################
#特征选择
###############################
#1. 计算出整个语料里面每个词的信息量
#2. 根据信息量进行倒序排序，选择排名靠前的信息量的词
#3. 把这些词作为特征
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

pos = get_word("pos.txt")
neg = get_word("neg.txt")

number = 1000
#1. 计算出整个语料里面每个词的信息量
#1.1 计算出整个语料里面每个词的信息量
def create_word_scores():
    posWords = get_word('pos.txt')
    negWords = get_word('neg.txt')
    posWords = list(itertools.chain(*posWords))  # 把多维数组解链成一维数组
    negWords = list(itertools.chain(*negWords))  # 同理
    word_fd = FreqDist()  # 可统计所有词的词频
    cond_word_fd = ConditionalFreqDist()  # 可统计积极文本中的词频和消极文本中的词频
    for word in posWords:
        word_fd[word] += 1
        cond_word_fd['pos'][word] += 1
    for word in negWords:
        word_fd[word] += 1
        cond_word_fd['neg'][word] += 1
    pos_word_count = cond_word_fd['pos'].N()  # 积极词的数量
    neg_word_count = cond_word_fd['neg'].N()  # 消极词的数量
    total_word_count = pos_word_count + neg_word_count
    word_scores = {}
    for word, freq in word_fd.iteritems():
        pos_score = BigramAssocMeasures.chi_sq(cond_word_fd['pos'][word], (freq, pos_word_count),total_word_count)  # 计算积极词的卡方统计量，这里也可以计算互信息等其它统计量
        neg_score = BigramAssocMeasures.chi_sq(cond_word_fd['neg'][word], (freq, neg_word_count),total_word_count)  # 同理
        word_scores[word] = pos_score + neg_score  # 一个词的信息量等于积极卡方统计量加上消极卡方统计量
    return word_scores     #包括了每个词和这个词的信息量

#1.2 计算整个语料里面每个词和双词搭配的信息量
def create_word_bigram_scores():
    posdata = get_word('pos.txt')
    negdata = get_word('neg.txt')
    posWords = list(itertools.chain(*posdata))
    negWords = list(itertools.chain(*negdata))
    posbigram_finder = BigramCollocationFinder.from_words(posWords)
    negbigram_finder = BigramCollocationFinder.from_words(negWords)
    posBigrams = posbigram_finder.nbest(BigramAssocMeasures.chi_sq, number)
    negBigrams = negbigram_finder.nbest(BigramAssocMeasures.chi_sq, number)
    pos = posWords + posBigrams #词和双词搭配
    neg = negWords + negBigrams
    word_fd = FreqDist()
    cond_word_fd = ConditionalFreqDist()
    for word in pos:
        word_fd[word] += 1
        cond_word_fd['pos'][word] += 1
    for word in neg:
        word_fd[word] += 1
        cond_word_fd['neg'][word] += 1
    pos_word_count = cond_word_fd['pos'].N()
    neg_word_count = cond_word_fd['neg'].N()
    total_word_count = pos_word_count + neg_word_count
    word_scores = {}
    for word, freq in word_fd.items():
    	pos_score = BigramAssocMeasures.chi_sq(cond_word_fd['pos'][word], (freq, pos_word_count), total_word_count)
    	neg_score = BigramAssocMeasures.chi_sq(cond_word_fd['neg'][word], (freq, neg_word_count), total_word_count)
    	word_scores[word] = pos_score + neg_score
    return word_scores

#2. 根据信息量进行倒序排序，选择排名靠前的信息量的词
def find_best_words(word_scores):
    #把词按信息量倒序排序  number是特征的维度，是可以不断调整的
    best_vals = sorted(word_scores.items(),key=lambda x:x[1],reverse=True)[:number]
    best_words = set([w for w,s in best_vals])
    return best_words

#3. 计算信息量丰富的词，并以此作为分类特征
def best_word_features(words):
    word_scores_1 = create_word_scores()
    best_words = find_best_words(word_scores_1,number)
    return dict([(word,True) for word in words if word in best_words])

#3. 计算信息量丰富的词和双词搭配，并以此作为特征
def best_word_features_oat(words):
    word_scores_1 = create_word_bigram_scores()
    best_words = find_best_words(word_scores_1)
    return dict([(word,True) for word in words if word in best_words])
























