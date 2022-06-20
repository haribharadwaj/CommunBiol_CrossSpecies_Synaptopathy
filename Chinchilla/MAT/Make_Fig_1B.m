% CS_cochleogram
% Jun 26 2017

% Updated from CS_cochleogram_ASA.m on Jan 10, 2022.

clear
close all

p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;
alpha = 0.2;

CF=[0.5	1	2	4	6	8];

NHcounts=[
12.41	14.25	20.83333333	21.75	18.58333333	16.66666667
13	13.66666667	16.75	20.83333333	12.91666667	11.75
11.58333333	13.5	16	20.58333333	20.91666667	18.75
12	14.83333333	19.91666667	20.25	22	10.58333333
22.5	16	10.83333333	12.41666667	14.41666667	21.41
15.25	15.41	14.91	10.3	14.25	11.25
14.08	12.5	20.25	21.16	18	14.33333333
15.08	16.91	18.5	16.83	16.5	18.91
];

TTScounts=[
10.90909091	6.083333333	10	10.5	9.833333333	9.333333333
10.83333333	9.75	9.25	13.25	12.41666667	12.83333333
5.214285714	6.733333333	7.428571429	8.333333333	14.53333333	9
14.91666667	11	6.666666667	7.083333333	8.5	6.5
12.75	8.083333333	8.833333333	5.5	8.666666667	9
11.33333333	10.91666667	7.916666667	7.916666667	6.166666667	8
12.25	9.416666667	8.666666667	9	6.333333333	6.916666667
11.25	6.916666667	6.833333333	7.166666667	5.75	8.916666667
];

Q211counts=[11.25	6.916666667	6.833333333	7.166666667	5.75	8.916666667];

NHmean=mean(NHcounts);
TTSmean=mean(TTScounts);
NHstd=std(NHcounts);
TTSstd=std(TTScounts);

NHcounts_norm=NHcounts./NHmean;
TTScounts_norm=TTScounts./NHmean;
Q211counts_norm=Q211counts./NHmean;

NHmean_norm=mean(NHcounts_norm);
TTSmean_norm=mean(TTScounts_norm);
NHste_norm=std(NHcounts_norm)/sqrt(length(NHcounts_norm));
TTSste_norm=std(TTScounts_norm)/sqrt(length(TTScounts_norm));

figure(1); clf

% Make gray patch first
px = [1/sqrt(2), sqrt(2), sqrt(2), 1/sqrt(2)]; 
py = [0.001, 0.001, 1.199, 1.199];
patch(px, py, [0.7, 0.7, 0.7], 'EdgeColor', 'none',...
    'FaceAlpha', 0.7,...
    'HandleVisibility','off');

hold on;
errorbar(CF,NHmean_norm,NHste_norm,'o-','Linewidth',lw, ...
    'col', map(1, :), 'MarkerFaceColor', map(1, :), 'MarkerSize', msize);
hold on;
errorbar(CF,TTSmean_norm,TTSste_norm,'x-','Linewidth',2,...
    'col', map(2, :), 'MarkerFaceColor', map(1, :), 'MarkerSize', msize);
hold on;
plot(CF, NHcounts_norm, '-', 'Linewidth',lw, 'col', [map(1, :), alpha]);
hold on;
plot(CF, TTScounts_norm, '-', 'Linewidth',lw, 'col', [map(2, :), alpha]);
ylim([0 1.2])
xlim([.3 10])
ylabel('Fraction of Synapses Remaining ','FontSize',20)
xlabel('Center Frequency (kHz)','FontSize',20)
axis on;
set(gca,'XScale','log','XTickLabel',[1 10],'FontSize',16)
legend('Control','TTS Noise Exposed','Location','southwest')
set(gca,'LineWidth',2,'TickLength',[0.015 .025], 'box', 'on')


rmpath(p);