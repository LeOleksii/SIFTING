function [ curve ] = TestPerformance( H, directoryPath )
%this is for testing
directoryPath = 'SEQUENCE1';
H = load('D:\VIBOT\VISUAL_PERCEPTION\lab4_final\SIFTING\SEQUENCE1\Sequence1Homographies');
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
    [~, ~, locs] = sift(names{n});
    OrigLocs = locs(:,1:2);   
    OrigLocs = [OrigLocs  ones(size(OrigLocs,1),1)];
    
     for images = 1:size(NoisyNames,2)
        name = char(NoisyNames(n,images));
        [~, ~, locs] = sift(name);
        ImageKeys = locs(:,1:2);
        %ImageKeys = [ImageKeys  ones(size(ImageKeys,1),1)];
        %now lets apply homography on orig keys
        ModifOrigLocs = zeros(size(OrigLocs,1),size(OrigLocs,2));
        for k = 1: size(OrigLocs,1)
            ModifOrigLocs(k,:) = H.Sequence1Homographies(images).H * OrigLocs(k,:)';
            ModifOrigLocs(k,:) = ModifOrigLocs(k,:) ./ ModifOrigLocs(k,3);
        end
        ModifOrigLocs = ModifOrigLocs(:,1:2);
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

end

