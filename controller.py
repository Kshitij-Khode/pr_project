import os, re

import scipy as sp
import numpy as np

from scipy import misc

imgsPerPerson = 4

with open('lfw/peopleDevTrain.txt') as f:
    dataDirs = [[l.split()[0], int(l.split()[1])] for l in f.readlines()[1:]]
trainDirs = [i for i in dataDirs if i[1] >= imgsPerPerson]

trainImgs = []
for d in trainDirs:
    pImgs = []
    for i in range(imgsPerPerson):
        pImgs.append(misc.imread('lfw/%s/%s_%04d.jpg'%(d[0], d[0], i+1)))
    trainImgs.append(pImgs)
