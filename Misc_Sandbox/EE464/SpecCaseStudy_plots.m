function []=SpecCaseStudy_plots(vargin)

%
% SpecCaseStudy_plots.m
%
% Description:
%
% Inputs:
%
% Outputs:
%
% Author:
%   Curtis Neiderer, 7/2/2009
%
% Notes / Changes:
%

% Get workbook name
if nargin==1
    existing_xls=vargin{1};
else
    [filename,filepath]=uigetfile({'*.xls','Excel files (*.xls)';...
        '*.*','All Files (*.*)'},...
        'Select the SpecCaseStudy workbook to add calcs to: ');
    existing_xls=fullfile(filepath,filename);
end

% if ~exist('existing_xls','file')
%     error('You did not select an existing workbook, please try again.')
% end

% Create stem plots displaying unit measurements relative to specs

% Open excel
xls=actxserver('Excel.Application');
xls.Visible=1;
xlsWorkbook=xls.Workbook.Open(existing_xls);

% Create stem plots
for ii=1:2
    
    % Activate sheet
    xlsSheet=xlsWorkbook.Sheets.Item(ii);
    xlsSheet.Activate();
    
    % Load data from sheet
    for head_row=[3,19,35,51,67,83,99,115,131,147]
        
        zz=1;
        test_col=6;
        first_col=6;
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
        
        % Format data columns
        data_range_obj=xlsGetRange(xlsSheet,first_col,head_row,...
            last_col,head_row+12);
        data_range_obj.Borders.LineStyle=1;
        data_range_obj.HorizontalAlignment=3;
        data_range_obj.VerticalAlignment=2;
        
        % Add calculation headers
        xlsSetCellVal('Avg',xlsSheet,last_col+2,head_row);
        xlsSetCellBackground('k',xlsSheet,last_col+2,head_row);
        xlsSetCellForeground('w',xlsSheet,last_col+2,head_row);
                
        xlsSetCellVal('Std',xlsSheet,last_col+3,head_row);
        xlsSetCellBackground('k',xlsSheet,last_col+3,head_row);
        xlsSetCellForeground('w',xlsSheet,last_col+3,head_row);
        
%         xlsSetCellVal('Var',xlsSheet,last_col+4,head_row);
%         xlsSetCellBackground('k',xlsSheet,last_col+4,head_row);
%         xlsSetCellForeground('w',xlsSheet,last_col+4,head_row);
%         
%         calc_head_obj=xlsGetRange(xlsSheet,last_col+2,head_row,...
%             last_col+4,head_row);
%         calc_head_obj.HorizontalAlignment=3;
%         calc_head_obj.VerticalAlignment=2;
        
        % Load data    
        spec_col=5;
        group_cnt=0;
        fig_handles=[];
        for row=start_row:(start_row+11)
            
            group_cnt=group_cnt+1;
            
            % Get row of data
            measured_data=[];
            for col=7:last_col
                temp_meas=xlsGetValue(xlsSheet,col,row);
                measured_data=[measured_data,temp_meas];
            end
           
            % Make calculations 
            avg_meas=mean(measured_data);
            standard_dev=std(measured_data);
            var_meas=var(measured_data);

            % Get spec value
            spec_cell=xlsGetValue(xlsSheet,spec_col,row);
            if regexpi(spec_cell,'\d*[.]\d*\s','end') >= 3
                spec_val=str2double(spec_cell(1:regexpi(spec_cell,...
                    '\d*[.]\d*\s','end')-1));
            elseif regexpi(spec_cell,':','end')
                spec_val=str2double(spec_cell(1:regexpi(spec_cell,...
                    ':','end')-1));
            elseif regexpi(spec_cell,'NA')
                spec_val=[];
            else
                error(['Something is wrong, the expression in spec_cell does not match'...
                    ' any of the regular expression options'])
            end
            
            % Store figure handles
            fig_handles=[fig_handles,figure];
            % Create plot
            stem(measured_data,'fill','-b','LineWidth',2);
            hold on;
            % Add spec value to plot
            if ~isempty(spec_val)
                plot((0:length(measured_data)+1),...
                    ones(1,(length(measured_data)+2))*spec_val,...
                    '-r','LineWidth',2);
            end
            % Add mean value to plot
            plot((0:length(measured_data)+1),...
                ones(1,(length(measured_data)+2))*avg_meas,...
                '--g','LineWidth',2);
            % Format axes limits
            xlim([0 length(measured_data)+1]);
            
            min_y=min([measured_data,spec_val]);
            max_y=max([measured_data,spec_val]);
            ylim([min_y-min_y*0.1 max_y+max_y*0.1]);
            
            % Add axes labels
            xlabel('TWISTER SN');
            switch group_cnt
                case 1
                    ylabel('S11 VSWR');
                case 2
                    ylabel('S22 VSWR');
                case 3
                    ylabel('Min Gain');
                case 4
                    ylabel('Max Gain');
                case 5
                    ylabel('Gain Slope');
                case 6
                    ylabel('W1 Amp');
                case 7
                    ylabel('W2 Amp');
                case 8
                    ylabel('Fine Var');
                case 9
                    ylabel('Edge-to-Edge GD');
                case 10
                    ylabel('W1 GD');
                case 11
                    ylabel('W2 GD');
                case 12
                    ylabel('W3 GD');
            end
            
            test=0;
            
        end
        
        % Open powerpoint if necessary
        if ~exist('saveas_ppt','var')
            [ppt_file,ppt_path]=uiputfile('*.ppt','Save file as: ',['SpecCaseStudy_plots_',datestr(now,30),'.ppt']);
            saveas_ppt=fullfile(ppt_path,ppt_file);
%             saveas_ppt=fullfile('S:\Curtis_Neiderer\MATLAB_Toolbox\',['CDF_spec_plots_',datestr(now,30),'.ppt']);
        end
        
        % Copy figures to PowerPoint
        slide_titles={'','',''};
        fig_cnt=0;
        for jj=1:length(slide_titles)
            
            fnumber=fig_handles(fig_cnt+1:fig_cnt+4);
            fig_cnt=fig_cnt+4;
            figs_per_slide=4;
            
            ppt_copyfig(saveas_ppt,slide_titles{jj},fnumber,figs_per_slide);
                        
        end
        
        test=0;
        
        % Close figures & clear handles
        close all 
        clear fig_handles
        
    end 

end

% Close excel
xlsWorkbook.Close;
xls.Quit;
xls.delete;

