# [KBK:KBK:?] For now simply compute mace on first 3 images and test on the 4th

import os, re, mace

import scipy as sp
import numpy as np

from scipy import misc

imgsPerPerson = 4

# [KBK:KBK:?] Find out what threshold works. Want to fine tune threshold based on k-fold
macePSRThresh = 0

with open('lfw/peopleDevTrain.txt') as f:
    dataDirs = [[l.split()[0], int(l.split()[1])] for l in f.readlines()[1:]]
trainDirs = [i for i in dataDirs if i[1] >= imgsPerPerson]

# trainImgs = []
# for d in trainDirs:
#     pImgs = []
#     for i in range(imgsPerPerson):
#         pImgs.append(
#             misc.imresize(
#                 misc.imread('lfw/%s/%s_%04d.jpg'%(d[0], d[0], i+1), flatten=True),
#                 (50, 50)
#             )
#         )
#     trainImgs.append(pImgs)

trainImgs = []
for d in trainDirs:
    pImgs = []
    os.makedirs('lfw_gray/%s/'%d[0])
    for i in range(imgsPerPerson):
        misc.imsave(
            'lfw_gray/%s/%s_%04d.jpg'%(d[0], d[0], i+1),
            misc.imread('lfw/%s/%s_%04d.jpg'%(d[0], d[0], i+1), flatten=True)
        )

# maceFilts = [mace.trainMace(pplImgs) for pplImgs in trainImgs]

# maceMatches = []
# for mf in maceFilts:
#     for i in trainImgs:
#         maceMatches.append(                                  \
#             1 if mace.calculatePSR(                          \
#                      mace.applyMace(mf, i[imgsPerPerson-1])) \
#             > macePSRThresh else 0                           \
#         )
