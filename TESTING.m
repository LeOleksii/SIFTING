load SEQUENCE2/Sequence2Homographies
Image_00a = imread('SEQUENCE2/Image_00a.png');
Image_04a = imread('SEQUENCE2/Image_09a.png');
p_00 = [303 356 1];
% for i = 1:19
p_04 = Sequence2Homographies(9).H * p_00';
p_04(:) = p_04(:)/p_04(3);
figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'b*');
figure; imshow(Image_04a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'b*');
% end;



