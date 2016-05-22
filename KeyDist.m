function mindist = KeyDist( point, array )
dist = zeros(size(array,1),1);
for i=1:size(array,1)
    dist(i) = norm(point - array(i,:));
end
mindist = min(dist);
end

