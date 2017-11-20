import numpy as np

def trainMace(imgs):
    fftImgs  = np.fft.fft2(imgs)
    (c, s)   = fftImgs[0].shape[0]*fftImgs[0].shape[1]
    fftImgs  = [i.reshape((c*s, 1)) for i in fftImgs]
    dFftImgs = [np.diag(np.square(np.absolute(i))) for i in fftImgs]
    d        = np.zeros((c*s, 1))

    for dI in dFftImgs:
        d = np.add(d, dI)

    u   = np.ones((len(imgs), 1))
    mf0 = np.dot(np.linalg.inv(d), fftImgs)
    mf1 = np.dot(np.transpose(fftImgs), np.linalg.inv(d))
    mf1 = np.dot(mf1, fftImgs)
    maceFilt = np.dot(mf0, mf1)
    maceFilt = np.dot(maceFilt, u).reshape(c, s)

    return maceFilt