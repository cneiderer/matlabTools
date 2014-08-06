Matlab  RFutilities

Written and tested on MATLAB Version 5
Hopefully all will be well on subsequent versions...

These Matlab m-files were originally written to display measured
or calculated input impedances.  The collection of routines 
allows data to be plotted as Smith Chart, Admittance Chart, 
Return Loss, VSWR and Mismatch Loss. Frequency markers can be 
added to each of the plot types.

Over time the routines have been added to so that measured/calculated
impedance can be modified before display. A simple transmission line
model allows measured data to be de-embedded (using a –ve length). 
Matching can be achieved using lumped L,C,R elements or transmission lines.

There are CITI file loaders for the HP standard data format and a
time domain reflectometry function (actually chirp-Z transform) to
display impedance as a function of distance.

The routines that deal with input impedance use the form Zin=A+jB Ohms,
rather than the reflection coefficient  S11,S22 etc. This is simply because
I feel it is easier and more intuitive to work with input impedance in
this form.

An additional set of routines to display the transmission parameters :
Insertion Loss, Phase Delay and Group Delay use the usual S-parameter
form S21,S12 etc. Again because I feel it is easier  to work with 
transmission parameters in this form.

There are routines to convert  between S11  and Zin there is a function
to convert standard S-param to mixed mode S-param, allowing differential
and common mode impedances to be displayed. 

All m-files have help-comments and there are numerous example scripts.
The files are split between 2 folders ‘RFutils’ and ‘Rfutils_S’. 

Ideally these should be copied into the Matlab toolbox directory so the
search paths become : 
C:\ Matlab\toolbox\Rfutils 
C:\ Matlab\toolbox\Rfutils_S

This is so that the example files that load test data have the correct
pathname. Examples that use pathnames are identified in contents.m in Rfutils.

Once you have copied the files and added them to Matlab’s search paths, type :
help rfutils  - lists all the functions in Rfutils and Rfutils_S
example1      -  run example1
example2      -  run example2 etc...through to 11

Thankyou for taking the time to give these utilities a whirl, enjoy!

N. Tucker   www.activefrance.com
