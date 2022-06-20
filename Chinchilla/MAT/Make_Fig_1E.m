p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 14;
msize = 12;
lw = 2;
alpha = 0.2;

%% Load data
load('MEMRs_AllChins_AVG_memrDATAuse.mat');


%% MEMR first
names = {'ID', 'TimePoint', 'MEMR', 'Level'};
nlevels = numel(memrDATAuse.elicitor_dBSPL);
ntimes = 3; % pre, 1-day-post, and 2-weeks-post
nchins = numel(memrDATAuse.Chins);
memr = zeros(nchins * ntimes, nlevels);


level = memrDATAuse.elicitor_dBSPL;

for t = 1:ntimes
    dat = memrDATAuse.fitMEMRvLevel_dB.chindata{t};
    for k = 1:nchins
        memr((t-1)*nchins + k, :) = dat(k, :); %#ok<*AGROW>
    end
end

c = mean(memr(1:7, :), 1);
cste = nanstd(memr(1:7, :), [], 1) / sqrt(7);

p1 = mean(memr(8:14, :), 1);
p1ste = nanstd(memr(8:15, :), [], 1) / sqrt(7);

p2 = mean(memr(15:21, :), 1);
p2ste = nanstd(memr(15:21, :), [], 1) / sqrt(7);

figure;
errorbar(level, c, cste, 'o-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
errorbar(level, p1, p1ste, 's-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(3, :), 'MarkerFaceColor', map(3, :));
hold on;
errorbar(level, p2, p2ste, 'x-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(2, :), 'MarkerFaceColor', map(2, :));
c = memr(1:7, :);
p1 = memr(8:14, :);
p2 = memr(15:21, :);
hold on;
plot(level, c, '-', 'linew', lw, 'col', [map(1, :), alpha]);
hold on;
plot(level, p1, '-', 'linew', lw, 'col', [map(3, :), alpha]);
hold on;
plot(level, p2, '-', 'linew', lw, 'col', [map(2, :), alpha]);


xlabel('Elicitor level (dB SPL)', 'FontSize', fsize);
ylabel({'WB-MEMR', '\Delta Ear-Canal Pressure (dB)'}, 'FontSize', fsize);
set(gca,'FontSize', fsize);
xlim([33, 96]);
ylim([0, 2.5]);
[~, objhl] = legend({'Pre', 'Post (1 day)', 'Post (2 weeks)'},...
    'location', 'best');
grid on;
set(gca,'LineWidth',2,'TickLength',[0.015 .025], 'box', 'on');

%% Thresholds
figure;
c = memrDATAuse.Thresholds_dBSPL.chindata{1};
p1 = memrDATAuse.Thresholds_dBSPL.chindata{2};
p2 = memrDATAuse.Thresholds_dBSPL.chindata{3};

cm = mean(c);
cste = std(c) / sqrt(numel(c));
errorbar(1, cm, cste, 'o-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(1, :),...
    'MarkerFaceColor', map(1, :));
p1m = mean(p1);
p1ste = std(p1) / sqrt(numel(p1));
hold on;
errorbar(2, p1m, p1ste, 's-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(3, :),...
    'MarkerFaceColor', map(3, :));
p2m = mean(p2);
p2ste = std(p2) / sqrt(numel(p2));
hold on;
errorbar(3, p2m, p2ste, 'x-', 'linew', lw,...
    'MarkerSize', msize, 'col', map(2, :),...
    'MarkerFaceColor', map(2, :));
hold on;
cgray = [0.2, 0.2, 0.2];
alpha = 0.6
for k = 1:numel(c)
    plot([1, 2, 3], [c(k), p1(k), p2(k)], '--', 'linew', lw,...
        'MarkerSize', msize, 'col', [cgray, alpha]);
    hold on;
end

ylabel('WB-MEMR Threshols (dB SPL)', 'FontSize', fsize);
set(gca,'FontSize', fsize);
xlim([0.5, 3.5]);
ylim([55, 95]);

% Define each row of labels. 
row1 = {'Pre', 'Post', 'Post'};
row2 = {'', '(1 day)', '(2 weeks)'};
% Combine the rows of labels into a cell array; convert non-strings to strings/character vectors.
% labelArray is an nxm cell array with n-rows of m-tick-lables. 
labelArray = [row1; row2];
labelArray = strjust(pad(labelArray),'center');
tickLabels = strtrim(sprintf('%s\\newline%s\n',...
    labelArray{:}));
set(gca, 'XTick', 1:3, 'XTickLabel',tickLabels);
grid on;
set(gca,'LineWidth',2,'TickLength',[0.015 .025], 'box', 'on');

%% Clean up
rmpath(p);
%rmpath(path2);