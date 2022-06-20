% Plot swept DP for Comms Biol R1
load('DPswept_AllChins_AVG_dpsweptDATAuse.mat');
p = genpath('~/repos/BrewerMap/');
addpath(p);
map = brewermap(3, 'Dark2');
fsize = 18;
msize = 12;
lw = 2;
alpha = 0.2;


%Plot individual Chin Data
clear legendstr plotnum
Chins2Run={'Q348','Q350','Q351','Q363','Q364','Q365','Q368'};
% Chins2Run={'Q365'};
Conds2Run={'pre\1weekPreTTS','post\1dayPostTTS','post\2weeksPostTTS'};

legstrs = {'Pre', 'Post (1 day)', 'Post (2 weeks)'};
LevelIND = 2; % Do only mid level for the figure
XLIMITS_Hz = [min(DPsweptDATAuse.F2freq_Hz) max(DPsweptDATAuse.F2freq_Hz)];
YLIMITS_dBSPL = [-20 50];  % Don't need as wide a range for AVG
for CondIND = 1:length(Conds2Run)
    switch CondIND
        case 1
            colind = 1;
        case 2
            colind = 3;
        case 3
            colind = 2;
    end
    % compute sparse STD
    dp_resp_dB_STDsparse=NaN+zeros(size(DPsweptDATAuse.DPvFreq_dB{LevelIND}.chinSTD.dp_resp_dB(CondIND,:)));
    dp_resp_dB_STDsparse(1:100:end)=DPsweptDATAuse.DPvFreq_dB{LevelIND}.chinSTD.dp_resp_dB(CondIND,1:100:end);
    
    %Plot resp (with sparse STE)
    plotnum(CondIND)=errorbar(DPsweptDATAuse.F2freq_Hz,DPsweptDATAuse.DPvFreq_dB{LevelIND}.chinAVG.dp_resp_dB(CondIND,:), dp_resp_dB_STDsparse/sqrt(length(Chins2Run)),...
        '-', 'col', map(colind, :), 'linew', lw);
    hold on;
    plot(DPsweptDATAuse.F2freq_Hz,...
        DPsweptDATAuse.DPvFreq_dB{LevelIND}.chindata{CondIND}.dp_resp_dB,...
        '-', 'linew', lw, 'col', [map(colind, :), alpha]);
    legendstr{CondIND} = legstrs{CondIND};
end
hold on;
%plot just mean noise floor
lineapp = 'k:';
nfloor = mean(DPsweptDATAuse.DPvFreq_dB{LevelIND}.chinAVG.dp_noise_dB, 1);
semilogx(DPsweptDATAuse.F2freq_Hz, nfloor,...
    lineapp, 'linew', 2);
%Format figure
hold off;
xlim(XLIMITS_Hz); ylim(YLIMITS_dBSPL) % use same for all plots
xlabel('F2 Frequency (Hz)', 'FontSize', fsize);
ylabel('DPOAE Level (dB SPL)', 'FontSize', fsize);
set(gca, 'FontSize', fsize);
set(gca,'xscale','log','XTick',[1000 10000],'XTickLabel',{' '},'linew',2);  % Need to hack to get Xaxis labels right
text(2000,1.05*YLIMITS_dBSPL(1),'2000','HorizontalAlignment','center','VerticalAlignment','top','FontSize',fsize)
text(4000,1.05*YLIMITS_dBSPL(1),'4000','HorizontalAlignment','center','VerticalAlignment','top','FontSize',fsize)
text(8000,1.05*YLIMITS_dBSPL(1),'8000','HorizontalAlignment','center','VerticalAlignment','top','FontSize',fsize)
text(16000,1.05*YLIMITS_dBSPL(1),'16000','HorizontalAlignment','center','VerticalAlignment','top','FontSize',fsize)
grid on;
text(2100, 3, 'Noise Floor', 'FontSize', fsize);
h=legend(plotnum(:),legendstr{:},'Location','southeast');
set(h,'FontSize',16);
set(gcf, 'units', 'normalized', 'position', [.1 .1 .6 .6]);

rmpath(p);
