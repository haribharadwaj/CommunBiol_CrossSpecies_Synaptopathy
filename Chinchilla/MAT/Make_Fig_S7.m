p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;


%% Load data
load('MEMRs_AllChins_AVG_memrDATAuse.mat');
load('ABRs_AllChins_AVG_abrDATAuse.mat');

doSave = false;

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
errorbar(level, c, cste, 'o-', 'linew', lw, 'MarkerSize', msize, 'col', map(1, :), 'MarkerFaceColor', map(1, :));
hold on;
errorbar(level, p1, p1ste, 's-', 'linew', lw, 'MarkerSize', msize, 'col', map(3, :), 'MarkerFaceColor', map(3, :));
hold on;
errorbar(level, p2, p2ste, 'x-', 'linew', lw, 'MarkerSize', msize, 'col', map(2, :), 'MarkerFaceColor', map(2, :));

xlabel('Elicitor level (dB SPL)', 'FontSize', fsize);
ylabel({'WB-MEMR', '\Delta Ear-Canal Pressure (dB)'}, 'FontSize', fsize);
set(gca,'FontSize', fsize);
xlim([30, 100]);
[~, objhl] = legend({'Pre', 'Post (1 day)', 'Post (2 weeks)'},...
    'location', 'best');
grid on;
set(gca,'LineWidth',2,'TickLength',[0.015 .025], 'box', 'on')
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

set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave I amplitude (\mu V)', 'fontsize', fsize);
xlim([0.5, 2.5]);
ylim([0.5, 1.5]);
grid on;
set(gca,'YTick', 0.5:0.25:1.5, 'TickLength',[0.015 .025], 'box', 'off')

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

set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave V amplitude (\mu V)', 'fontsize', fsize);
xlim([0.5, 2.5]);
ylim([0.5, 1]);
grid on;
set(gca,'YTick', 0.5:0.1:1, ...
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

set(gca, 'fontsize', fsize, 'Xtick', ...
    [1, 2], 'xticklabel',...
    {'Pre', 'Post (2 weeks)'});
ylabel('ABR wave I/V ratio', 'fontsize', fsize);
xlim([0.5, 2.5]);
ylim([0.7, 2.8]);
grid on;
set(gca,'YTick', 0.7:0.3:3.2, ...
    'TickLength',[0.015 .025], 'box', 'on', 'linew', 2);

rmpath(p);
