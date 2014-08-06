function [] = waveguide_filter_design_ver4(varargin)

%
% waveguide_filter_design_ver4.m
%
% Description:
%   Given a set of filter design specifications,
%   waveguide_filter_design_ver4.m calculates iris and cavity dimensions to
%   physically realize the filter.
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
%   iris_thickness          -> [in]
%
%   *** Note: All inputs can be passed in directly at the same time or you
%             will be prompted for each one individually at the start of
%             the program.
%
% Outputs:
%   Filter Characteristics, Resonator Lengths, and Iris Widths are
%   displayed at the command line as well as written to a specified text
%   file.  Additionally, HFSS coordinates are written to the text file as
%   well.
%
% Author:
%   Curtis Neiderer, 3/9/2009
%
% Notes / Changes:
%   Version 4: 3/9/2009
%   -   Adds the capability to create a VBScript macro file for use within 
%       HFSS that automatically generates the waveguide filter geometry in 
%       the 3D Modeler, thus saving the time wasted manually drawing the 
%       filter.
%   -   Adds the capability to create an XLS file containing all the filter
%       design specs and calculated dimensions.
%   -   Revamps the way the TXT file contain all the filter design specs is
%       created.  Makes better use of the fprintf function.
%
%   Note 1: 3/9/2009
%   Need to create a GUI containing all of the inputs.  This will make the
%   this program much more user-friendly.
%

%%
if nargin==10
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
    iris_thickness=varargin{10};
else
    % Prompt for details of desired filter design
    passband_ripple=input('Please enter the passband ripple [dB]: ');
    center_freq=input('Please enter the center frequency [GHz]: ');
    lo_corner_freq=...
        input('Please enter the low edge of the passband [GHz]: ');
    hi_corner_freq=...
        input('Please enter the high edge of the passband [GHz]: ');
    lo_attenuation_freq=...
        input('Please enter the low attenuation frequency [GHz]: ');
    hi_attenuation_freq=...
        input('Please enter the high attenuation frequency [GHz]: ');
    desired_attenuation=...
        input('Please enter the desired attenuation [dB]: ');
    waveguide_a=...
        input('Please enter the a dimension of the waveguide [in]: ');
    waveguide_b=...
        input('Please enter the b dimension of the waveguide [in]: ');
    iris_thickness=input('Please enter the iris thickness [in]: ');
end

%% Calculate the guide wavelengths
lo_corner_guideLambda=guide_wavelength_calc(lo_corner_freq,waveguide_a);
hi_corner_guideLambda=guide_wavelength_calc(hi_corner_freq,waveguide_a);
center_freq_guideLambda=(lo_corner_guideLambda+hi_corner_guideLambda)/2;
lo_attenuation_guideLambda=...
    guide_wavelength_calc(lo_attenuation_freq,waveguide_a);
hi_attenuation_guideLambda=...
    guide_wavelength_calc(hi_attenuation_freq,waveguide_a);

%% Calculate guide wavelength fractional bandwidth and fractional bandwidth
bandwidth_guideLambda=(lo_corner_guideLambda-hi_corner_guideLambda)/...
    center_freq_guideLambda;
bandwidth=(hi_corner_freq-lo_corner_freq)/center_freq;

%% Calculate attenuation frequency ratios
lo_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-lo_attenuation_guideLambda)/...
    center_freq_guideLambda));
hi_attenuation_freq_ratio=abs((2/bandwidth_guideLambda)*...
    ((center_freq_guideLambda-hi_attenuation_guideLambda)/...
    center_freq_guideLambda));

%% Calculate epsilon
epsilon=(10^(passband_ripple/10))-1;

%% Calculate filter order
lo_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',...
    num2str(epsilon),'*(cosh(order*acosh(',...
    num2str(lo_attenuation_freq_ratio),')))^2))'],'order')));
lo_filter_order=double(lo_filter_order(1));
hi_filter_order=...
    ceil(real(solve([num2str(desired_attenuation),'=10*log10(1+(',...
    num2str(epsilon),'*(cos(order*acos(',...
    num2str(hi_attenuation_freq_ratio),')))^2))'],'order')));
hi_filter_order=double(hi_filter_order(1));

filter_order=max([lo_filter_order,hi_filter_order]);

