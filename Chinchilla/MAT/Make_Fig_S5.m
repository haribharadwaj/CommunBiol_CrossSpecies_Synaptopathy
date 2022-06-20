%% Plot DPgrams for 75/65 only
load('DPgrams_AllChins_AVG_DPgramDATAuse.mat');
p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;
alpha = 0.2;

clear legendstr plotnum
Chins2Run={'Q348','Q350','Q351','Q363','Q364','Q365','Q368'};

Conds2Run={'pre\1weekPreTTS','post\1dayPostTTS','post\2weeksPostTTS','post\2weeksPostTTSanesth'};

legstrs = {'Pre', 'Post (1 day)', 'Post (2 weeks)', 'Post (2 weeks) Anesthetized'};

figure(1999); clf    %3 figures in total
XLIMITS_kHz = [0.95 max(DPgramDATAuse.F2freq_kHz)];
YLIMITS_dBSPL = [-0 50];  % Don't need as wide a range for AVG
for CondIND = 1:length(Conds2Run)
    switch CondIND
        case 1
            colind = 1;
            lineapp = '-';
        case 2
            colind = 3;
            lineapp = '-';
        case 3
            colind = 2;
            lineapp = '-';
        case 4
            colind = 2;
            lineapp = ':';
    end
    
    %Plot resp (with sparse STE)
    plotnum(CondIND)=errorbar(DPgramDATAuse.F2freq_kHz,DPgramDATAuse.DPvFreq_dBSPL.chinAVG(CondIND,:),...
        DPgramDATAuse.DPvFreq_dBSPL.chinSTD(CondIND,:)/sqrt(length(Chins2Run)),...
        lineapp, 'col', map(colind, :), 'linew', lw);
    hold on;
    plot(DPgramDATAuse.F2freq_kHz,...
        DPgramDATAuse.DPvFreq_dBSPL.chindata{CondIND},...
        lineapp, 'linew', lw, 'col', [map(colind, :), alpha]);
    hold on;
    legendstr{CondIND} = legstrs{CondIND};
end
%Format figure
hold off;
xlim(XLIMITS_kHz); ylim(YLIMITS_dBSPL) % use same for all plots
xlabel('F2 Frequency (Hz)', 'FontSize', fsize);
ylabel('DPOAE Level (dB SPL)', 'FontSize', fsize);
set(gca, 'FontSize', fsize,'linew',2);
set(gca,'xscale','log');
set(gca,'XTick',[1 10],'XTickLabel',[' ' ' ']);  % Need to hack to get Xaxis labels right
textOFFsetTEMP=1;
text(1,YLIMITS_dBSPL(1)-textOFFsetTEMP,'1','HorizontalAlignment','center','VerticalAlignment','top','FontSize',16)
text(2,YLIMITS_dBSPL(1)-textOFFsetTEMP,'2','HorizontalAlignment','center','VerticalAlignment','top','FontSize',16)
text(4,YLIMITS_dBSPL(1)-textOFFsetTEMP,'4','HorizontalAlignment','center','VerticalAlignment','top','FontSize',16)
text(8,YLIMITS_dBSPL(1)-textOFFsetTEMP,'8','HorizontalAlignment','center','VerticalAlignment','top','FontSize',16)
text(16,YLIMITS_dBSPL(1)-textOFFsetTEMP,'16','HorizontalAlignment','center','VerticalAlignment','top','FontSize',16)
grid on;
h=legend(plotnum(:),legendstr{:},'Location','southeast');
set(h,'FontSize',16);
set(gcf, 'units', 'normalized', 'position', [.1 .1 .6 .6]);

rmpath(p);

