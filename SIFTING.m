%function  SIFTING
close all
Image_00a = imread('Image_base_050.jpg');
%cropping original image
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);
% imwrite(IM,'SEQUENCE3/Image_00a.png');
middleP_Y = 1800+(750/2);
middleP_X = 2200+(500/2);
Image4rotation = Image_00a(middleP_X-1500:middleP_X+1500,middleP_Y-1500:middleP_Y+1500,1:3);
%create cell array to store rotated planes
rotatedIM = cell(1,18);
field = 'Rotation';
value = {};
for i = -45:5:45 
    ind = (i/5)+10;
    rotatedIM{ind} = imrotate(Image4rotation,i);
    middleP = 0.5*size(rotatedIM{ind});
    rotatedIM{ind} = rotatedIM{ind}(middleP(2)-250:middleP(2)+249,middleP(1)-375:middleP(1)+374,1:3);
    %now we have rotated image: rotatedIM{ind}. lets add noise and save 4 versions
    noiseLevels = [0 3 6 18];
    noiseLabels = ['a' ,'b', 'c', 'd'];
    for noise = 1:4
        NoisyIm = AddNoise(rotatedIM{ind},noiseLevels(noise));
        if (ind-1) < 10
            name = strcat('SEQUENCE3/','Image_','0',num2str(ind-1),noiseLabels(noise),'.png');
        else
            name = strcat('SEQUENCE3/','Image_',num2str(ind-1),noiseLabels(noise),'.png');
        end
%         imwrite(NoisyIm,name);
    end
    %now we can compute homography matrix
    value = [value; computeHomoRotation(i)];
end
%creating&saving struct with homographies
Sequence3Homographies = struct(field,value);
% save SEQUENCE3/Sequence3Homographies.mat Sequence3Homographies

% SEQUENCE 2 - zoom in
field = 'Scale';
value = {};
ind = 1;
for scale = 1.1:0.05:1.5
    I = ScaleCrop( IM, scale );
    name = strcat('SEQUENCE2/','Image_zoom_',num2str(100*(scale-1)),'%','.png');
%     imwrite(I,name);
    H = computeHomoScale(scale);
    value = [value; computeHomoScale(ind)];
    ind = ind +1;
end
Sequence2Homographies = struct(field,value);
% save SEQUENCE2/Sequence2Homographies.mat Sequence2Homographies

%% Projective
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);
d = 150;
tmp = Image_00a(2200:(2200+500-1),1800-d:(1800+750-1)+d,1:3);
pprime = [0 0; size(tmp, 2), 0; size(tmp, 2), size(tmp, 1); 0, size(tmp, 1)];
p = [0 0; size(tmp, 2), 0; size(tmp, 2)-d, size(tmp, 1); d, size(tmp, 1)];

% pprime = [-d 0; size(IM, 2)+d, 0; size(IM, 2)+d, size(IM, 1); -d, size(IM, 1)];
% p = [-d 0; size(IM, 2)+d, 0; size(IM, 2), size(IM, 1); 0, size(IM, 1)];

A = []; b=[];
for i = 1:4
    A = [A; pprime(i, 1), pprime(i,2), 1, 0, 0, 0, -p(i,1)*pprime(i,1), -p(i,1)*pprime(i, 2)];
    A = [A; 0, 0, 0, pprime(i, 1), pprime(i, 2), 1, -p(i,2)*pprime(i,1), -p(i,2)*pprime(i,2)];
    b = [b; p(i,1); p(i,2)];
end;
h = A\b;
h(9) = 1;
h = reshape(h, 3, 3);
tform = maketform('projective', h);
proj = imtransform(tmp, tform);
% figure, imshow(proj);
crop = proj(:, d:size(tmp,2)-d, :);

figure, imshow(IM), hold on;
scatter(320, 320, 'b*');
x = 320; y = 320;
newP = h*[x;y;1];
newP(:) = newP(:)/newP(3);
figure, imshow(proj), hold on;
scatter(newP(2), newP(1), 'b*');
scatter(newP(1), newP(2), 'bo');

