function I = AddNoise( image,StandDeviation )
xmin = -StandDeviation;
xmax = StandDeviation;
%create noise for RGB channels
Noise = xmin+rand(size(image,1),size(image,2),size(image,3))*(xmax-xmin);
I = uint8(round(double(image) + Noise));
I(I<0) = 0;
I(I>255) = 255;
end

