import os, re, mace
import scipy as sp
import numpy as np

from scipy import misc

casiaDir  = 'CASIA_test'
casiaGDir = 'CASIA_gray'
casiaLoc  = '../data/%s/'%casiaDir
casiaGLoc = casiaLoc.replace(casiaDir,casiaGDir);

dir_count = []
for root, dirs, files in os.walk(casiaLoc):
    for d in dirs:
        a = str(d)
        count = 0
        for fi in files:
            count += 1
        y = (a, count)
        dir_count.append(y)

print min(dir_count)