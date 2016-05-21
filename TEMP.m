Image_00a = imread('Image_base_050.jpg');

IM = Image_00a(2200:(2200+500-1),1800:(1800+750-1),1:3);

oRef = imref2d(size(IM));

scale = 1.5;

[height, width, ~] = size(IM);

tx = width*scale - width;
ty = height*scale-height;

h = [scale 0 0;
     0 scale 0;
     -tx/2 -ty/2 1];

tform = affine2d(h);
scaled = imwarp(IM, tform, 'OutputView', oRef);

figure, imshow(IM), hold on;
P = [303; 326; 1];
plot(P(1), P(2), 'g*');
newP = tform.T'*P;
newP(:) = newP(:)/newP(3);
figure, imshow(scaled), hold on;
plot(newP(1), newP(2), 'g*');

