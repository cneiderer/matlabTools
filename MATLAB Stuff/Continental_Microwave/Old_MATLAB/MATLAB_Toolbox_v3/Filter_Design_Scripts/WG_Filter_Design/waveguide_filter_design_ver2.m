function [] = waveguide_filter_design_ver2(varargin)

%
% waveguide_filter_design.m
%
% Inputs:
%   passband_ripple         -> [dB]
%   center_freq             -> [GHz]
%   lo_corner_freq          -> [GHz]
%   hi_corner_freq          -> [GHz]
%   lo_attenuation_freq     -> [GHz]
%   hi_attenuation_freq     -> [GHz]
%   desired_attenuation     -> [dB]
%   waveguide_a             -> [in]
%   waveguide_b             -> [in]
%
% Outputs:
%   Filter Characteristics, Resonator Lengths, and Iris Widths are
%   displayed at the command line as well as written to a specified text
%   file.  Additionally, HFSS coordinates are written to the text file as
%   well.
%
% Author:
%   Curtis Neiderer, 1/9/2009
%
% Notes / Changes:
%   Date: 1/12/2009
%   Change 2.1:
%       Calculation and output of HFSS coordinates to text file was added.
%       HFSS_Coord consists of boxes (x,y,z,dx,dy,dz) and offset coordinate
%       sytems (dx,dy,dz)
%   
%   Date: 1/15/2009
%   Change 2.2:
%       Changed the way the number of sections is calculated to use the
%       matlab solve funtion, as well as added a attenuation check at the
%       lower and upper rejection frequencies with the calculated
%       filter_order.
%
%             lo_filter_order=...
%                 ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',num2str(epsilon),...
%                 '*(cosh(order*acosh(',num2str(lo_attenuation_freq_ratio),')))^2))'],'order')));
%             lo_filter_order=double(lo_filter_order(1));
%             hi_filter_order=...
%                 ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',num2str(epsilon),...
%                 '*(cos(order*acos(',num2str(hi_attenuation_freq_ratio),')))^2))'],'order')));
%             hi_filter_order=double(hi_filter_order(1));
%
%             % Double-check attenuation based on filter_order calculation
%             actual_lo_attenuation=10*log10(1+epsilon*(cosh(filter_order*acosh(lo_attenuation_freq_ratio)))^2);
%             actual_hi_attenuation=10*log10(1+epsilon*(cos(filter_order*acos(hi_attenuation_freq_ratio)))^2);
%


%%
if nargin==9
    % Details of desired filter design are
    passband_ripple=varargin{1};
    center_freq=varargin{2};
    lo_corner_freq=varargin{3};
    hi_corner_freq=varargin{4};
    lo_attenuation_freq=varargin{5};
    hi_attenuation_freq=varargin{6};
    desired_attenuation=varargin{7};
    waveguide_a=varargin{8};
    waveguide_b=varargin{9};
else
    % Prompt for details of desired filter design
    passband_ripple=input('Please enter the passband ripple [dB]: ');
    center_freq=input('Please enter the center frequency [GHz]: ');
    lo_corner_freq=input('Please enter the low edge of the passband [GHz]: ');
    hi_corner_freq=input('Please enter the high edge of the passband [GHz]: ');
    lo_attenuation_freq=input('Please enter the low attenuation frequency [GHz]: ');
    hi_attenuation_freq=input('Please enter the high attenuation frequency [GHz]: ');
    desired_attenuation=input('Please enter the desired attenuation [dB]: ');
    waveguide_a=input('Please enter the a dimension of the waveguide [in]: ');
    waveguide_b=input('Please enter the b dimension of the waveguide [in]: ');
end

%% Calculate the guide wavelengths
lo_corner_guideLambda=guide_wavelength_calc(lo_corner_freq,waveguide_a);
hi_corner_guideLambda=guide_wavelength_calc(hi_corner_freq,waveguide_a);
center_freq_guideLambda=(lo_corner_guideLambda+hi_corner_guideLambda)/2;
lo_attenuation_guideLambda=guide_wavelength_calc(lo_attenuation_freq,waveguide_a);
hi_attenuation_guideLambda=guide_wavelength_calc(hi_attenuation_freq,waveguide_a);

