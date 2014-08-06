function OverlaySParameters(array_type,interp_step)

%
% OverlaySParameters.m
%
% Description:
%   Gets the S-parameter data from the specified files, then overlays
%   the S-parameters from each program on the same plot.
%
% Author:
%   Curtis Neiderer, 4/10/2009
%
% Notes / Changes:
%

%% Set defalt interp_step
if nargin==0
    interp_step=.01;
    array_type='';
end     

%% Save current directory, then change to Correlation directory
original_dir=cd;
correlation_dir=...
    uigetdir('C:\Antenna_Correlation','Select correlation data directory:');
cd(correlation_dir);

%% Get HFSS pattern
[FileName,PathName]=uigetfile('*.csv','Select the HFSS file:');
HFSS_file=fullfile(PathName,FileName);
HFSS_Sdata=load_HFSS_SParameters(HFSS_file,interp_step);

%% Get CST pattern
[FileName,PathName]=uigetfile('*.txt','Select the CST file [Phi=0deg]:');
CST_file=fullfile(PathName,FileName);
CST_Sdata=load_CST_SParameters(CST_file,interp_step);

%% Get WASP-Net pattern
[FileName,PathName]=uigetfile('*.xls','Select the WASPNET file [Phi=90deg]:');
WASPNET_file=fullfile(PathName,FileName);
WASPNET_Sdata=load_WASPNET_SParameters(WASPNET_file,interp_step);

%% Change back to original directory
cd(original_dir);

%% Overlay S-parameter data from each program onto same plot
Sparameter_fig=figure;
hold on;

% plot(HFSS_Sdata.freq,HFSS_Sdata.S11,'-r','LineWidth',2); 
% plot(CST_Sdata.freq,CST_Sdata.S11,'-b','LineWidth',2);
plot(WASPNET_Sdata.freq,WASPNET_Sdata.S11,'-g','LineWidth',2);

plot([9.1,9.1],[-60,0],'-k','LineWidth',2);
% text(9.1,-40,'Flo',...
text(9.1,-25,'Flo',...
    'FontSize',14,...
    'Margin',5,...
    'HorizontalAlignment','Center',...
    'BackgroundColor','w');
plot([9.55,9.55],[-60,0],'-k','LineWidth',2);
% text(9.55,-40,'Fmid',...
text(9.55,-25,'Fmid',...
    'FontSize',14,...
    'Margin',5,...
    'HorizontalAlignment','Center',...
    'BackgroundColor','w');
plot([10,10],[-60,0],'-k','LineWidth',2);
% text(10,-40,'Fhi',...
text(10,-25,'Fhi',...
    'FontSize',14,...
    'Margin',5,...
    'HorizontalAlignment','Center',...
    'BackgroundColor','w');

title([array_type,' Array: S-Parameters']);
xlabel('freq [GHz]');
set(gca,'XLim',[8.75,10.25]);
set(gca,'XTickLabel',''); % Remove XTickLabel (i.e., hide freqs)
ylabel('[dB]');
set(gca,'YLim',[-60,0]);
set(gca,'YTick',-60:5:0);
set(gca,'YGrid','on');
legend('HFSS','CST','WASP-Net','Location','SouthEast');
% set(gca,'YLim',[-35,0]);
% set(gca,'YTick',-35:5:0);
% set(gca,'YGrid','on');
% legend('WASP-Net','Location','SouthEast');

hold off;

test=1;