function [] = make_CDF_spec_plots

%
% make_CDF_spec_plots.m
%
% Description:
%   Reads the measured data from the RF_spec_analysis_*.xls workbook
%   created with RF_spec_analysis_mod.xls and calculates the mean, standard 
%   deviation, and variance of the measurements before sub-plotting the
%   measurements w/ there averages against the spec value.  Subplots are
%   grouped on figures according to Amp, Phase, and Misc measurements.  All
%   figures are then saved off as slides at the end of the specified 
%   RF_spec_analysis_figs_*.ppt presentation for easy visual comparison of
%   the measured system data with the spec values
%
% Inputs:
%   RF_spec_analysis_*.xls  ->  excel workbook with measured data selected
%                               via uigetfile
%
% Outputs:
%   RF_spec_analysis_figs_*.ppt  ->  powerpoint presentation with fig plots 
% 
% Author:
%   Curtis Neiderer, 12/15/2008
%
% Notes:
%   This will probably need to be re-written to pull data from struct when 
%   RF_spec_analysis_mod.xls is changed to store data differently.  
%

%% Start excel and keep visible
xls=actxserver('Excel.Application');
xls.Visible=1;
xls.WindowState=2;

% Add new workbook
[existing_file,existing_path]=uigetfile('*.xls','Select the spec analysis file for plot data:');
    
% Open selected file
xlsWorkbook=xls.Workbook.Open(fullfile(existing_path,existing_file));

% Get workbook sheet names 
if strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'TX_data')
    Tx_sheet=xlsWorkbook.Worksheets.Item(1);
    Rx_sheet=xlsWorkbook.Worksheets.Item(2);
elseif strcmpi(xlsWorkbook.Worksheets.Item(1).Name,'Rx_data')
    Rx_sheet=xlsWorkbook.Worksheets.Item(1);
    Tx_sheet=xlsWorkbook.Worksheets.Item(2);
else
    error('Something is wrong, sheet name does not match "Tx" or "Rx"')
end
xls_worksheets=[Tx_sheet,Rx_sheet];

%% Add calculations to Tx_sheet & Rx_sheet
for ii=1:length(xls_worksheets)
   
    % Activate sheet
    xlsSheet=xls_worksheets(ii);
    xlsSheet.Activate();
    
    % Set mode
    if ii==1
        mode='Tx';
    elseif ii==2
        mode='Rx'; 
    end
   
    % Load data from sheet
    for head_row=[4,22,40,58,76,94,112,130,148,166,184]
    
        % Get band info
        name=xlsGetValue(xlsSheet,2,head_row-3);
        freq=xlsGetValue(xlsSheet,2,head_row-2);
        polar=xlsGetValue(xlsSheet,2,head_row-1);
        band_info=[mode,', ',name,', ',num2str(freq),'GHz - ',polar];
        
        % Form Fig & Slide Names
        amp_fig_slide=[band_info,': Amp Meas'];
        phase_fig_slide=[band_info,': Phase Meas'];
        misc_fig_slide=[band_info,': Misc Meas'];
        
        zz=1;
        test_col=2;
        while zz
            
            test_col=test_col+1;
            
            % Find last col with data
            test_cell_val=xlsGetValue(xlsSheet,test_col,head_row);
            if ~isnan(test_cell_val)
                continue;
            else
                last_col=test_col-1;
                start_row=head_row+1;
                zz=0;
            end
        
        end
                
        % Load data       
        group_cnt=0;
        fig_handles=[];
        for row=start_row:(start_row+11)
            
            group_cnt=group_cnt+1;
            
            % Get row of data
            measured_data=[];
            for col=3:last_col
                temp_meas=xlsGetValue(xlsSheet,col,row);
                measured_data=[measured_data,temp_meas];
            end
           
            % Make calculations 
            avg_meas=mean(measured_data);
            standard_dev=std(measured_data);
            var_meas=var(measured_data);
                                   
            %% Make CDF Plots
            % Create new figure & resize 
            if (group_cnt==1) || (group_cnt==5) || (group_cnt==9) 
				
                % Store figure handles
                fig_handles=[fig_handles,figure];
                
                % Set figure name
                if group_cnt==1
                    set(fig_handles(end),'Name',amp_fig_slide);
                elseif group_cnt==5
                    set(fig_handles(end),'Name',phase_fig_slide);
                elseif group_cnt==9
                    set(fig_handles(end),'Name',misc_fig_slide);
                end
                
                % Resize figure
                left_pos=300;
                bottom_pos=300;
                width_pos=750;
                height_pos=500;
                rect_pos=[left_pos,bottom_pos,width_pos,height_pos];
                set(fig_handles(end),'Position',rect_pos);
                
            end
            
            % Add Axes & Label
            switch group_cnt
                case 1
                    subplot(4,1,1);
                    xlabel('[dB]');
                    ylabel('W1 Amp');
                case 2
                    subplot(4,1,2);
                    xlabel('[dB]');
                    ylabel('W2 Amp');
                case 3
                    subplot(4,1,3);
                    xlabel('[dB]');
                    ylabel('Slope');
                case 4
                    subplot(4,1,4);
                    xlabel('[dB/MHz]');
                    ylabel('Max Var');
                case 5
                    subplot(4,1,1);
                    xlabel('[ns]');
                    ylabel('GD W1');
                case 6
                    subplot(4,1,2);
                    xlabel('[ns]');
                    ylabel('GD W2');
                case 7
                    subplot(4,1,3);
                    xlabel('[ns]');
                    ylabel('GD W3');
                case 8
                    subplot(4,1,4);
                    xlabel('[ns]');
                    ylabel('E-E');
                case 9
                    subplot(4,1,1);
