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

dx = [100, 150, 350,   0,   0,   0];
dy = [  0,   0,   0, 100, 150, 350];
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);
for k = 1:size(dx,2)
    p1 =      [     0, 0;       size(IM, 2),      0; size(IM, 2),       size(IM, 1);  0, size(IM, 1)];
    pprime1 = [-dx(k), 0; size(IM, 2)+dx(k), -dy(k); size(IM, 2), size(IM, 1)+dy(k);  0, size(IM, 1)];
    
    p2 =      [0,      0;  size(IM, 2), 0;       size(IM, 2), size(IM, 1);      0,       size(IM, 1)];
    pprime2 = [0, -dy(k);  size(IM, 2), 0; size(IM, 2)+dx(k), size(IM, 1); -dx(k), size(IM, 1)+dy(k)];

    h1 = fitgeotrans(p1, pprime1, 'projective');
    h1 = h1.T;
    tform1 = projective2d(h1);
    
    h2 = fitgeotrans(p2, pprime2, 'projective');
    h2 = h2.T;
    tform2 = projective2d(h2);

    R = imref2d(size(IM));
    
    % stretch top, stretch right
    proj = imwarp(IM, tform1, 'OutputView', R);
    figure, imshow(IM), hold on, title('Before 1');
    P = [304; 327; 1];
    scatter(P(1), P(2), 'b*');
    newP = h1'*P;
    newP(:) = newP(:)/newP(3);
    figure, imshow(proj), hold on, title('After 1');
    scatter(newP(1), newP(2), 'b*');
    
    % stretch bottom, stretch left
    proj = imwarp(IM, tform2, 'OutputView', R);
    figure, imshow(IM), hold on, title('Before 2');
    P = [304; 327; 1];
    scatter(P(1), P(2), 'b*');
    newP = h2'*P;
    newP(:) = newP(:)/newP(3);
    figure, imshow(proj), hold on, title('After 2');
    scatter(newP(1), newP(2), 'b*');
end;