%% Calculate guide wavelength fractional bandwidth and fractional bandwidth
bandwidth_guideLambda=(lo_corner_guideLambda-hi_corner_guideLambda)/center_freq_guideLambda;
bandwidth=(hi_corner_freq-lo_corner_freq)/center_freq;

%% Calculate attenuation frequency ratios
lo_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-lo_attenuation_guideLambda)/center_freq_guideLambda));
hi_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-hi_attenuation_guideLambda)/center_freq_guideLambda));

%% Calculate epsilon
epsilon=(10^(passband_ripple/10))-1;

%% Calculate number of sections based on desired attenuation
% required_lo_attenuation_filter_order=...
%     ceil(acosh(sqrt(10^(desired_attenuation/10)-1)/epsilon)/acosh(lo_attenuation_freq_ratio));
% required_hi_attenuation_filter_order=...
%     ceil(acos(sqrt(10^(desired_attenuation/10)-1)/epsilon)/acos(hi_attenuation_freq_ratio));

lo_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',num2str(epsilon),...
    '*(cosh(order*acosh(',num2str(lo_attenuation_freq_ratio),')))^2))'],'order')));
lo_filter_order=double(lo_filter_order(1));
hi_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',num2str(epsilon),...
    '*(cos(order*acos(',num2str(hi_attenuation_freq_ratio),')))^2))'],'order')));
hi_filter_order=double(hi_filter_order(1));

filter_order=max([lo_filter_order,hi_filter_order]);

% Double-check attenuation based on filter_order calculation
actual_lo_attenuation=10*log10(1+epsilon*(cosh(filter_order*acosh(lo_attenuation_freq_ratio)))^2);
actual_hi_attenuation=10*log10(1+epsilon*(cos(filter_order*acos(hi_attenuation_freq_ratio)))^2);

%% Calculate the g values
beta=log(coth(passband_ripple/17.37));
gamma=sinh(beta/(2*filter_order));

g0=1;
filter_g_values.g0=g0;
g_values=g0;
for k=1:filter_order

    eval(['a',num2str(k),'=sin((((2*k)-1)*pi)/(2*filter_order));']);
    eval(['b',num2str(k),'=gamma^2+(sin((k*pi)/filter_order))^2;']);

    %
    if k==1
        g1=(2*a1)/gamma;
        filter_g_values.g1=g1;
        g_values=[g_values,g1];
    else
        eval(['g',num2str(k),'=(4*a',num2str(k-1),'*a',num2str(k),')/(b',num2str(k-1),'*g',num2str(k-1),');']);
        eval(['filter_g_values.g',num2str(k),'=g',num2str(k),';']);
        eval(['g_values=[g_values,g',num2str(k),'];']);
    end

    if k==filter_order
        test_even_odd=mod(filter_order,2);
        if test_even_odd==0
            eval(['g',num2str(k+1),'=(coth(beta/4))^2;']);
        else
            eval(['g',num2str(k+1),'=1;']);
        end
        eval(['filter_g_values.g',num2str(k+1),'=g',num2str(k+1),';']);
        eval(['g_values=[g_values,g',num2str(k+1),'];']);
    end

end

%% Calculate the k_values, x_values, reactances, and iris_widths

center_freqLambda=((3*10^8)/(center_freq*10^9))*(100/2.54);

k_values=[]; 
x_values=[];
reactance_values=[];
iris_values=[];
for jj=1:filter_order+1
    
    if jj==1
        k_val=sqrt((pi/2)*(bandwidth_guideLambda/(g_values(1)*g_values(2)*1)));
    elseif jj>1 & jj<=(filter_order)
        k_val=((pi*bandwidth_guideLambda)/(2*1))*(1/sqrt(g_values(jj)*g_values(jj+1))); 
    elseif jj==(filter_order+1)
        k_val=sqrt((pi/2)*(bandwidth_guideLambda/(g_values(jj)*g_values(jj+1)*1)));
    end
    k_values=[k_values,k_val];
    
    x_val=k_val/(1-k_val^2);
    x_values=[x_values,x_val];
    
    reactance=(x_val*center_freq_guideLambda)/waveguide_a;
    reactance_values=[reactance_values,reactance];
    
    
    %% Method 1: using eqn for d/a << 1 only
    % for d/a<<1, where d represents iris window width
    d_val=double(solve([num2str(reactance),...
        '=(tan((pi*d)/(2*',num2str(waveguide_a),')))^2*(1+((1/6)*((pi*d)/',num2str(center_freqLambda),')^2))'],'d'));
    iris_values=[iris_values,d_val];

