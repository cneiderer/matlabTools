function createHtmlReport(dirName)

% function createHtmlReport(dirName)
% This function generates an html report file for all m-files of the given
% folder (dirName).
% 
% Theodoros Giannakopoulos
% http://www.di.uoa.gr/~tyiannak
%
% 2009
%

% List all m-files in given directory:
D = dir([dirName '\\*.m']);

% Initialize string cell {fileNames, help string}xNumOfFiles:
str2write = cell(length(D)+1,2);

% Open html file for write:
fp = fopen('report.html','w');

% Write html tags and title...:
fprintf(fp, '<html>\n');
fprintf(fp, '<title>\n');
fprintf(fp, 'M-files Report for folder %s\n',dirName);
fprintf(fp, '</title>\n');
fprintf(fp, '<hr>');
fprintf(fp, '<font size = "5">M-files Report for folder "%s"</font>\n',dirName);
fprintf(fp, '<hr>');
fprintf(fp, '<body>\n');

fprintf(fp, '<font face="verdana" size = "3">\n');

% compute total size of m-files:
SUM = 0; for (i=1:length(D)) SUM = SUM + D(i).bytes; end

% Write general information:
fprintf(fp, '<p><b> General Information:\n');
fprintf(fp, '<table border="1">\n');
fprintf(fp, '<tr><td bgcolor="99aaff">Total Number of m-files:</td><td bgcolor="99aaff">%d</td>\n',length(D));
fprintf(fp, '<tr><td bgcolor="ffbb99">Total Size of m-files:</td><td bgcolor="ffbb99">%.2f KBs</td>\n',SUM/1024);
fprintf(fp, '</table>\n');


% Write table of m-files and help descriptions:
fprintf(fp, '<p><b>File List:\n');
fprintf(fp, '<table border="1">\n');
fprintf(fp, '<tr><td bgcolor="aaccee"><b>No</td><td bgcolor="eeddaa"><b>Filename</td><td bgcolor="bbeecc"><b>Description</td><td bgcolor="8899aa"><b>Size (KBs)</td></tr>\n');


for (i=1:length(D)) % for each .m file in the given folder:
    % create new html table row:
    fprintf(fp, '<tr>\n');
    fprintf(fp, '<td bgcolor="bbddff">%d</td>',i);
    fprintf(fp, '<td  bgcolor="ffeebb">');
    str2write{i,1} = D(i).name;
    fprintf(fp, '%s',D(i).name);
    fprintf(fp, '</td>\n');
    fprintf(fp, '<td  bgcolor="ccffdd">');
    str2write{i,2} = help([dirName '\\' D(i).name]);        
    str = str2write{i,2};    
    RUN = 1;
    if (length(str)>0)
        while (RUN==1)
            for (j=1:length(str)) 
                if (str(j)==char(10))                 
                    strNew = [str(1:j-1) '<br>' str(j+1:end)];
                    break;
                end; 
            end
            if (j==length(str))
                RUN = 0;
            else
                str = strNew;
            end                
        end
    else
        str = ' <i> No Help Found</i>';
    end
    fprintf(fp, '%s',str);
    fprintf(fp, '</td>\n');
    fprintf(fp, '<td  bgcolor="99aabb">\n');
    fprintf(fp, '%4.1f',D(i).bytes/1024);
    fprintf(fp, '</td>\n');
    
    fprintf(fp, '</tr>\n');
end


fprintf(fp, '</table>\n');
fprintf(fp, '</font>\n');
fprintf(fp, '</body>\n');
fprintf(fp, '</html>\n');
fclose(fp);
