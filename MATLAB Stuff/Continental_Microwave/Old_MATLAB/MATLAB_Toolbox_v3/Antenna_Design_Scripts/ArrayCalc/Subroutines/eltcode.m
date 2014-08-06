function [Elt]=eltcode(eltype)
% Returns element code assignment for use in the array_config variable.
%
% Usage: [Elt]=eltcode(eltype)
%
% eltype....Element type (string)
%
% Returned value:
%
% elt.......Element code (integer)
%
% Valid strings for eltype are listed below. 
%         Input String    Returned value elt     
%              'iso'             0
%              'patchr'          1
%              'patchc'          2
%              'dipole'          3
%              'dipoleg'         4
%              'helix'           5
%              'interp'          6 
%              'user1'           7


switch eltype                % Assign numeric code for element type
 case 'iso',Elt=0;
 case 'patchr',Elt=1;
 case 'patchc',Elt=2; 
 case 'dipole',Elt=3;
 case 'dipoleg',Elt=4;
 case 'helix',Elt=5;
 case 'interp',Elt=6;
 case 'user1',Elt=7; 
 otherwise, disp('Unknown Element Type, set to iso');Elt=0;
end