%%% The data file 'd_swap.txt' contains the following daily swap
%%% rates from 7/3/2000 to 7/15/2005.
%%%     swp1y  swp2y   swp3y   sw4y    sw5y    sw7y    sw10y   sw30y

%%% read the data file and get the data matrix
data = load('d_swap.txt');

%%% plot the time series
plotmargin = 50;
plot(data(:, 1), 'b');	hold on;
plot(data(:, 2), 'g');  plot(data(:, 3), 'r');  plot(data(:, 4), 'c');
plot(data(:, 5), 'm');  plot(data(:, 6), 'y');  plot(data(:, 7), 'k');
plot(data(:, 8), 'b:');	hold off;  legend off;
xlim([1-plotmargin, 1257+plotmargin]);
ylim([0.9, 7.50]);		grid off;
set(gca, 'Xtick', [2, 210, 419, 628, 837, 1046, 1257]);
set(gca, 'XtickLabel', ['07/05/00'; '05/03/01'; '03/11/02'; '01/09/03';...
	'11/07/03'; '09/10/04'; '07/15/05']);
legend('swp1y', 'swp2y', 'swp3y', 'swp4y','swp5y', 'swp7y', ...
        'swp10y', 'swp30y');
%print -depsc2 dswap01

%%% Take difference
ddata=diff(data);
plotmargin = 50;
plot(ddata(:, 1), 'b');	hold on;
plot(ddata(:, 2), 'g');  plot(ddata(:, 3), 'r');  plot(ddata(:, 4), 'c');
plot(ddata(:, 5), 'm');  plot(ddata(:, 6), 'y');  plot(ddata(:, 7), 'k');
plot(ddata(:, 8), 'b:');	hold off;  legend off;
xlim([1-plotmargin, 1257+plotmargin]);
set(gca, 'Xtick', [1, 210, 419, 628, 837, 1046, 1256]);
set(gca, 'XtickLabel', ['07/05/00'; '05/03/01'; '03/11/02'; '01/09/03';...
	'11/07/03'; '09/10/04'; '07/15/05']);
legend('swp1y', 'swp2y', 'swp3y', 'swp4y','swp5y', 'swp7y', ...
        'swp10y', 'swp30y');
%print -depsc2 dswap02

%%% Decomposition of Variance
[coeff, eigenvalue, explained]  = pcacov(corrcoef(diff(data)));
bar(eigenvalue./sum(eigenvalue), 'y')
% print -depsc2 dswap03

%%% First 3 Principal Components
mat = [1, 2, 3, 4, 5, 6, 7, 8];
plot(mat, coeff(:,1), '-', 'LineWidth', 2);	hold on;
plot(mat, coeff(:,2), '-.', 'LineWidth', 2);
plot(mat, coeff(:,3), ':', 'LineWidth', 2);	hold off;
ylim([-0.7, 0.65]); xlim([0.5, 8.5]);
legend('trend', 'tilt', 'convexity');
%print -depsc2 dswap04

%%% reduced dimensions
pcadata = data*coeff;
plot(pcadata(:,1), '-', 'LineWidth', 1.5);   hold on;
plot(pcadata(:,2), '-.', 'LineWidth', 1.5);
plot(pcadata(:,3), ':', 'LineWidth', 1.5);   hold off;
xlim([-plotmargin, length(pcadata(:,1))+plotmargin]);
set(gca, 'Xtick', [1, 210, 419, 628, 837, 1046, 1256]);
set(gca, 'XtickLabel', ['07/03/00'; '05/03/01'; '03/11/02'; '01/09/03';...
        '11/07/03'; '09/10/04'; '07/15/05']);
legend('Level', 'Slope', 'Curvature');
% print -depsc2 dswap05

%%% plot the factor loadings
bar(-coeff(:,1:3), 'grouped')
ylim([-0.7, 0.7])
legend('the 1st', 'the 2nd', 'the 3rd')
%print -depsc2 dswap06