% Double-check attenuation based on filter_order calculation
actual_lo_attenuation=10*log10(1+epsilon*...
    (cosh(filter_order*acosh(lo_attenuation_freq_ratio)))^2);
actual_hi_attenuation=10*log10(1+epsilon*...
    (cos(filter_order*acos(hi_attenuation_freq_ratio)))^2);

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
        eval(['g',num2str(k),'=(4*a',num2str(k-1),'*a',num2str(k),')/(b',...
            num2str(k-1),'*g',num2str(k-1),');']);
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
        k_val=sqrt((pi/2)*(bandwidth_guideLambda/...
            (g_values(1)*g_values(2)*1)));
    elseif jj>1 & jj<=(filter_order)
        k_val=((pi*bandwidth_guideLambda)/...
            (2*1))*(1/sqrt(g_values(jj)*g_values(jj+1))); 
    elseif jj==(filter_order+1)
        k_val=sqrt((pi/2)*(bandwidth_guideLambda/...
            (g_values(jj)*g_values(jj+1)*1)));
    end
    k_values=[k_values,k_val];
    
    x_val=k_val/(1-k_val^2);
    x_values=[x_values,x_val];
    
    reactance=(x_val*center_freq_guideLambda)/waveguide_a;
    reactance_values=[reactance_values,reactance];
    
    
    %% Method 1: using eqn for d/a << 1 only
    % for d/a<<1, where d represents iris window width
    d_val=double(solve([num2str(reactance),...
        '=(tan((pi*d)/(2*',num2str(waveguide_a),')))^2*(1+((1/6)*((pi*d)/',...
        num2str(center_freqLambda),')^2))'],'d'));
    iris_values=[iris_values;d_val];
    
end
        
%% Calculate resonator lengths
theta_values=[];
resonator_lengths=[];
for xx=1:filter_order
    
    theta=pi-0.5*(atan(2*x_values(xx))+atan(2*x_values(xx+1)));
    theta_values=[theta_values,theta];
    
    res_length=(theta*center_freq_guideLambda)/(2*pi);
    resonator_lengths=[resonator_lengths;res_length];
    
end

%% Calculate iris and cavity screw positions
%%  (NOTE: There is most likely a much more efficient way to do this, but
%%  this is good enough for now.)
filter_pos=0;
irisscrew_pos=[];
cavityscrew_pos=[];
for zz=1:length(iris_values)

    filter_pos=filter_pos+(iris_thickness/2);
    irisscrew_pos=[irisscrew_pos;filter_pos];
    filter_pos=filter_pos+(iris_thickness/2);

    if zz<=length(resonator_lengths)
        filter_pos=filter_pos+(resonator_lengths(zz)/2);
        cavityscrew_pos=[cavityscrew_pos;filter_pos];
        filter_pos=filter_pos+(resonator_lengths(zz)/2);
    end

end
    
%% Format & save filter design specs into filter_info structure
filter_info.resonators=filter_order;
filter_info.passband_ripple=passband_ripple;
filter_info.center_freq=center_freq;
filter_info.f_lower=lo_corner_freq;
filter_info.f_upper=hi_corner_freq;
filter_info.desired_attenuation=desired_attenuation;
filter_info.lo_att_freq=lo_attenuation_freq;
filter_info.hi_att_freq=hi_attenuation_freq;
filter_info.waveguide_width=waveguide_a;
filter_info.waveguide_height=waveguide_b;
filter_info.cavity_lengths=resonator_lengths;
filter_info.cavity_screws=cavityscrew_pos;
filter_info.iris_widths=iris_values;
filter_info.iris_screws=irisscrew_pos;
filter_info.iris_thickness=iris_thickness;
filter_info.units.length='in';
filter_info.units.freq='GHz';
filter_info.input_cav_length=center_freqLambda/4;

% % Save filter_info structure
% save(fullfile('C:\MATLAB_Toolbox\Results',['filter_data.mat']),...
%     'filter_info');

%% Display filter characteristics and dimensions
disp('=========================')