%                     xlabel('');
                    ylabel('S11 VSWR');
                case 10
                    subplot(4,1,2);
%                     xlabel('');
                    ylabel('S22 VSWR');                    
                case 11
                    subplot(4,1,3);
                    xlabel('[dB]');
                    if ii==1
                        ylabel('Max IL')
                    elseif ii==2
                        ylabel('Min Gain')
                    end
                case 12
                    subplot(4,1,4);
                    xlabel('[dB]');
                    if ii==1
                        ylabel('Min IL')
                    elseif ii==2
                        ylabel('Max Gain')
                    end
                otherwise
            end
            hold on;
                        
            % Plot measured_data
            cdf_data=[];
			cdf_forplot=[];
            for zz=1:length(measured_data)
                eval('cdf_data=[cdf_data,repmat(measured_data(zz),1,2)];');
                eval('cdf_forplot=[cdf_forplot,((zz-1):zz)/length(measured_data)];');
            end
            
            plot(cdf_data,cdf_forplot,'-b','LineWidth',2);
            hold on;
            
            % Plot avg_meas
            avgmeas_val=avg_meas*ones(1,length(measured_data)+1);
            avgmeas_forplot=(0:length(measured_data))/length(measured_data);
            plot(avgmeas_val,avgmeas_forplot,':g','LineWidth',2);
            hold on;
            
            % Get spec value
            spec_val=xlsGetValue(xlsSheet,2,row);
            
            % If spec_val is not character (i.e., 'N/A'), plot spec_val
            if ~ischar(spec_val)
                
                % Plot spec
                spec_value=spec_val*ones(1,length(measured_data)+1);
                spec_forplot=(0:length(measured_data))/length(measured_data);
                plot(spec_value,spec_forplot,'--r','LineWidth',2);  
                
                % Set Xlimits
                min_xlim=min(min(measured_data),spec_val); %-0.25;
                max_xlim=max(max(measured_data),spec_val); %+0.25;
                xlim_adjust=(max_xlim-min_xlim)/10;
                min_xlim=min_xlim-xlim_adjust;
                max_xlim=max_xlim+xlim_adjust;
                
                xlim([min_xlim,max_xlim]);
                
                legend('meas',['avg: ',num2str(avg_meas)],['spec: ',num2str(spec_val)],'Location','EastOutside');
                
            else
                
                % Set Xlimits
                min_xlim=min(measured_data); %-0.25;
                max_xlim=max(measured_data); %+0.25;
                xlim_adjust=(max_xlim-min_xlim)/10;
                min_xlim=min_xlim-xlim_adjust;
                max_xlim=max_xlim+xlim_adjust;
                
                xlim([min_xlim,max_xlim]);
                
                legend('meas',['avg: ',num2str(avg_meas)],'Location','EastOutside');

            end
            
            hold off;

            clear cdf_data cdf_forplot spec_value spec_forplot
            
        end
        
        if ~exist('saveas_ppt','var')
            [ppt_file,ppt_path]=uiputfile('*.ppt','Save file as: ',['CDF_spec_plots_',datestr(now,30),'.ppt']);
            saveas_ppt=fullfile(ppt_path,ppt_file);

%             saveas_ppt=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\',['CDF_spec_plots_',datestr(now,30),'.ppt']);
        end
        
        % Copy figures to PowerPoint
        slide_titles={amp_fig_slide,phase_fig_slide,misc_fig_slide};
        for jj=1:length(fig_handles)
            
            fnumber=fig_handles(jj);
            figs_per_slide=1;
            
            ppt_copyfig(saveas_ppt,slide_titles{jj},fnumber,figs_per_slide);
                        
        end
        
        test=0;
        
        % Close figures
        close all
        
    end
    
end

% Save and close excel
xlsWorkbook.Close;
xls.Quit;
xls.delete;
