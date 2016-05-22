function percentage = computeMatches( H, sequenceNumber, noise, threshold )
% load 'SEQUENCE1/Sequence1Homographies.mat'
% H = Sequence1Homographies;
% sequenceNumber = 1;
% noise = 'a';
    n = size(H, 2);
    percentage = zeros(1, n);
    name = sprintf('SEQUENCE%d/Image_00%s.png',sequenceNumber, noise);
    original = single(rgb2gray(imread(name)));
    [fOrig, dOrig] = vl_sift(original);
    fOrig = fOrig(1:2, :);
    fOrig(3, :) = 1;
    for i = 1:n
        name = sprintf('SEQUENCE%d/Image_%02d%s.png',sequenceNumber, i, noise);
        im = single(rgb2gray(imread(name)));
        fOrigTransform = H(i).H*fOrig;
        for k = 1:size(fOrigTransform, 2)
            fOrigTransform(:,k) = fOrigTransform(:,k)/fOrigTransform(3,k);
        end;
        fOrigTransform = fOrigTransform(1:2,:);
        [fTrans, dTrans ]= vl_sift(im);
        fTrans = fTrans(1:2, :);
        [matches, scores] = vl_ubcmatch(dOrig, dTrans);
        counter = 0;
        for j = 1:size(matches, 2)
            xO = fOrigTransform(1, matches(1,j));
            yO = fOrigTransform(2, matches(1,j));
            xT = fTrans(1, matches(2,j));
            yT = fTrans(2, matches(2,j));
            dist = norm([xO-xT, yO-yT]);
            if dist < threshold
                counter = counter + 1;
            end;
        end;
        percentage(i) = counter/size(matches,2);
    end;
end