%     %% Method 2: using both eqns d/a<<1 and d'/a<<1 [Note: Not quite correct, some negative dimensions]
%     % for d/a<<1, where d represents iris window width
%     d_val=double(solve([num2str(reactance),...
%         '=(tan((pi*d)/(2*',num2str(waveguide_a),')))^2*(1+((1/6)*((pi*d)/3.807)^2))'],'d'));
%     if (d_val/waveguide_a) <= 0.5
%         iris_values=[iris_values,d_val];
%     else
%         % for d'/a<<< 1, where d' represents iris metal width 
%         d_val=double(solve([num2str(reactance),...
%             '=(cot((pi*d)/',num2str(waveguide_a),'))^2*(1+((2/3)*((pi*d)/',num2str(center_freqLambda),'))^2)'],'d'));
%         iris_values=[iris_values,d_val];
%     end
    
end
        
%% Calculate resonator lengths
theta_values=[];
resonator_lengths=[];
for xx=1:filter_order
    
    theta=pi-0.5*(atan(2*x_values(xx))+atan(2*x_values(xx+1)));
    theta_values=[theta_values,theta];
    
    res_length=(theta*center_freq_guideLambda)/(2*pi);
    resonator_lengths=[resonator_lengths,res_length];
    
end

%% Display filter characteristics and dimensions
disp('=========================')

disp('Filter Characteristics: ')
disp(['  filter order = ',num2str(filter_order)])
disp(['  passband ripple = ' num2str(passband_ripple),' dB'])
disp(['  center frequency = ',num2str(center_freq),' GHz'])
disp(['  passband = ',num2str(lo_corner_freq),' GHz to ',num2str(hi_corner_freq),' GHz'])
disp(['  desired attenuation = ',num2str(desired_attenuation),' dB'])
disp(['  low rejection frequency = ',num2str(lo_attenuation_freq),' GHz, ',num2str(actual_lo_attenuation),' dB']);
disp(['  high rejection frequency = ',num2str(hi_attenuation_freq),' GHz, ',num2str(actual_hi_attenuation),' dB']);
disp(['  waveguide dimensions: a = ',num2str(waveguide_a),'in, b = ',num2str(waveguide_b),' in'])

disp('Resonator Lengths [in]: ')
for yy=1:length(resonator_lengths)
    disp(['  res',num2str(yy),'_length = ',num2str(resonator_lengths(yy))])
end

disp('Iris Widths [in]: ')
for zz=1:length(iris_values)
    disp(['  iris_',num2str(zz-1),',',num2str(zz),'_width = ',num2str(iris_values(zz))])
end

disp('=========================')

%% Calculate HFSS Coordinates
iris_thickness=0.04;
offset_cs=1;

HFSS_coord={'','x','y','z','dx','dy','dz'};

HFSS_coord(end+1,:)={'inputair',num2str(-waveguide_a/2),'0','0',num2str(waveguide_a),num2str(center_freqLambda/4),num2str(waveguide_b)};
HFSS_coord(end+1,:)={['CS',num2str(offset_cs)],'0',num2str(center_freqLambda/4),'0','','',''};

for cc=1:length(iris_values)
    
    HFSS_coord(end+1,:)={['iris_',num2str(cc-1),',',num2str(cc)],num2str(-iris_values(cc)/2),'0','0',num2str(iris_values(cc)),num2str(iris_thickness),num2str(waveguide_b)};

    if cc<=length(resonator_lengths)
        offset_cs=offset_cs+1;
        HFSS_coord(end+1,:)={['CS',num2str(offset_cs)],'0',num2str(iris_thickness),'0','','',''};
        HFSS_coord(end+1,:)={['res',num2str(cc)],num2str(-waveguide_a/2),'0','0',num2str(waveguide_a),num2str(resonator_lengths(cc)),num2str(waveguide_b)};
        offset_cs=offset_cs+1;
        HFSS_coord(end+1,:)={['CS',num2str(offset_cs)],'0',num2str(resonator_lengths(cc)),'0','','',''};
    else
        offset_cs=offset_cs+1;
        HFSS_coord(end+1,:)={['CS',num2str(offset_cs)],'0',num2str(iris_values(cc)),'0','','',''};
    end
        
