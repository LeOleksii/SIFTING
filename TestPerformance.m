%% Sequence 1
tic
load 'SEQUENCE1/Sequence1Homographies.mat'
H = Sequence1Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
percentageM = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 1, noiseLabels(i), 1.0);
    percentageM(i,:) = siftModificationPerformance(H, 1, noiseLabels(i), 1.0);
end;
toc

% figure, grid on, hold on;

%% Sequence 2
tic
load 'SEQUENCE2/Sequence2Homographies.mat'
H = Sequence2Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
percentageM = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 2, noiseLabels(i), 1.0);
    percentageM(i,:) = siftModificationPerformance(H, 2, noiseLabels(i), 1.0);
end;
scales = zeros(1, size(H,2));
t = 1;
for i = 1.1:0.05:1.5
    scales(t) = i;
    t = t+1;
end;
figure, grid on, axis([1.1,1.5,0,1.2]), hold on;
a = plot(scales(:), percentage(1, :), 'bo-', 'MarkerFaceColor', [0, 0, 1], 'LineWidth', 2);
b = plot(scales(:), percentage(2, :), 'gd-', 'MarkerFaceColor', [0, 1, 0], 'LineWidth', 2);
c = plot(scales(:), percentage(3, :), 'rs-', 'MarkerFaceColor', [1, 0, 0], 'LineWidth', 2);
d = plot(scales(:), percentage(4, :), 'kh-', 'MarkerFaceColor', [0, 0, 0], 'LineWidth', 2);
legend([a, b, c, d], 'Noise: 0', 'Noise: 3', 'Noise: 6', 'Noise: 18', 'Location','SouthEast');
toc
%% Sequence 3
tic
load 'SEQUENCE3/Sequence3Homographies.mat'
H = Sequence3Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
percentageM = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 3, noiseLabels(i), 2.0);
    percentageM(i,:) = siftModificationPerformance(H, 3, noiseLabels(i), 1.0);
end;
toc