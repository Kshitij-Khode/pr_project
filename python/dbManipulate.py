import os, re, shutil, random, multiprocessing

from joblib import Parallel, delayed
from scipy  import misc

casGDir   = 'CASIA_gray'
casGLoc   = '../data/%s/'%casGDir

def createGrayDB():
    if not os.path.exists(casiaGLoc): os.makedirs(casiaGLoc)
    for sdirs,dirs,files in os.walk(casiaLoc):
        for file in files:
            labelDir = sdirs.replace(casiaDir,casiaGDir)
            if not os.path.exists(labelDir): os.makedirs(labelDir)
            filePath = os.path.join(sdirs,file);
            misc.imsave(filePath.replace(casiaDir,casiaGDir), misc.imread(filePath, flatten=True))
            print 'Converting:%s'%filePath

def pruneDBMinImage(min_i=15, dbName='CASIA_gray_15'):
    for root,dirs,files in os.walk(casGLoc.replace(casGDir, dbName)):
        for dir_i in dirs:
            for sroot,sdirs,sfiles in os.walk(os.path.join(root,dir_i)):
                if len(sfiles) <= min_i:
                    shutil.rmtree(os.path.join(root,dir_i))
                    print 'Deleted:%s'%os.path.join(root,dir_i)

def createTrainDB(noOffiles=15, dbName='CASIA_gray_15'):
    if not os.path.exists('../data/CASIA_temp'): os.makedirs('../data/CASIA_temp')
    for root,dirs,files in os.walk(casGLoc.replace(casGDir, dbName)):
        for dir_i in dirs:
            dirIPath = os.path.join(root,dir_i).replace(dbName,'CASIA_temp')
            if not os.path.exists(dirIPath): os.makedirs(dirIPath)
            for sroot,sdirs,sfiles in os.walk(os.path.join(root,dir_i)):
                rfiles = random.sample(set(sfiles),noOffiles)
                for rf in rfiles:
                    shutil.copyfile(os.path.join(sroot,rf),os.path.join(sroot,rf).replace(dbName,'CASIA_temp'))
                    print 'Copied to:%s'%os.path.join(sroot,rf).replace(dbName,'CASIA_temp')

# num_cores = multiprocessing.cpu_count()
# Parallel(n_jobs=num_cores)(delayed(processInput)(i) for i in inputs)

# pruneDBMinImage(min_i=30, dbName='CASIA_gray_30')
createTrainDB(noOffiles=30, dbName='CASIA_gray_30')