disp('Filter Characteristics: ')
disp(['  filter order = ',num2str(filter_order)]);
disp(['  passband ripple = ' num2str(passband_ripple),' dB']);
disp(['  center frequency = ',num2str(center_freq),' GHz']);
disp(['  lower corner freq = ',num2str(lo_corner_freq),' GHz']);
disp(['  upper corner freq = ',num2str(hi_corner_freq),' GHz']);
disp(['  desired attenuation = ',num2str(desired_attenuation),' dB']);
disp(['  low rejection freq = ',num2str(lo_attenuation_freq),' GHz']);
disp(['  high rejection freq = ',num2str(hi_attenuation_freq),' GHz']);
disp(['  waveguide width: a = ',num2str(waveguide_a),' in']);
disp(['  waveguide height: b = ',num2str(waveguide_b),'in']);
disp(['  iris thickness = ',num2str(iris_thickness),' in']);

disp('Resonator Lengths [in]: ')
for yy=1:length(resonator_lengths)
    disp(['  res',num2str(yy),'_length = ',...
        num2str(resonator_lengths(yy))]);
end

disp('Iris Widths [in]: ')
for zz=1:length(iris_values)
    disp(['  iris_',num2str(zz-1),',',num2str(zz),'_width = ',...
        num2str(iris_values(zz))])
end

disp('=========================');
disp('');

%%%%%%% ---------- %% Output Files %% ---------- %%%%%%%

%% Draw a simple 3D Model of the Filter Design
draw_3D_Model=input('Draw a 3D model of the filter design (Y/N)? ','s');
if strcmpi(draw_3D_Model,'Y') || strcmpi(draw_3D_Model,'Yes')
    
    % Save 3D model as:
    orig_dir=cd;
    cd('C:\MATLAB_Toolbox\Results');
    [model_name,model_path]=uiputfile('*.fig','Save waveguide filter model as:',...
        ['WG_IndIris_Filter_',datestr(now,30),'.fig']);
    fig_name=fullfile(model_path,model_name);
    cd(orig_dir);
    
    % Draw 3D model
    draw_WG_IndIris_filter(filter_info,fig_name);

end
%% Create text file containing the filter design specs
create_text=input('Create a filter design spec text file (Y/N)? ','s');

if strcmpi(create_text,'Y') || strcmpi(create_text,'Yes')
    
    % Save waveguide filter text as:
    orig_dir=cd;
    cd('C:\MATLAB_Toolbox\Results');
    [text_name,text_path]=uiputfile('*.txt','Save waveguide filter text as:',...
        ['WG_filter_',datestr(now,30),'.txt']);
    TXT_file=fullfile(text_path,text_name);
    cd(orig_dir);
    
    % Create waveguide filter spec text file
    waveguide_filter_txt(filter_info,TXT_file);
    
end

%% Create excel file containing the filter design specs
create_excel=input('Create a filter design spec excel file (Y/N)? ','s');

if strcmpi(create_excel,'Y') || strcmpi(create_excel,'Yes')

    % Save waveguide filter text as:
    orig_dir=cd;
    cd('C:\MATLAB_Toolbox\Results');
    [excel_name,excel_path]=uiputfile('*.xls','Save waveguide filter excel as:',...
        ['WG_filter_',datestr(now,30),'.xls']);
    XLS_file=fullfile(excel_path,excel_name);
    cd(orig_dir);
    
    % Create waveguide filter spec excel file
    waveguide_filter_xls(filter_info,XLS_file);
    
end

%% Create VBScript macro file for HFSS
create_vbscript=input('Create a VBScript macro file for HFSS (Y/N)? ','s');

if strcmpi(create_vbscript,'Y') || strcmpi(create_vbscript,'Yes')    
    
    % Save waveguide filter VBScript macro as:
    [vbs_name,vbs_path]=...
        uiputfile('*.vbs','Save waveguide filter macro as:',...
        ['WG_filter_',datestr(now,30),'.vbs']);
    vbscript_file=fullfile(vbs_path,vbs_name);

    [VBSpath,VBSname,VBSext]=fileparts(vbscript_file);

    % Create waveguide filter macro
    waveguide_filter_vbs(filter_info,VBSname);
    
end

%%%%% ---------- %% Sub-Functions %% ---------- %%%%%

%% Calculates the guide wavelength in inches
function [guideLambda] = guide_wavelength_calc(freq,waveguide_a)
guideLambda=1/sqrt((0.08472*freq)^2-(1/(2*waveguide_a))^2);
