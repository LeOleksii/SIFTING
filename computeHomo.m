function homography = computeHomo( A )
homography =   [cosd(A) -sind(A) 0;
                sind(A)  cosd(A) 0;
                 0 0 1];
end

