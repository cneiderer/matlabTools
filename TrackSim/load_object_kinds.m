function object_kinds = load_object_kinds
%     object_kinds = LoadObjectKinds
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%        This function creates the structure object_kinds.  This represents
%   the object kind names and values used in the simulation.
%
%   Input:
%        none
%
%   Output:
%        object_kinds  --  A structure containing the names and values of
%                          the object kind values
%           None
%           UnknownABOTBMICBM
%           UnknownABO
%           ThreatTBM
%           NonThreatTBM
%           UnknownTBM
%           Config2
%           InvalidOK
%           UnknownICBM
%           ThreatICBM
%           NonThreatICBM
%           missile_oks         --  a vector of the object kind numbers
%                                   that represent all the object kinds
%                                   associated with a missile
%
%   Required Functions:
%        None
%

object_kinds = struct( ...
   'None', 0, ...
   'UnknownABOTBMICBM', 1, ...
   'UnknownABO', 2, ...
   'ThreatTBM', 3, ...
   'NonThreatTBM', 4, ...
   'UnknownTBM', 5, ...
   'Config2', 6, ...
   'InvalidOK', 7, ...
   'UnknownICBM', 8, ...
   'ThreatICBM', 9, ...
   'NonThreatICBM', 10);

object_kinds.missile_oks = [object_kinds.UnknownTBM; ...
   object_kinds.ThreatTBM; ...
   object_kinds.NonThreatTBM; ...
   object_kinds.ThreatICBM; ...
   object_kinds.NonThreatICBM; ...
   object_kinds.UnknownICBM];

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
