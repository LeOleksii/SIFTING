% Computes homography matrix for rotation keeping the coordinate system in
% the center.
function [tformCenteredRotation, outImage] = computeHomoRotation( image, theta )
    Rdefault = imref2d(size(image));
    tX = mean(Rdefault.XWorldLimits);
    tY = mean(Rdefault.YWorldLimits);
    tTranslationToCenterAtOrigin = [1 0 0; 0 1 0; -tX -tY,1];
    tRotation = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
    tTranslationBackToOriginalCenter = [1 0 0; 0 1 0; tX tY,1];
    tformCenteredRotation = tTranslationToCenterAtOrigin*tRotation*tTranslationBackToOriginalCenter;
    tformCenteredRotation = affine2d(tformCenteredRotation);
    outImage = imwarp(image, tformCenteredRotation);
end

