function [f,S] = Readcti1(file)% This function can read cti files in dB Angle or Real Imaginary format
fid=fopen(file,'rt');
tline = 0;
i = 1;
trash1=fgetl(fid);
trash2=fgetl(fid);
trash3=fgetl(fid);
N=0;
while N==0
    tline=fgetl(fid);
    if findstr(tline,'NAME CH1_DATA');
        tline = fscanf(fid, '%s %s %s %f');
        N = tline(11);
    end
end
while (tline~=-1)
    tline = fgetl(fid);
    if strcmp(tline,'DATA S[2,1] RI') | strcmp(tline,'DATA S21 RI')
       %disp('File is Real and Imaginary Components')
       while(tline~=-1)  
            tline=fgetl(fid);
            if strcmp(tline,'VAR_LIST_BEGIN')    
                f = fscanf(fid, '%f', [1 N]); % Read in freq in Hz
                f=f';
                f=f/1e9; % Convert freq to GHz
            end
       end
       tline=fgetl(fid);
       while(tline~=-1)
        tline = fgetl(fid); 
        s = fscanf(fid, '%f,%f', [2 inf]); % Read in S param
        sz = size(s);
        if(sz(1,2) > 1)
         s = s';
         S(:,i) = complex(s(:,1),s(:,2)); % Convert S param to complex num and store in next column of S
         i = i+1;
        end
       end
       
     elseif strcmp(tline,'DATA S[2,1] DBANGLE')
        disp('File is Magnitude and Angular components')
        while(tline~=-1)  
            tline=fgetl(fid);
            if strcmp(tline,'VAR_LIST_BEGIN')    
                f = fscanf(fid, '%f', [1 N]);
                f=f';
                f=f/1e9;
            end
        end
        tline=fgetl(fid);
        while(tline~=-1)
            tline=fgetl(fid);
            s = fscanf(fid, '%f,%f', [2 inf]);
            sz = size(s);
            if(sz(1,2) > 1)
                s = s';
                SdB = s(:,1)
                Sang = s(:,2)
                for ii=1:length(SdB)
                    Sc(ii)=10^(SdB(ii)/20);
                Srad(ii)=(pi/180)*Sang(ii);
                SR(ii)=Sc(ii)*cos(Srad(ii));
                SI(ii)=Sc(ii)*sin(Srad(ii));
                end
                S(:,i)=complex(SR,SI);
                i=i+1;
                end
            end
        end
      
    end

fclose(fid);