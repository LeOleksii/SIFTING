load SEQUENCE1/Sequence1Homographies
Image_00a = imread('SEQUENCE1/Image_00a.png');
Image_04a = imread('SEQUENCE1/Image_16a.png');
p_00 = [316 290 1];
p_04 = Sequence1Homographies(16).H * p_00';
p_04(:) = p_04(:)/p_04(3);
figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'b*');
figure; imshow(Image_04a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'b*');