import os, re, mace
import scipy as sp
import numpy as np

from scipy import misc

casiaDir  = 'CASIA_ultron_crop_112x96'
casiaGDir = 'CASIA_gray'
casiaLoc  = '../data/%s/'%casiaDir
casiaGLoc = casiaLoc.replace(casiaDir,casiaGDir);

if not os.path.exists(casiaGLoc): os.makedirs(casiaGLoc)
for sdirs,dirs,files in os.walk(casiaLoc):
    for file in files:
        labelDir = sdirs.replace(casiaDir,casiaGDir)
        if not os.path.exists(labelDir): os.makedirs(labelDir)
        filePath = os.path.join(sdirs,file);
        misc.imsave(filePath.replace(casiaDir,casiaGDir), misc.imread(filePath, flatten=True))
        print 'Converting:%s'%filePath