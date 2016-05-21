Image_00a = imread('Image_base_050.jpg');
IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);

middleP_Y = 1800+(750/2);
middleP_X = 2200+(500/2);
Image4rotation = Image_00a(middleP_X-1500+1:middleP_X+1500,middleP_Y-1500+1:middleP_Y+1500,1:3);

angle = -45;
[~, outBig, RoutBig] = computeHomoRotation(Image4rotation, angle);
tformCenteredRotation = computeHomoRotation(IM, angle);

Rim = imref2d(size(outBig));
dX = mean(Rim.XWorldLimits);
dY = mean(Rim.YWorldLimits);
rotatedIM = outBig(dX-250:dX+249,dY-375:dY+374,1:3);

P = [250; 250; 1];
figure, imshow(IM), hold on;
plot(P(1), P(2), 'g*');
newP = tformCenteredRotation.T'*P;
newP(:) = newP(:)/newP(3);
figure, imshow(rotatedIM), hold on;
plot(newP(1), newP(2), 'g*');

