function [freq, data, freq_noise, data_noise, Zo] = SXPParse(DataFileName, fid_log)

% reads .sxp file data in MDIF (a.k.a. Touchstone / HPEEsof format)
% 
% EXAMPLE :
% [freq, data, freq_noise, data_noise, Zo] = SXPParse(DataFileName, fid_log);
%
% freq, freq_noise  - 1xF arrays
% data              - PxPxF matrix, P- number of ports, F- number of freq points
% data_noise        - Fn x 3, Fn is size(freq_noise), columns are :
%                   - 1. NFmin <dB>, 2. Gamma_opt<complex), 3. rn <normalized>
% Zo                - impedance used in normalization of data
% 
% type ParseSXP('info') for info on MDIF/Touchstone/HPEESof file format
%
% written by Tudor Dima, last rev. 08.03.2006, tudima at yahoo dot com

% ver 1.1 : data in format complex (26feb99)
% ver 1.2 : added noise reading (4martie99)
% ver 1.21: max. nr of ports increased from 9 to 99 (24.04.2002)
% ver 1.3 : 13.03.2003, rescris tot, read line by line, Y,Z, not yet
% ver 1.31: 15.12.2005, switch by type (S,Y,Z);
% ver 1.32: 08.03.2006, handle comment lines anywhere inside body
%           26.01.2008, small bug fixed (again!) in 'db' conversion
%                       better help, info on MDIF standard

if strcmp(DataFileName, 'info') || strcmp(DataFileName, 'help') || strcmp(DataFileName, '?')
    word = strvcat(...
        ' ',...        
        'format of MDIF/Touchstone/HPEESof files :',...
        '    comment line starts with ''!''',...
        '    specifier line is :',...
        '    # <freq_unit> <param> <format> R <reference resistance value>',...
        ' ',...
        'examples :',...
        '    -- S-par, real and imaginary -->',...
        '    #     GHz       S         RI    R 50    ',...
        '    -- Z-par, linear mag and angle <deg> -->         ',...
        '    #     MHz       Z         MA    R 75     ',...
        '    -- Y-par, log mag (dB) and angle <deg> -->         ',...  
        '    #     kHz       Y         DB    R 50    ',...
        '    -- ABCD-par, real and imaginary -->         ',...
        '    #      Hz       ABCD      RI    R 50    ',...
        '',...
        ' (defaults : # MHz S MA R 50)',...
        ' ',...
        ' -------------------------------------------------',...
        ' format of data in file (*.s2p) is :',...
        ' f s11.1 s11.2 s21.1 s21.2 s12.1 s12.2 s22.1 s22.2',...
        ' -------------------------------------------------',...
        '',...
        ' format of data in file (*.sxp) with x>2 is :',...
        ' -------------------------------------------------',...
        ' f s11.1 s11.2 s12.1 s12.2 ... s1x.1 s1x.2',...
        '   s21.1 s21.2 s22.2 s22.2 ... s2x.1 s2x.2',...
        '   ...',...
        '   sx1.1 sx1.2 sx2.1 sx2.2 ... sxx.1 sxx.2',...
        ' -------------------------------------------------',...
        '',...
        'noise data has some HP/Touchstone legacy stuff : ', ...
        ' - noise data will start when the frequency decreases for the',...
        '   first time; otherwise frecuency is monotonically increasing ',...
        ' - Gopt is always MA, irrespective of S data format above (to change this uncomment line 98)',...
        ' - NFmin is always in <dB>, Rn is normalized', ...
        'ex.:',...
        '! freq NFmin Gopt-Mag  Gopt-Ang  Rn(norm!)',...
        '  900   1.8   0.34      135     0.2 ');
    disp(word);
