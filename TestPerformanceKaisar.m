%% Sequence 1
tic
load 'SEQUENCE1/Sequence1Homographies.mat'
H = Sequence1Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 1, noiseLabels(i), 2.0);
end;

scales = zeros(1, size(H,2));
t = 1;
for i = 1:1:16
    scales(t) = i;
    t = t+1;
end;
%scales = [100 150 200 300 100 150 200 300 100 150 200 300 100 150 200 300];
figure, grid on, axis([1,16,0.5,1.2]), hold on;
a = plot(scales(:), percentage(1, :), 'bo-', 'MarkerFaceColor', [0, 0, 1], 'LineWidth', 2);
b = plot(scales(:), percentage(2, :), 'gd-', 'MarkerFaceColor', [0, 1, 0], 'LineWidth', 2);
c = plot(scales(:), percentage(3, :), 'rs-', 'MarkerFaceColor', [1, 0, 0], 'LineWidth', 2);
d = plot(scales(:), percentage(4, :), 'kh-', 'MarkerFaceColor', [0, 0, 0], 'LineWidth', 2);
legend([a, b, c, d], 'Noise: 0', 'Noise: 3', 'Noise: 6', 'Noise: 18', 'Location','SouthEast');
%%%MODIFY TICK LABEL HERE
ax.XTickLabel = {100, 150, 200, 300, 100, 150, 200, 300, 100, 150, 200, 300, 100, 150, 200, 300};
xlabel('Zoom ratio, %');
ylabel('Correctly matched, %');
toc

% figure, grid on, hold on;

%% Sequence 2
tic
load 'SEQUENCE2/Sequence2Homographies.mat'
H = Sequence2Homographies;
noiseLabels = ['a', 'b', 'c', 'd'];
percentage = zeros(4, size(H,2));
for i = 1:4
    percentage(i,:) = computeMatches(H, 2, noiseLabels(i), 1.0);
end;
scales = zeros(1, size(H,2));
t = 1;
for i = 110:5:150
    scales(t) = i;
    t = t+1;
end;
figure, grid on, axis([110,150,0.8,1.2]), hold on;
a = plot(scales(:), percentage(1, :), 'bo-', 'MarkerFaceColor', [0, 0, 1], 'LineWidth', 2);
b = plot(scales(:), percentage(2, :), 'gd-', 'MarkerFaceColor', [0, 1, 0], 'LineWidth', 2);
c = plot(scales(:), percentage(3, :), 'rs-', 'MarkerFaceColor', [1, 0, 0], 'LineWidth', 2);
d = plot(scales(:), percentage(4, :), 'kh-', 'MarkerFaceColor', [0, 0, 0], 'LineWidth', 2);
legend([a, b, c, d], 'Noise: 0', 'Noise: 3', 'Noise: 6', 'Noise: 18', 'Location','SouthEast');
xlabel('Zoom ratio, %');
ylabel('Correctly matched, %');
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

scales = zeros(1, size(H,2));
t = 1;
for i = -45:5:45
    scales(t) = i;
    t = t+1;
end;

figure, grid on, axis([-45,45,0.8,1.2]), hold on;
a = plot(scales(:), percentage(1, :), 'bo-', 'MarkerFaceColor', [0, 0, 1], 'LineWidth', 2);
b = plot(scales(:), percentage(2, :), 'gd-', 'MarkerFaceColor', [0, 1, 0], 'LineWidth', 2);
c = plot(scales(:), percentage(3, :), 'rs-', 'MarkerFaceColor', [1, 0, 0], 'LineWidth', 2);
d = plot(scales(:), percentage(4, :), 'kh-', 'MarkerFaceColor', [0, 0, 0], 'LineWidth', 2);
legend([a, b, c, d], 'Noise: 0', 'Noise: 3', 'Noise: 6', 'Noise: 18', 'Location','SouthEast');
xlabel('Rotation angle, degrees');
ylabel('Correctly matched, %');
toc
f=5;