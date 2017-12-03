import os, re, mace
import scipy as sp
import numpy as np

from scipy import misc

casiaDir  = 'CASIA_gray'
casiaGDir = 'CASIA_gray'
casiaLoc  = '../data/%s/'%casiaDir
casiaGLoc = casiaLoc.replace(casiaDir,casiaGDir);

# if not os.path.exists(casiaGLoc): os.makedirs(casiaGLoc)
# for sdirs,dirs,files in os.walk(casiaLoc):
#     # for file in files:
#     #     labelDir = sdirs.replace(casiaDir,casiaGDir)
#     #     if not os.path.exists(labelDir): os.makedirs(labelDir)
#     #     filePath = os.path.join(sdirs,file);
#     #     misc.imsave(filePath.replace(casiaDir,casiaGDir), misc.imread(filePath, flatten=True))
#     #     print 'Converting:%s'%filePath
#     for dir in dirs:
#         for file in dir:
#             print file

min_i = 10000;
for root,dirs,files in os.walk(casiaLoc):
    for dir_i in dirs:
        for sroot,sdirs,sfiles in os.walk(os.path.join(casiaLoc,dir_i)):
            if len(sfiles) < min_i: min_i = len(sfiles)

print min_i
