% ArrayCalc V1.0
%
% Directories : ArrayCalc
%                       |___ Element_models
%                       |___ Geometry_construction
%                       |___ Plotting_visualisation
%                       |___ Subroutines
%                       |___ Validation
%
%   MAIN DIRECTORY
%
%   init              - Initialise global variables
%   ex(n)             - Various examples
%
%   ELEMENT MODELS
%
%   patchr            - Rectangular microstrip patch element model
%   patchr_geom       - Patch geometry (pictorial only)
%  
%   patchc            - Circular microstrip patch element model
%   patchc_geom       - Patch geometry (pictorial only)
%
%   helix             - Endfire helix element model
%   helix_geom        - Helix geometry (pictorial only)
%
%   dipole            - Thin wire dipole model
%   dipole_geom       - Dipole geometry (pictorial only)
%
%   dipoleg           - Thin wire dipole over groundplane model
%   dipoleg_geom      - Dipole over ground geometry (pictorial only)
%
%   interp	      - Interpolated data option
%   interp_geom       - User defined geometry (pictorial only)
%
%
%   GEOMETRY CONSTRUCTION
%
%   place_element     - Place an element in specified orientation and location
%   single_element    - As above, but without orientation (default values used)
%   excite_element    - Set amplitude and phase for specified element
%
%   rect_array        - Generate rectangular array geometry using specified elements
%   cylin_array       - Generate cylindrical array geometry using specified elements
%   circ_array        - Generate circular array geometrey using specified elements
%
%   squint_array      - Sets element phases to point main beam in specified direction
%   focus_array       - As for squint_array except there is a focal distance argument
%   taywin_array      - Apply modified Taylor amplitude distribution to array
%
%   move_array        - Move selected array elements in x, y and z
%   movec_array       - Copy selected elements to relative x,y,z location
%   centre_array      - Moves entire array so the extents are equidistant from the origin
%
%   xrot_array        - Rotate selected elements around X-axis
%   yrot_array        - Rotate selected elements around Y-axis
%   zrot_array        - Rotate selected elements around Z-axis
%
%   xrotc_array       - Copy and rotate selected elements around X-axis
%   yrotc_array       - Copy and rotate selected elements around Y-axis
%   zrotc_array       - Copy and rotate selected elements around Z-axis
%
%
%   PLOTTING and VISUALISATION
%
%   plot_theta        - Calculate and plot theta patterns for specified values of phi
%   plot_squint_theta - Calc and plot theta patterns for specified theta squint values
%   plot_phi          - Calculate and plot phi patterns for specified values of theta
%   plot_squint_phi   - Calc and plot phi patterns for specified phi squint values
%   plot_geom3D       - Display array geometry as 3D plot
%   plot_geom2D       - Display array geometry as 2D plot
%   plot_pattern3D    - Plot 3D pattern surface
%   list_array        - List array element locations and excitations
%   plegend           - Put a single legend line on a plot at specified screen co-ordinates
%
%
%   CALCULATION SUBROUTINES
%
%   calc_directivity  - Calculate array directivity using numerical integration
%                       the value can then be used by plot routines, to plot
%                       absolute directivity in dBi
%
%   fieldsum          - Calculate total,vert and horiz E-field at specified farfield point
%   polaxis           - Draw a set of polar axis
%   polplot           - Plot pattern data in polar form
%   circ              - Plot circle (used for polar axis)
%   local2global      - Convert local element coords to global coord system 
%   coord2troff       - Generate rotn & offset matrices from 4pts specified in 2 coord systems
%   sph2cart1         - Spherical to cartesian coord conversion, see Note1
%   cart2sph1         - Cartesian to spherical coord conversion, see Note1 
%                       Note1 : Different angle definitions to Matlab's standard
%
%   theta_cut         - Calculate E-field [theta,[tot,vp,hp]] pattern cut data
%                       over theta range for specified phi
%
%   phi_cut           - Calculate E-field [phi,[tot,vp,hp]] pattern cut data
%                       over phi range for specified theta
%
%   calc_theta        - Calculate theta pattern data [theta,Pwr(dB)] 
%                       for specified value of phi
%
%   calc_phi          - Calculate phi pattern cut data [phi,Pwr(dB)]
%                       for specified value of theta
%
%   rotx              - Generate rotation matrix for rotation about X-axis
%   roty              - Generate rotation matrix for rotation about Y-axis
%   rotz              - Generate rotation matrix for rotation about Z-axis
%
%   textc             - Put text on plot at screen coords
%   plotsc            - Plot lines at screen coords
%
%   design_helix      - Returns helix_config parameters for optimum endfire helix, given
%                       number of turns and the frequency
%
%   design_patchr     - Returns patchr_config parameters for optimum half-wave rectangular
%                       microstrip patch, given the substrate Er & h and the frequency 
%
%   design_patchc     - Returns patchc_config parameters for optimum half-wave circular
%                       microstrip patch, given the substrate Er & h and the frequency 
%
%  
%   VALIDATION
%
%   Comparisons between ArrayCalc and NEC2 results
%
%   loadnecpat        - Load NEC2 radiation pattern data into 
%                       pattern_config (11 columns)
%
%   loadnecpat1       - Load NEC2 radiation pattern data into 
%                       pattern_config (3 columns) theta,phi,Pwr(tot)
%
%   val1              - Validation1 : 2 dipoles 0.7 lambda spacing,
%                       rotated 25Deg about the Y-axis.
%
%   val2	      - A 5x5 array of half-wave dipoles 0.25 lambda 
%		        above a groundplane.
%
%   val3	      - A 3x3 array of 3-turn helicies on a groundplane, 
%                       0.7 lambda spacing.
%
%   val4	      - A 2x2 array of 6-turn helicies on a groundplane,
%                       1.2 lambda spacing.
%
%   val5              - 3 slant (45deg) dipoles spaced evenly around a
%                       circle radius 0.4 lambda.
%
%   val6              - 4 tiers of 3 slant dipoles spaced evenly around a
%                       circle radius 0.4 lambda. Tier spacing 0.8 lambda
%
%   GLOBAL VARIABLES (defined in init.m)
%
%   array_config      - Array of element data : position, excitation, and type
%   freq_config       - Analysis frequency (Hz)
%   velocitr_config   - Wave propagation velocity (m/s)
%   range_config      - Radius at which to sum element field contributions (m)
%   direct_config     - Directivity (dBi)
%   normd_config      - Pattern normalisation value, used with directivity calc.  
%   dBrange_config    - Dynamic range for plots (dB)
%
%   patchr_config     - Rectangular patch element parameters
%   patchc_config     - Circular patch element parameters
%   dipole_config     - Dipole parameters
%   dipoleg_config    - Dipole over ground parameters
%   helix_config      - Helix parameters
%   pattern_config    - Pattern data for interpolated element pattern
%   user1_config      - User element parameters
%
%
%   N. Tucker www.activefrance.com 2009