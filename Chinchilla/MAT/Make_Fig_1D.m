p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;
alpha = 0.2;

%% Load data
load('ABRs_AllChins_AVG_abrDATAuse.mat');

doSave = false;

%% Now ABR thresholds
names = {'ID', 'TimePoint', 'W1', 'W5'};

ntimes = 2; % pre and 2-weeks-post
nchins = numel(abrDATAuse.Chins);
f = abrDATAuse.Freqs_Hz;
f(1) = 350; % Where to plot click
f = f/1000; % Convert to kHz

% Make gray patch first
px = [1/sqrt(2), sqrt(2), sqrt(2), 1/sqrt(2)]; 
py = [-20, -20, 50, 50];
patch(px, py, [0.7, 0.7, 0.7], 'EdgeColor', 'none',...
    'FaceAlpha', 0.7,...
    'HandleVisibility','off');

hold on;

plotlist = [];

%% Pre
T = abrDATAuse.Thresholds_dBSPL.chindata{1};
Tm = mean(T, 1);
ref = Tm; % So that shifts can be quantified
Te = std(T, [], 1) / sqrt(size(T, 1));

% All except click
plotlist(1) = errorbar(f(2:end), Tm(2:end) - ref(2:end), Te(2:end),...
    'o-', 'linew', lw, 'MarkerSize', msize,...
    'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
plot(f(2:end), T(:, 2:end) - repmat(ref(2:end), size(T,1), 1),...
    '-', 'linew', lw,...
    'col', [map(1, :), alpha]);

% click only
hold on;
errorbar(f(1), Tm(1) - ref(1), Te(1),...
    'o-', 'linew', lw, 'MarkerSize', msize,...
    'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
scatter(repmat(f(1), size(T, 1), 1), T(:, 1) - ref(1),...
    msize*10, 'o', 'MarkerEdgeColor', map(1, :),...
    'MarkerFaceColor', map(1, :),...
    'MarkerFaceAlpha', alpha,...
    'MarkerEdgeAlpha', alpha);



%% Post

T = abrDATAuse.Thresholds_dBSPL.chindata{2};
Tm = mean(T, 1);
Te = std(T, [], 1) / sqrt(size(T, 1));
hold on;

% All except click
plotlist(2) = errorbar(f(2:end), Tm(2:end) - ref(2:end), Te(2:end),...
    'x-', 'linew', lw, 'MarkerSize', msize,...
    'col', map(2, :), 'MarkerFaceColor', map(2, :));
hold on;

plot(f(2:end), T(:, 2:end) - repmat(ref(2:end), size(T,1), 1),...
    '-', 'linew', lw,...
    'col', [map(2, :), alpha]);

% Click only
errorbar(f(1), Tm(1) - ref(1), Te(1),...
    'x-', 'linew', lw, 'MarkerSize', msize,...
    'col', map(2, :), 'MarkerFaceColor', map(2, :));
hold on;
scatter(repmat(f(1), size(T, 1), 1), T(:, 1) - ref(1),...
    msize*10, 'x', 'MarkerEdgeColor', map(2, :),...
    'MarkerFaceColor', map(2, :),...
    'MarkerFaceAlpha', alpha,...
    'MarkerEdgeAlpha', alpha);

xlabel('Frequency (kHz)', 'FontSize', fsize);
ylabel('Threshold Shift (dB)', 'FontSize', fsize);

ylim([-20 50]);
xlim([.3 10]);
axis on;
set(gca,'XScale','log','XTick', [0.35, 1, 10], ...
    'XTickLabel',{'Click', '1', '10'},'FontSize',16)
legend(plotlist, {'Pre','Post (2 weeks)'},'Location','southwest');
set(gca,'LineWidth',2,'TickLength',[0.015 .025], 'box', 'on');

rmpath(p);
