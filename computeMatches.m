function percentage = computeMatches( H, sequenceNumber, noise, threshold )
    n = size(H, 2);
    percentage = zeros(1, n);
    name = sprintf('SEQUENCE%d/Image_00%s.png',sequenceNumber, noise);
    original = single(rgb2gray(imread(name)));
    fOrig = vl_sift(original);
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
        fTrans = vl_sift(im);
        fTrans = fTrans(1:2, :);
        counter = 0;
        for k = 1:size(fTrans, 2)
            for t = 1:size(fOrigTransform, 2)
                dist = norm(fTrans(:,k)-fOrigTransform(:,t));
                if dist < threshold
                    counter = counter + 1;
                end;
            end;
        end;
        percentage(i) = counter/size(fTrans, 2);
    end;
end

