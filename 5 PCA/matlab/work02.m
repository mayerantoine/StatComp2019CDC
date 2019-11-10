%%% illustrate PCA
n = 100;
y1 = randn(n,2) * [10 0; 0 1];
theta = pi/4;
rotmat = [cos(theta) sin(theta); -sin(theta) cos(theta)];
y2 = y1 * rotmat; clf;
plot(y2(:,1), y2(:,2), 'o');
hold on;
plot([-15 15], [-15 15], 'r');
xlabel('X1')
ylabel('X2')
% print -depsc2 pcai01