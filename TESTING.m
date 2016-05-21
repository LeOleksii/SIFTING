load SEQUENCE3/Sequence3Homographies
Image_00a = imread('SEQUENCE3/Image_00a.png');
Image_04a = imread('SEQUENCE3/Image_04a.png');
p_00 = [316 290 1];
% for i = 1:19
p_04 = Sequence3Homographies(4).H * p_00';
p_04(:) = p_04(:)/p_04(3);
figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'b*');
figure; imshow(Image_04a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'b*');
% end;



