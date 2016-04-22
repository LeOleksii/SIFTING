function homography = computeHomoRotation( A )
homography =   [cos(A) -sin(A) 0;
                sin(A)  cos(A) 0;
                 0 0 1];
end

