%% Sequence 1
tic
load 'SEQUENCE1/Sequence1Homographies.mat'
H = Sequence1Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 1, noiseLabels(i), 2.0);
end;
toc

% figure, grid on, hold on;

%% Sequence 2
tic
load 'SEQUENCE2/Sequence2Homographies.mat'
H = Sequence2Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 2, noiseLabels(i), 5.0);
end;
toc
%% Sequence 3
tic
load 'SEQUENCE3/Sequence3Homographies.mat'
H = Sequence3Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 3, noiseLabels(i), 2.0);
end;
toc
