% Return an image after adding noise with a given standard deviation on the
% input image.
function I = addNoise( image,StandDeviation )
xmin = -StandDeviation;
xmax = StandDeviation;
%create noise for RGB channels
Noise = xmin+rand(size(image,1),size(image,2),size(image,3))*(xmax-xmin);
I = uint8(round(double(image) + Noise));
I(I<0) = 0;
I(I>255) = 255;
end

