% Initialise main variables

% Define global configuration variables

global array_config;    % Array of element data : position, excitation, and type
global freq_config;     % Analysis frequency (Hz)
global velocity_config; % Wave Propagation velocity (m/s)
global range_config;    % Radius at which to sum element field contributions (m)
global direct_config;   % Directivity value (dBi)
global normd_config;    % Normalisation factor for pattern i.e. the value
                        % of the Etot pattern at the point of max directivity.
                        % Value is used to normalise pattern before directivity
                        % is added (dB)
 
global dBrange_config;  % Dynamic range for plots (dB)
global patchr_config;   % Rectangular patch element parameters
global patchc_config;   % Circular patch element parameters
global dipole_config;   % Dipole parameters
global dipoleg_config;  % Dipole over ground parameters
global helix_config;    % Helix parameters
global pattern_config;  % Pattern data for interpolated element pattern
global user1_config;    % User element parameters


% array_config : Array of form (3x5xN)
%                Defining element orientation, location, 
%                excitation and type.
%
% For each of n=1:N elements there is a 3x5 element
% matrix which defines the element's location, orientation
% excitation and type.
%
%                     /---------- 3x3 rotation matrix
%                    /    /------ 3x1 offset matrix
%                   /    /   /--- Amplitude,Phase,ElementType (1,2,3..)
%                  /    /   /
%               ----- ---- ---
%               L M N Xoff Amp
%   3x5 matrix  O P Q Yoff Pha
%               R S T Zoff Elt
%
%   Valid strings for eltype are listed below. 
%              STRING    VALUE IN array_config
%              'iso'             0
%              'patchr'          1
%              'patchc'          2
%              'dipole'          3
%              'dipoleg'         4
%              'helix'           5
%              'interp'          6
%              'user1'           7
%
%    Amplitude is stored as (linear volts)  
%    Phase is stored as (radians)


array_config=-ones(3,5,1);  % Initialise element array for a single element
freq_config=300e6;          % Set analysis frequency to 300MHz (lambda=1m)
velocity_config=3e8;        % Set wave propagation velocity to 3e8 (m/s)
range_config=999;           % Radius for summation of field contributions (m)
direct_config=0;            % Directivity set to 0dBi
normd_config=0;             % Normalisation factor set to 0dB
dBrange_config=40;          % Dynamic range for plots dB

% Dipole parameters
length=0.5;              % Length (m)
dipole_config=length;    % Define vector of parameters

% Dipole over ground parameters
len=0.5;                 % Length (m)
h=0.25;                  % Height above ground (m)
dipoleg_config=[len,h];  % Define vector of parameters

% Rectangular patch parameters
Er=1;                     % Dielectric constant for substrate
W=0.5;                    % Patch width (m) affects H-plane beamwidth
L=0.431;                  % Patch length (m) affects E-plane beamwidth
h=0.05;                   % Patch height (m) affects E & H plane beamwidth
patchr_config=[Er,W,L,h]; % Define vector of parameters

% Circular patch parameters
Er=1;                     % Dielectric constant for substrate
a=0.2;                    % Patch radius (m) affects H-plane beamwidth
h=0.05;                   % Patch height (m) affects E & H plane beamwidth
patchc_config=[Er,a,h];   % Define vector of parameters

% Helix parameters
N=6;                     % Number of turns
S=0.27;                  % Turn spacing (m)
helix_config=[N,S];      % Define vector of parameters

% User Element1 params
Parameter1=1;              
Parameter2=2;
user1_config=[Parameter1,Parameter2];