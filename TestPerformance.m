% function [ curve ] = TestPerformance( H, directoryPath )

%this is for testing
directoryPath = 'SEQUENCE1';
H = load('SEQUENCE1/Sequence1Homographies');
%testing

str = strcat(directoryPath,'/*.png');
imagefiles = dir(str);   
names = {imagefiles(:).name};
for i = 1:length(names)
    names{i} = strcat(directoryPath,'/', names{i});
end
%create array which will store all noise levels names
names_cut = names(5:length(names));
NoisyNames = {};
for j = 1:4
    for k = j :4: length(names_cut)
        NoisyNames = [NoisyNames names_cut(k)];
    end
end
NoisyNames = reshape(NoisyNames,[length(names_cut)/4,4])';


%For each noise level compute the graph
for n=1:4
    %Finding locations of keypoints in original image    
    Chart = zeros(1,size(NoisyNames,2));
    imOrig = single(rgb2gray(imread(names{n})));
    locs = vl_sift(imOrig);
    OrigLocs = locs(1:2,:);
    OrigLocs = [OrigLocs;  ones(1, size(OrigLocs,2))];
    OrigLocs = OrigLocs';
     for images = 1:size(NoisyNames,2)
        name = char(NoisyNames(n,images));
        im = single(rgb2gray(imread(name)));
        locs = vl_sift(im);
        ImageKeys = locs(1:2,:);
        ImageKeys = ImageKeys';
        %ImageKeys = [ImageKeys  ones(size(ImageKeys,1),1)];
        %now lets apply homography on orig keys
        ModifOrigLocs = zeros(size(OrigLocs,1),size(OrigLocs,2));
        for k = 1: size(OrigLocs,1)
            ModifOrigLocs(k,:) = H.Sequence1Homographies(images).H * OrigLocs(k,:)';
            ModifOrigLocs(k,:) = ModifOrigLocs(k,:) ./ ModifOrigLocs(k,3);
        end
        ModifOrigLocs = ModifOrigLocs(:,1:2);
        
        figure, imshow(imOrig, []), hold on;
        plot(OrigLocs(:,1), OrigLocs(:,2), 'b.');
        figure, imshow(im, []), hold on;
        plot(ModifOrigLocs(:,1), ModifOrigLocs(:,2), 'go', 'MarkerSize', 15, 'MarkerFaceColor', [0, 1, 0]);
        plot(ImageKeys(:,1), ImageKeys(:,2), 'rd', 'MarkerSize', 10, 'MarkerFaceColor', [1, 0, 0]);
        %compare features
        Counter = 0;
        
        for comp = 1: size(ModifOrigLocs,1)
            point = ModifOrigLocs(comp,:);
            mindist = KeyDist( point, ImageKeys );
            if mindist < 5.0
                Counter = Counter +1;
            end            
        end
        h = 7;
     end
     

end


 
 
 
 

 
f = 5;

% end

