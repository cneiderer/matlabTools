function [] = SortResults(filePath)

if exist('filePath','var') && exist('filePath','file')
    
else
    filePath='D:\half-marathon_results.txt';
end

% Open text file
fid=fopen(filePath,'r');

% Header lines
header1=fgetl(fid);
header2=fgetl(fid);

% Initialize variables
place=[]; div_place=[]; name=[]; bib_num=[]; age=[];
city_state=[]; time=[]; net_time=[]; pace=[];
time_hr=[]; time_min=[]; time_sec=[];
net_time_hr=[]; net_time_min=[]; net_time_sec=[]; net_time_tenths=[];
pace_min=[]; pace_sec=[];
index=[]; cnt=0;
% Read file line-by-line
tline=fgetl(fid);
while tline~=0
    cnt=cnt+1;
    place=[place;str2double(tline(1:5))];
    div_place=[div_place;{tline(7:14)}];
    name=[name;{tline(16:35)}];
    bib_num=[bib_num;str2double(tline(37:41))];
    age=[age;str2double(tline(43:44))];
    city_state=[city_state;{tline(46:66)}];
    
    time=[time;{tline(68:74)}];
%     time_hr=[time_hr;str2double(tline(68))];
%     time_min=[time_min;str2double(tline(70:71))];
%     time_sec=[time_sec;str2double(tline(73:74))];
    
    net_time=[net_time;{tline(76:86)}];
    net_time_hr=[net_time_hr;str2double(tline(76))];
    net_time_min=[net_time_min;str2double(tline(78:79))];
    net_time_sec=[net_time_sec;str2double(tline(81:82))];
    net_time_tenths=[net_time_tenths;str2double(tline(84))];
    decimal_time=net_time_hr+(net_time_min/60)+(net_time_sec/3600)+(net_time_tenths/36000);
    index=[index;cnt];
    
    pace=[pace;{tline(88:91)}];
%     pace_min=[pace_min;str2double(tline(88:89))];
%     pace_sec=[pace_sec;str2double(tline(90:91))];
    
    % Get next line
    tline=fgetl(fid);
end

test=1;

% Organize results
% overallResults=[place,div_place,name,bib_num,age,city_state,time,net_time,pace,...
%     time_hr,time_min,time_sec,net_time_hr,...
%     net_time_min,net_time_sec,net_time_tenths,...
%     pace_min,pace_sec];

% Sort to find true placement
overall_results=[index,decimal_time];
[sorted_times,original_place]=sort(overall_results,1,'ascend');
organized_results=[sorted_times,original_place(:,2)];

test=1;

fclose(fid);
fclose('all');
