function  SIFTING
close all
Image_00a = imread('Image_base_050.jpg');
IM = Image_00a(2200:(2200+500),1800:(1800+750),1:3);
middleP_Y = 1800+(750/2);
middleP_X = 2200+(500/2);
Image4rotation = Image_00a(middleP_X-1500:middleP_X+1500,middleP_Y-1500:middleP_Y+1500,1:3);
imshow(IM);
figure();
imshow(Image4rotation);
rotatedIM = cell(1,18);
for i = 315:5:405    
    rotatedIM{i} = imrotate(Image4rotation,i);
    middleP = 0.5*size(rotatedIM{i});
    rotatedIM{i} = rotatedIM{i}(middleP(2)-250:middleP(2)+250,middleP(1)-375:middleP(1)+375,1:3);
    imshow(rotatedIM{i});
end

