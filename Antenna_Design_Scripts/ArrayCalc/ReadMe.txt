To add the ArrayCalc toolbox to MATLAB :

UnZip the files, resulting in a directory structure
that should look like this :

% Directories : ArrayCalc
%                       |___ Element_models
%                       |___ Geometry_construction
%                       |___ Plotting_visualisation
%                       |___ Subroutines
%                       |___ Validation

Ideally the path to ArrayCalc should be :

c:\matlab\toolbox\ArrayCalc

If not then the validation examples val1-6 & ex3 will
not run, the path to the NEC output files will need to be
changed in LoadNecPat1.m in the Validation directory. 
Type help LoadNecPat1 for more information.

Once copied into the MATLAB directory the appropriate
paths will have to be added in the usual way.

help ArrayCalc : Gives the contents file listing
ex1,ex2...ex5  : Run some examples
val1....val6   : Run some validations against NEC2 results

Have fun !!!!!

N. Tucker www.activefrance.com 2009
