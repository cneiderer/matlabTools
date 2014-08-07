function sap_struct = read_sap_file(sap_file_loc)
%   UNCLASSIFIED
%
%   DESCRIPTION
%       Reads sap files
%
%   Input:
%        sap_file_loc - Full path of sap file
%
%   Output:
%        sap_struct - SAP structure
%

sap_struct = struct();

if ~exist(sap_file_loc, 'file')
   disp(' ');
   disp(sap_file_loc);
   error('read_sap_file: Incorrect Path');
end

fid = fopen(sap_file_loc, 'r');

try
   sap_strs = textscan(fid, '%s %s', 'delimiter', '=', 'commentStyle', '%');
catch
   fclose(fid);
   return
end

%Got the data, so close the file
fclose(fid);

sap_names = sap_strs{1};
sap_vals  = sap_strs{2};

% wb = waitbar(0, ['Reading File: ' sap_file_loc]);

for ix = 1:length(sap_names)
%     waitbar(ix/length(sap_names), wb)
    %set the field name equal to the specified value
    tmp = sap_names{ix};
    tmp(isspace(tmp)) = [];
   
   %Get the value
   tmp_val = sap_vals{ix};
   tmp_find = findstr(tmp_val, ';');
   
   if any(tmp_find)
      tmp_val( tmp_find:end ) = [];
   end
   
   sap_struct.(tmp) = str2num(tmp_val);
end

% close(wb);
