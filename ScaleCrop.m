function I = ScaleCrop( image, scale )
    B = imresize(image,scale);
    Center = 0.5*size(B);
    xmin = round(Center(1) - size(image,1)/2)+1;
    ymin = round(Center(2) - size(image,2)/2)+1;
    xmax = xmin + size(image,1)-1;
    ymax = ymin + size(image,2)-1;
    I = B(xmin:xmax,ymin:ymax,1:3);
end

