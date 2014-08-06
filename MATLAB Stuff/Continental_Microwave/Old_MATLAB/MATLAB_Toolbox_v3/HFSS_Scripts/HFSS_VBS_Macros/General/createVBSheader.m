function [] = createVBSheader(fid,VBS_filename)

%
% createVBSheader.m
%

fprintf(fid, ''' \n');
fprintf(fid, ''' VBS File Name: \n');
fprintf(fid, ''' %s \n',VBS_filename);
fprintf(fid, ''' \n');
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, ''' Script Created by Curtis Neiderer via MATLAB \n');
fprintf(fid, ''' %s \n',datestr(now,0));
fprintf(fid, ''' ---------------------------------------------- \n');
fprintf(fid, ''' \n');
fprintf(fid, '\n');