else

    %------- read from file DataFileName -------
    format compact;
    if nargin<2
        fid_log = 1; % no log ? to screen (to check fid_log before passing it...)
    end;

    fid = fopen( DataFileName, 'rt');

    if fid < 1
        fprintf(fid_log, '%s \n %s', ' ... exiting...', ['Error : requested parameter file ' DataFileName ' not found ! ']);
    end;

    if fid > 0
        fprintf(fid_log, '\n %s \n %s', 'reading parameter data from file ', [ DataFileName ' ...']);

        % --- find out matrix order ---
        NoOfPorts = str2num(DataFileName(size(DataFileName,2)-1) );
        candidate_zeci = str2num(DataFileName(size(DataFileName,2)-2) );
        if ~isempty(candidate_zeci)
            NoOfPorts = NoOfPorts + 10*candidate_zeci;
        end; % ugly, works only up to 99, but still...

        % --- init default options ---
        opt.multiplier = 1e6;
        opt.param = 's';
        opt.format = 'ma';
        opt.Zo = 50;
         % -> use MA in noise line, irr. of specifier in #-line
        opt.Touchstone = 'old'; % to change this uncomment nex line 
        % opt.Touchstone = 'new';

        % --- initializeaza niste stuff ---
        data = []; data_noise = []; freq = []; freq_noise = [];
        NoiseStarted = 0;
        GlobalLineNo = 0;
        noise_f_index = 0;

        FreqPoint = 0;
        LastFrequency = 0;

        % --- incepe si citeste linie cu linie ---

        phrase = deblank(lower(fgets(fid)));

        while 1 % ~isempty(phrase) &
            LineDone = 0; if isempty(phrase), phrase = '%'; end;
            if strcmp(phrase(1),'!') || strcmp(phrase(1),'%')
                % do nothing
                LineDone = 1;
            end;
            if strcmp(phrase(1),'#')
                word = Phrase2Word(phrase);
                % ---> crud, fara protexe yet
                for i=2:size(word,1)
                    switch deblank(word(i,:))
                        case {'mhz'}
                            opt.multiplier = 1e6;
                        case 'ghz'
                            opt.multiplier = 1e9;
                        case 'khz'
                            opt.multiplier = 1e3;
                        case 'hz'
                            opt.multiplier = 1;
                        case {'s','z','y','g','h','abcd'}
                            opt.param = deblank(word(i,:));
                        case {'ri','ma','db'}
                            opt.format = deblank(word(i,:));
                        case 'r'
                            opt.Zo = str2num(deblank(word(i+1,:)));
                    end;
                end;
                LineDone = 1;
            end;
            if ~LineDone
                % --- read data one frequency at a time ---
                word = Phrase2Word(phrase);
                if ~isempty(word) % & (NoOfPorts = size(word,2)-1)
                    if str2num(word(1,:)) < LastFrequency % --- check if S or noise
                        NoiseStarted = 1; FreqPoint = 0;
                    end;

                    if ~NoiseStarted
                        FreqPoint = FreqPoint+1; freq(FreqPoint) = str2num(word(1,:)); LastFrequency = freq(FreqPoint);
                        GlobalLineNo = GlobalLineNo+1;
                        raw_data(GlobalLineNo,(1:size(word,1)-1)) = str2num(word((2:size(word,1)),:))';
                        if NoOfPorts > 2
                            LineNo = 1;
                            while LineNo < NoOfPorts
                                % citeste inca o linie
                                word = Phrase2Word(fgets(fid));
                                if ~isempty(word)
                                    LineNo = LineNo+1; GlobalLineNo = GlobalLineNo+1;
                                    raw_data(GlobalLineNo,(1:size(word,1))) = str2num(word((1:size(word,1)),:))';
                                end;
                            end;
                            LineNo = 0;
                        end;

                    else % e zgomot, storeaza tot, incl f
                        FreqPoint = FreqPoint+1; freq_noise(FreqPoint) = str2num(word(1,:)); LastFrequency = freq_noise(FreqPoint);
                        raw_data_noise(FreqPoint,(1:size(word,1)-1)) = str2num(word((2:size(word,1)),:))';
                    end;
                else
                    ExitCode = 1;
                end;
            end;
            phrase = fgets(fid);
            if ~ischar(phrase) break; end;
            phrase = deblank(lower(phrase));
        end; % while phrase contine ceva

        % have raw data, have to arrange it, slice it properly as f(NoOfPorts)

        % intii exceptia 2-port :
        if NoOfPorts == 1
            raw_data_A(1,1,:) = raw_data(:,1); raw_data_B(1,1,:) = raw_data(:,2);
        elseif NoOfPorts == 2
            raw_data_A(1,1,:) = raw_data(:,1); raw_data_B(1,1,:) = raw_data(:,2);
            raw_data_A(2,1,:) = raw_data(:,3); raw_data_B(2,1,:) = raw_data(:,4);
            raw_data_A(1,2,:) = raw_data(:,5); raw_data_B(1,2,:) = raw_data(:,6);
            raw_data_A(2,2,:) = raw_data(:,7); raw_data_B(2,2,:) = raw_data(:,8);
        else % --- cut slices of NoOfPorts, if it fits
            v_ix = (0:size(freq,2)-1)*NoOfPorts;
            for i=1:NoOfPorts
                for j=1:NoOfPorts
                    raw_data_A(i,j,:) = raw_data(v_ix+i,2*j-1);
                    raw_data_B(i,j,:) = raw_data(v_ix+i,2*j);
                end;
            end;
        end;
        
        % using dual-field numbers will calculate complex numbers, f(format_specifier)
        freq = freq * opt.multiplier;
        j=sqrt(-1);
        switch opt.format
            case 'ri'
                data = raw_data_A + j*raw_data_B;
            case 'ma'
                data = raw_data_A .* cos(raw_data_B*pi/180) + j* raw_data_A .* sin(raw_data_B*pi/180);
            case 'db'
                t_mag = 10.^(raw_data_A/20); t_ang = raw_data_B*pi/180;
                data = t_mag .* cos(t_ang) + j* t_mag .* sin(t_ang);
        end;
        % now adjust data f(opt.param) Z,Y,G,H,A
        switch opt.param
            case 'y'
                data = y2s(data*opt.Zo); % to check in standard if Zo always or Yo
            case 'z'
                data = z2s(data/opt.Zo);
            case 'a'
                data = a2s(data); % to double check units...
            case 'g'
                data = g2s(data); % ...
            case 'h'
                data = h2s(data); % ...
        end;
        
        if NoiseStarted % arrange noise data
            freq_noise = freq_noise * opt.multiplier;
            data_noise(:,1) = raw_data_noise(:,1); % NFmin
            data_noise(:,3) = raw_data_noise(:,4); % rn
            switch opt.Touchstone
                case 'new'
                    switch opt.format % gamma opt
                        case 'ri'
                            data_noise(:,2) = raw_data_noise(:,2) + j*raw_data_noise(:,3);
                        case 'ma'
                            t_ang = raw_data_noise(:,3)*pi/180;
                            data_noise(:,2) = raw_data_noise(:,2) .* cos(t_ang) + j* raw_data_noise(:,2) .* sin(t_ang);                            
                        case 'db'
                            t_mag = 10.^(raw_data_noise(:,2)/20); t_ang = raw_data_noise(:,3)*pi/180;
                            data_noise(:,2) = t_mag .* cos(t_ang) + j* t_mag .* sin(t_ang);
                    end;
                case 'old' % is MA anyways, old style Touchstone
                    t_ang = raw_data_noise(:,3)*pi/180;
                    data_noise(:,2) = raw_data_noise(:,2) .* cos(t_ang) + j* raw_data_noise(:,2) .* sin(t_ang);            end;
            end;
            Zo = opt.Zo;
            fprintf(fid_log, '\n%s\n', ['... done.']);
        end;
end;