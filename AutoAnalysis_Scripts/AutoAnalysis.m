function []=AutoAnalysis

%% (1)----- Open & setup excel

% Start Excel
xls=xlsStartExcel(1);

% Define SaveAs path and Template path
saveas_fullfile=fullfile('D:\MATLAB_Toolbox\Results',['AutoAnalysisTest_',...
    datestr(now,30),'.xls']);
template_fullfile='D:\MATLAB_Toolbox\AutoAnalysis_Scripts\AutoAnalysis_template.xlt';

% Add new workbook from template
xlsWorkbook=xlsAddNewWorkbook(xls,saveas_fullfile,template_fullfile);

% Activate input sheet
inputSheet=xlsWorkbook.Worksheets.Item(1);
inputSheet.Activate;

%% (2)----- Read Inputs

% Read test names
test_list={};
test_col=6;
test_row=1;
test_cnt=0;
ii=1;
while ii
    test_name=xlsGetValue(inputSheet,test_col,test_row);
    test_type=xlsGetValue(inputSheet,test_col,test_row+1);
    
    % Add test to list
    if ~isnan(test_name)
        test_cnt=test_cnt+1;
        test_list{test_cnt,1}=test_name;
        test_list{test_cnt,2}=test_type;
        test_col=test_col+1;
    else
        ii=0; % Set ii=0 to exit while loop
    end    
end

% Read Scenarios
scenario_list=struct;
scen_col=1;
scen_row=4;
jj=1;
while jj
    scen_name=xlsGetValue(inputSheet,scen_col,scen_row);
    if ~isnan(scen_name)
        % Replace spaces in scenario name w/ underscores
        scen_name=regexprep(scen_name,' ','_');
        %% Read Boundaries
        test_col=6;
        for xx=1:length(test_list)
            CRUSHM1=xlsGetValue(inputSheet,test_col,scen_row);
            CRUSHM2=xlsGetValue(inputSheet,test_col,scen_row+1);
            Bound1=xlsGetValue(inputSheet,test_col,scen_row+2);
            Bound2=xlsGetValue(inputSheet,test_col,scen_row+3);     
            
            % Add boundaries to list
            eval(['test_bounds.',test_list{xx,1},...
                '=[CRUSHM1,CRUSHM2,Bound1,Bound2];']);
            
            test_col=test_col+1;
        end
        % Add test boundaries & type to scenario 
        eval(['scenario_list.',scen_name,'.boundaries=test_bounds;']);
        eval(['scenario_list.',scen_name,'.test_type=test_list(:,2);']);
        
        %% Read Runs
        run_list={};
        run_col=2;
        run_row=scen_row;
        run_cnt=0;
        kk=1;
        while kk
            % Get run name & add to list
            run_name=xlsGetValue(inputSheet,run_col,run_row);
            
            % Test for next scenario after run count exceeds 4
            if run_cnt>=4
                test_for_scen=xlsGetValue(inputSheet,scen_col,run_row);
                if ~isnan(test_for_scen)
                    scen_row=run_row;
                    break;
                end
            end
            
            % Add run to list
            if ~isnan(run_name)                
                run_cnt=run_cnt+1;
                run_list{run_cnt,1}=run_name;
                run_row=run_row+1;
            else
                kk=0; % Set kk=0 to exit while loop                
            end                        
        end
        % Add run list to scenario
        eval(['scenario_list.',scen_name,'.runs=run_list;']);

        % Update scenario row if run_cnt < 4 
        if run_cnt<4
            scen_row=scen_row+4;
        end
        
    else
        jj=0; % Set jj=0 to exit while loop        
    end   
end

%% (3)----- Analyze Runs

%
scenarios=fields(scenario_list);
for ii=1:length(scenarios)
    scen_name=scenarios{ii};
    
    eval(['runs=scenario_list.',scen_name,'.runs;']);
    for jj=1:length(runs)
        run_name=runs{jj};
        
        % Find run path from run directory & run name
        
        % Load lrids and run_info
        
        % Get list of obj_IDs and sim_IDs
        
        %
        eval(['test_type=scenario_list.',scen_name,'.test_type;']);
        eval(['test_bounds=scenario_list.',scen_name,'.boundaries;']);
        test_names=fields(test_bounds);
        for kk=1:length(test_names)
            test=test_names(kk);
            type=test_type(kk);

            if strcmpi(type,'Scenario')
                eval(['[,,,]=',test,'(,,);']);
            elseif strcmpi(type,'Object_ID')
                eval(['[,,,]=',test,'(,,,);']);
            elseif strcmpi(type,'Sim_ID')
                eval(['[,,,]=',test,'(,,,);']);
            else
                disp('*** Error!!! - Test type doesn''t match available cases. ***');
            end   
            
            test=1;
            
            % Assign color based on test result
            cell_color=assign_cell_color();
            
            % Add to  result list
            eval(['metric_results.',test,'=[,,,,cell_color];']);
            
        end
        
        % Add test results to scenario 
        eval(['scenario_list.',scen_name,'.results=metric_results;']);
        
    end        
           
end

test=1;

%% (4)----- Calculate statistical results

%% (5)----- Write data to excel

% % Autofit the rows and columns
% xlsSheet.Columns.AutoFit;
% xlsSheet.Rows.AutoFit;

%% (6)----- Save and close excel
xlsWorkbook.Save;
xlsWorkbook.Close;
xls.Quit;
xls.delete;


%% ---------- %% Sub-Functions %% ---------- %%
function []=assign_cell_color()

