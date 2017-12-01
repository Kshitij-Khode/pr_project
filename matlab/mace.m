function maceFilt = mace(classPics,u)

[picH, picW, noOfPics] = size(classPics);
faceFFTMat = fft2(classPics);
faceFFTVec = reshape(faceFFTMat, [picH*picW noOfPics]);
faceX2Vec  = arrayfun(@(x)abs(x)^2, faceFFTVec);
dMat       = zeros(size(faceFFTVec,1), size(faceFFTVec,1));
for image = 1:size(faceX2Vec,2)
    dMat = dMat + diag(faceX2Vec(:,image));
end
maceFilt = inv(dMat)*faceFFTVec*inv(faceFFTVec'*inv(dMat)*faceFFTVec)*u;
maceFilt = reshape(maceFilt, [picH picW]);

end