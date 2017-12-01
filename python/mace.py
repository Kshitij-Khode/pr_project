import numpy as np

def trainMace(imgs):
    imgDim   = imgs[0].shape
    fftImgs  = np.fft.fft2(imgs)
    fftImgs  = [i.flatten() for i in fftImgs]
    dFftImgs = [np.diag(np.square(np.absolute(i))) for i in fftImgs]
    d        = np.zeros(dFftImgs[0].shape)
    fftImgs  = np.transpose(fftImgs);

    for dI in dFftImgs:
        d = np.add(d, dI)

    u   = np.ones(len(imgs))
    mf0 = np.dot(np.linalg.inv(d), fftImgs)
    mf1 = np.dot(np.transpose(fftImgs), np.linalg.inv(d))
    mf1 = np.dot(mf1, fftImgs)
    maceFilt = np.dot(mf0, mf1)
    maceFilt = np.dot(maceFilt, u).reshape()

    return maceFilt

def applyMace(maceFilt, img):
    return np.real(
               np.fft.fftshift(
                   np.fft.ifft2(
                       np.multiply(maceFilt, np.conj(np.fft.fft2(img))))))

def calculatePSR(maceResp):
    (r, c)   = maceResp.shape
    maceResp = maceResp.reshape((r*c, 1))

    return (np.amax(maceResp) - np.mean(maceResp))/np.var(maceResp)
