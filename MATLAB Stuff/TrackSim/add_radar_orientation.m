function site = add_radar_orientation(site, az, el, clk)
%     site = Add_radar_orientation(site, az, el, clk)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Adds or updates site structure using current or new az, el, clk.
%      This function will use the az, el , and clock angles in site to add
%      or update the SF and FS matrices in the global structure site.  User
%      has the option to pass a new az, el, and clock angle into the
%      function to update the site structure, else the az, el and clock
%      are taken from the current site fields.
%
%   Input:
%        site --  structure of site specific parameters.  Contained fields:
%           az     --  Azimuth angle of radar face, in radians.
%           el     --  Eelvation angle of radar face, in radians.
%           clock  --  Clock angle of radar face, in radians.
%        az   --  Azimuth angle of radar face, in radians.
%        el   --  Eelvation angle of radar face, in radians.
%        clk  --  Clock angle of radar face, in radians.
%
%   Output:
%        site --  Structure of site specific parameters.  Modified or added
%                 fields:
%           az              --  Azimuth angle of radar face, in radians.
%           el              --  Eelvation angle of radar face, in radians.
%           clock           --  Clock angle of radar face, in radians.
%           radar_attitude  --  [ az el clock ]  (radians)
%           fs              --  rrc (site) to rfc (face) transformation matrix
%           sf              --  rfc (face) to rrc (site) transformation matrix
%           d_RRC_RFC       --  the vector of misalignment errors
%
%   Required Functions:
%       Get_T_RRC_RFC
%

if nargin == 1
   clk =   site.clock;
   az  =   site.az;
   el  =   site.el;
elseif nargin == 4
   site.clock          = clk;
   site.az             = az;
   site.el             = el;
   site.radar_attitude = [az el clk];
else
   error(' Incorrect use of input arguments. ');
end    

%
% This is the rrc to rfc transformation matrix
%  T_RRC_RFC
site.fs = get_T_rrc_rfc(clk, az, el);

%
%  T_RFC_RRC
site.sf = site.fs'; % This is the rfc to rrc transformation matrix

%  d_RRC_RFC - the vector of misalignment errors
site.d_RRC_RFC = zeros(3,1);

return

%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
