p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;
alpha = 0.6;
cgray = [0.2, 0.2, 0.2];

%% Load data
load('ABRs_AllChins_AVG_abrDATAuse.mat');

doSave = false;

%% Now ABR
names = {'ID', 'TimePoint', 'W1', 'W5'};

ntimes = 2; % pre and 2-weeks-post
nchins = numel(abrDATAuse.Chins);
w1 = [];
tpt = [];
w5 = [];
ids = [];

for t = 1:ntimes
    dat1 = abrDATAuse.HighLev_Amplitude_uV.W1.chindata{t};
    dat5 = abrDATAuse.HighLev_Amplitude_uV.W5.chindata{t};
    for k = 1:nchins
        w1 = [w1; dat1(k, end)]; %#ok<*AGROW>
        w5 = [w5; dat5(k, end)]; %#ok<*AGROW>
        switch t
            case 1
                tpt = [tpt; 'pre'];
            case 2
                tpt = [tpt; '2wk'];
        end
        ids = [ids; abrDATAuse.Chins{k}];
    end
end
Tabr = table(ids, tpt, w1, w5, 'VariableNames', names);


%% Plot w1 and w5
w = w1;

ct = mean(w(1:7));
ctste = nanstd(w(1:7)) / sqrt(7);

nt = mean(w(8:14));
ntste = nanstd(w(8:14)) / sqrt(7);

figure;
subplot(2, 1, 1);
errorbar(1, ct, ctste, 'o-', 'linew', lw, 'MarkerSize', msize, 'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
errorbar(2, nt, ntste, 'x-', 'linew', lw, 'MarkerSize', msize, 'col', map(2, :), 'MarkerFaceColor', map(2, :));
c = w(1:7);
n = w(8:14);
hold on;
for k = 1:numel(c)
    plot([1, 2], [c(k), n(k)], '--', 'linew', lw,...
        'MarkerSize', msize, 'col', [cgray, alpha]);
    hold on;
end

set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave I amplitude (\mu V)', 'fontsize', fsize);
xlim([0.5, 2.5]);
ylim([0.4, 2.4]);
grid on;
set(gca,'YTick', 0.4:0.4:2.4, 'TickLength',[0.015 .025], 'box', 'off')

% W5
w = w5;

ct = mean(w(1:7));
ctste = nanstd(w(1:7)) / sqrt(7);

nt = mean(w(8:14));
ntste = nanstd(w(8:14)) / sqrt(7);

subplot(2, 1, 2);
errorbar(1, ct, ctste, 'o-', 'linew', lw, 'MarkerSize', msize, 'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
errorbar(2, nt, ntste, 'x-', 'linew', lw, 'MarkerSize', msize, 'col', map(2, :), 'MarkerFaceColor', map(2, :));
c = w(1:7);
n = w(8:14);
hold on;
for k = 1:numel(c)
    plot([1, 2], [c(k), n(k)], '--', 'linew', lw,...
        'MarkerSize', msize, 'col', [cgray, alpha]);
    hold on;
end
set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave V amplitude (\mu V)', 'fontsize', fsize);
xlim([0.5, 2.5]);
ylim([0.4, 1.6]);
grid on;
set(gca,'YTick', 0.4:0.4:1.6, ...
    'TickLength',[0.015 .025], 'box', 'off')

% w1/w5
w = w1./w5;

ct = mean(w(1:7));
ctste = nanstd(w(1:7)) / sqrt(7);

nt = mean(w(8:14));
ntste = nanstd(w(8:14)) / sqrt(7);

figure;
errorbar(1, ct, ctste, 'o-', 'linew', lw, 'MarkerSize', msize, 'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
errorbar(2, nt, ntste, 'x-', 'linew', lw, 'MarkerSize', msize, 'col', map(2, :), 'MarkerFaceColor', map(2, :));
c = w(1:7);
n = w(8:14);
hold on;
for k = 1:numel(c)
    plot([1, 2], [c(k), n(k)], '--', 'linew', lw,...
        'MarkerSize', msize, 'col', [cgray, alpha]);
    hold on;
end
set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave I/V ratio', 'fontsize', fsize);
xlim([0.5, 2.5]);
%ylim([0.7, 2.8]);
grid on;
set(gca,'YTick', [0.5, 1, 2, 4], 'yscale', 'log', ...
    'TickLength',[0.015 .025], 'box', 'on', 'linew', 2);

rmpath(p);