end

HFSS_coord(end+1,:)={'outputair',num2str(-waveguide_a/2),'0','0',num2str(waveguide_a),num2str(center_freqLambda/4),num2str(waveguide_b)};

%% Create text file with filter details
create_textfile=input('Would you like to create a filter_details text file (Y/N)? ','s');
% create_textfile='Y';
if strcmpi(create_textfile,'Y') || strcmpi(create_textfile,'Yes')
 
    % Select name and location to store file
    [filename,filepath]=uiputfile('*.txt','Save filter details as: ',['filter_details_',datestr(now,1),'.txt']);
    filter_file=fullfile(filepath,filename);

%     filter_file=fullfile(cd,['filter_design_details_',datestr(now,1),'.txt']);

    % Open text file for editing
    [fid,message]=fopen(filter_file,'wt+');

    % Add file name and date created
    fprintf(fid,'\n');
    fprintf(fid,['File Name: ',filename,'\n']);
    fprintf(fid,['Date Created: ',datestr(now,1),'\n']);

    fprintf(fid,'\n');
    fprintf(fid,'=========================\n');
    fprintf(fid,'\n');

    % Add Filter Characteristics
    fprintf(fid,'Filter Characteristics: \n');
    fprintf(fid,['  filter order = ',num2str(filter_order),'\n']);
    fprintf(fid,['  passband ripple = ' num2str(passband_ripple),' dB \n']);
    fprintf(fid,['  center frequency = ',num2str(center_freq),' GHz','\n']);
    fprintf(fid,['  passband = ',num2str(lo_corner_freq),' GHz to ',num2str(hi_corner_freq),' GHz \n']);
    fprintf(fid,['  desired attenuation = ',num2str(desired_attenuation),' dB','\n']);
    fprintf(fid,['  low rejection frequency = ',num2str(lo_attenuation_freq),' GHz, attenuation = ',num2str(actual_lo_attenuation),' dB \n']);
    fprintf(fid,['  high rejection frequency = ',num2str(hi_attenuation_freq),' GHz, attenuation = ',num2str(actual_hi_attenuation),' dB \n']);
    fprintf(fid,['  waveguide dimensions: a = ',num2str(waveguide_a),'in, b = ',num2str(waveguide_b),' in \n']);

    fprintf(fid,'\n');

    % Add Resonator Lengths
    fprintf(fid,'Resonator Lengths [in]: \n');
    for yy=1:length(resonator_lengths)
        fprintf(fid,['  res',num2str(yy),'_length = ',num2str(resonator_lengths(yy)),'\n']);
    end

    fprintf(fid,'\n');

    % Add Iris Widths
    fprintf(fid,'Iris Widths [in]: \n');
    for zz=1:length(iris_values)
        fprintf(fid,['  iris_',num2str(zz-1),',',num2str(zz),'_width = ',num2str(iris_values(zz)),'\n']);
    end
    
    fprintf(fid,'\n');
    
    % Add HFSS Coordinates
    fprintf(fid,'HFSS Coordinates [in]: \n');
    [hfss_rows,hfss_cols]=size(HFSS_coord);
    for aa=1:hfss_rows
        for bb=1:hfss_cols
            if length(char(HFSS_coord(aa,bb))) < 8
                padding=find_padding(char(HFSS_coord(aa,bb)));
                fprintf(fid,[char(HFSS_coord(aa,bb)),padding,'\t']);
            else
                fprintf(fid,[char(HFSS_coord(aa,bb)),'\t']);
            end
        end
        fprintf(fid,'\n');
    end

    fclose(fid);

end



%% ---------- %% Sub-Functions %% ---------- %%

% Calculates the guide wavelength in inches
function [guideLambda] = guide_wavelength_calc(freq,waveguide_a)
guideLambda=1/sqrt((0.08472*freq)^2-(1/(2*waveguide_a))^2);

% Calculates padding for formatting HFSS_coord
function [padding] = find_padding(coord)
coord_length=length(coord);
switch coord_length
    case 7
        padding=' ';
    case 6
        padding='  ';
    case 5
        padding='   ';
    case 4
        padding='    ';
    case 3
        padding='     ';
    case 2
        padding='      ';
    case 1
        padding='       ';
    case 0
        padding='        ';
    otherwise
        disp('No passing cases exist')
        padding='';
end