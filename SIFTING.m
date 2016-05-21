%function  SIFTING
% original image
Image_00a = imread('Image_base_050.jpg');
%% SEQUENCE 3 - rotation
%cropping original image
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);

middleP_Y = 1800+(750/2);
middleP_X = 2200+(500/2);
Image4rotation = Image_00a(middleP_X-1500+1:middleP_X+1500,middleP_Y-1500+1:middleP_Y+1500,1:3);

noiseLevels = [0 3 6 18];
noiseLabels = ['a' ,'b', 'c', 'd'];

for noise = 1:4
    NoisyIm = AddNoise(IM, noiseLevels(noise));
    name = strcat('SEQUENCE3/','Image_00',noiseLabels(noise),'.png');
    imwrite(NoisyIm,name);
end
ind = 0;
field = 'H';
value = {};
for angle = -45:5:45
    ind = ind + 1;
    [~, outBig, RoutBig] = computeHomoRotation(Image4rotation, angle);
    tformCenteredRotation = computeHomoRotation(IM, angle);
    value{ind} = tformCenteredRotation.T';
    Rim = imref2d(size(outBig));
    dX = mean(Rim.XWorldLimits);
    dY = mean(Rim.YWorldLimits);
    rotatedIM = outBig(dX-250:dX+249,dY-375:dY+374,1:3);
    for noise = 1:4
        NoisyIm = AddNoise(rotatedIM, noiseLevels(noise));
        name = strcat('SEQUENCE3/','Image_',sprintf('%02d',ind),noiseLabels(noise),'.png');
        imwrite(NoisyIm,name);
    end;
end;
%creating&saving struct with homographies
Sequence3Homographies = struct(field,value);
save SEQUENCE3/Sequence3Homographies.mat Sequence3Homographies

%% SEQUENCE 2 - scaling
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);
field = 'H';
value = {};
noiseLevels = [0 3 6 18];
noiseLabels = ['a' ,'b', 'c', 'd'];
for noise = 1:4
    NoisyIm = AddNoise(IM,noiseLevels(noise));
    name = strcat('SEQUENCE2/','Image_00',noiseLabels(noise),'.png');
    imwrite(NoisyIm,name);
end
ind = 1;
for scale = 1.1:0.05:1.5
    I = ScaleCrop( IM, scale );
    for noise = 1:4
        NoisyIm = AddNoise(I,noiseLevels(noise));
        name = strcat('SEQUENCE2/','Image_',sprintf('%02d',ind),noiseLabels(noise),'.png');
        imwrite(NoisyIm,name);
    end;
    H = computeHomoScale(scale);
    value = [value; computeHomoScale(ind)];
    ind = ind +1;
end
Sequence2Homographies = struct(field,value);
save SEQUENCE2/Sequence2Homographies.mat Sequence2Homographies

%% SEQUENCE 1 - tilting (projective transformation)
dx = [100, 150, 200, 300,   0,   0,   0,   0];
dy = [  0,   0,   0    0, 100, 150, 200, 300];
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);
field = 'H';
value = {};
noiseLevels = [0 3 6 18];
noiseLabels = ['a' ,'b', 'c', 'd'];
for noise = 1:4
    NoisyIm = AddNoise(IM,noiseLevels(noise));
    name = strcat('SEQUENCE1/','Image_00',noiseLabels(noise),'.png');
    imwrite(NoisyIm,name);
end
for k = 1:size(dx,2)    
    p =      [     0, 0;       size(IM, 2),      0; size(IM, 2),       size(IM, 1);  0, size(IM, 1)];
    pprime1 = [-dx(k), 0; size(IM, 2)+dx(k), -dy(k); size(IM, 2), size(IM, 1)+dy(k);  0, size(IM, 1)];
    pprime2 = [0, -dy(k);  size(IM, 2), 0; size(IM, 2)+dx(k), size(IM, 1); -dx(k), size(IM, 1)+dy(k)];
    
    h1 = fitgeotrans(p, pprime1, 'projective');
    h1 = h1.T;
    value{k} = h1';
    tform1 = projective2d(h1);
    
    h2 = fitgeotrans(p, pprime2, 'projective');
    h2 = h2.T;
    value{k+8} = h2';
    tform2 = projective2d(h2);
    R = imref2d(size(IM));
    % stretch top, stretch right
    proj1 = imwarp(IM, tform1, 'OutputView', R);
    % stretch bottom, stretch left
    proj2 = imwarp(IM, tform2, 'OutputView', R);
    
    for noise = 1:4
        NoisyIm1 = AddNoise(proj1,noiseLevels(noise));
        NoisyIm2 = AddNoise(proj2,noiseLevels(noise));
        name1 = strcat('SEQUENCE1/','Image_',sprintf('%02d',k),noiseLabels(noise),'.png');
        name2 = strcat('SEQUENCE1/','Image_',sprintf('%02d',k+8),noiseLabels(noise),'.png');
        imwrite(NoisyIm1,name1);
        imwrite(NoisyIm2,name2);
    end;
    
end;
Sequence1Homographies = struct(field,value);
save SEQUENCE1/Sequence1Homographies.mat Sequence1Homographies
