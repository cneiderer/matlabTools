(*^

::[	frontEndVersion = "Microsoft Windows Mathematica Notebook Front End Version 2.2";
	microsoftWindowsStandardFontEncoding;
	fontset = title, "Arial", 24, L0, center, nohscroll, bold;
	fontset = subtitle, "Arial", 18, L0, center, nohscroll, bold;
	fontset = subsubtitle, "Arial", 14, L0, center, nohscroll, bold;
	fontset = section, "Arial", 14, L0, bold, grayBox;
	fontset = subsection, "Arial", 12, L0, bold, blackBox;
	fontset = subsubsection, "Arial", 10, L0, bold, whiteBox;
	fontset = text, "Arial", 12, L0;
	fontset = smalltext, "Arial", 10, L0;
	fontset = input, "Courier New", 12, L0, nowordwrap, bold;
	fontset = output, "Courier New", 12, L0, nowordwrap;
	fontset = message, "Courier New", 10, L0, nowordwrap, R65280;
	fontset = print, "Courier New", 10, L0, nowordwrap;
	fontset = info, "Courier New", 10, L0, nowordwrap;
	fontset = postscript, "Courier New", 8, L0, nowordwrap;
	fontset = name, "Arial", 10, L0, nohscroll, italic, B65280;
	fontset = header, "Times New Roman", 10, L0, right, nohscroll;
	fontset = footer, "Times New Roman", 10, L0, right, nohscroll;
	fontset = help, "Arial", 10, L0, nohscroll;
	fontset = clipboard, "Arial", 12, L0, nohscroll;
	fontset = completions, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = graphics, "Courier New", 10, L0, nowordwrap, nohscroll;
	fontset = special1, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = special2, "Arial", 12, L0, center, nowordwrap, nohscroll;
	fontset = special3, "Arial", 12, L0, right, nowordwrap, nohscroll;
	fontset = special4, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = special5, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = leftheader, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = leftfooter, "Arial", 12, L0, nowordwrap, nohscroll;
	fontset = reserved1, "Courier New", 10, L0, nowordwrap, nohscroll;]
:[font = title; inactive; nohscroll; center; ]
DrawFilt - Drawing Filters
:[font = subsubtitle; inactive; nohscroll; center; ]
Miroslav D. Lutovac and Dejan V. Tosic
:[font = section; inactive; ]
Info
:[font = info; inactive; nowordwrap; ]
(*  DrawMath                                                      
     Filter realization generated from DrawFilt  v2.1             
                                                                  
                 Draw Filter Realizations                         
                                                                  
   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21       
   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/ 
   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/  
   Copyright (c) 1999-2000 by Lutovac & Tosic                     
   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
                                                                  
   See also:                                                      
   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans            
        Filter Design for Signal Processing                       
           Using MATLAB and Mathematica                           
        Prentice Hall - ISBN 0-201-36130-2                        
         http://www.prenhall.com/lutovac           *)
:[font = section; inactive; startGroup; backColorRed65280; backColorGreen65280; backColorBlue65280; fontColorRed0; fontColorGreen0; fontColorBlue0; bold; fontName = "Arial"; fontSize = 14; ]
Initialize
:[font = input; endGroup; nowordwrap; backColorRed65280; backColorGreen65280; backColorBlue65280; fontColorRed0; fontColorGreen0; fontColorBlue0; bold; fontName = "Courier New"; fontSize = 10; ]
SetDirectory["C:\\AFD\\DRAWFILT"];
SetDirectory[HomeDirectory[]];
<<AFD\DrawFilt\drawflib.m
<<AFD\DrawFilt\drawmath.m
:[font = section; inactive; backColorRed65280; backColorGreen65280; backColorBlue65280; fontColorRed0; fontColorGreen0; fontColorBlue0; bold; fontName = "Arial"; fontSize = 14; ]
Schematic
:[font = input; startGroup; nowordwrap; backColorRed65280; backColorGreen65280; backColorBlue65280; fontColorRed0; fontColorGreen0; fontColorBlue0; bold; fontName = "Courier New"; fontSize = 12; ]
DrawMath[0,0,1,5,10];
:[font = postscript; inactive; output; endGroup; BITMAP; PostScript; pictureLeft = 100; pictureTop = 0; pictureWidth = 701; pictureHeight = 337; nowordwrap; ]
%!
%%Creator: Mathematica
%%AspectRatio: .48077 
MathPictureStart
%% Graphics
/Courier findfont 10  scalefont  setfont
% Scaling calculations
-0.0128205 0.03663 -0.190018 0.03663 [
p
/Times findfont 10 scalefont setfont
[( )] .2619 .39606 0 -1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .2619 .35943 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .2619 .35943 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .44505 .39606 0 -1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .44505 .35943 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .44505 .35943 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .62821 .39606 0 -1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .62821 .35943 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .62821 .35943 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .34127 .30449 1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .52442 .30449 1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .15812 .30449 1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .62821 .17628 0 1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .62821 .21291 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .62821 .21291 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .44505 .17628 0 1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .44505 .21291 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .44505 .21291 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .2619 .17628 0 1 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .2619 .21291 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .2619 .21291 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(h[1] )] .32906 .12439 -1 3 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .32906 .12439 -1 1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(h[2] )] .51221 .12439 -1 3 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .51221 .12439 -1 1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(h[0] )] .14591 .12439 -1 3 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .14591 .12439 -1 1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(x[n] )] .08333 .35943 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(1 )] .17033 .36126 0 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(2 )] .35348 .36126 0 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(3 )] .53663 .36126 0 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(14 )] .72161 .21474 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(5 )] .53846 .21474 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(6 )] .35531 .21474 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(7 )] .17216 .21474 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(8 )] .13095 .17628 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(9 )] .3196 .17628 -1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(10 )] .50275 .17628 -1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .32906 .04808 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .51221 .04808 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(y[n] )] .80678 .02976 -1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(11 )] .13095 .06639 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(12 )] .3141 .06639 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(13 )] .49725 .06639 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(16 )] .35531 .03159 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(17 )] .53846 .03159 -1 -1 Msboxa
P
p
/Times-Bold findfont 12 scalefont setfont
[(Linear-phase )] .35348 .46932 0 0 Msboxa
P
p
/Times-Bold findfont 12 scalefont setfont
[(FIRrealizationtype2 )] .35348 .43269 0 0 Msboxa
P
p
/Times-Bold findfont 11 scalefont setfont
[( )] .97619 .35943 0 0 Msboxa
P
p
/Times-Bold findfont 11 scalefont setfont
[( )] .02381 .35943 0 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .70757 .30449 1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(h[3] )] .69536 .12439 -1 3 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .69536 .12439 -1 1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .69536 .04808 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[( )] .8663 .28617 -1 0 Msboxa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .82967 .28617 1 0 Msboxa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .82967 .28617 -1 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(4 )] .71978 .36126 0 -1 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(15 )] .6859 .17628 -1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(18 )] .6804 .06639 1 0 Msboxa
P
p
/Times findfont 10 scalefont setfont
[(19 )] .75824 .03159 -1 -1 Msboxa
P
p
/Times-Bold findfont 11 scalefont setfont
[( )] .97619 .35943 0 0 Msboxa
P
p
/Times-Bold findfont 11 scalefont setfont
[( )] .02381 .35943 0 0 Msboxa
P
[ 0 0 0 0 ]
[ 1 .48077 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
p
P
p
p
.004 w
.17033 .35943 m
.23443 .35943 L
.23443 .3869 L
.28938 .3869 L
.28938 .33196 L
.23443 .33196 L
.23443 .3869 L
.28938 .3869 L
.28938 .35943 L
.35348 .35943 L
s
.2207 .36401 m
.22985 .35943 L
.2207 .35485 L
s
p
/Times findfont 10 scalefont setfont
[( )] .2619 .39606 0 -1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .2619 .35943 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .2619 .35943 -1 -1 Mshowa
P
P
p
.004 w
.35348 .35943 m
.41758 .35943 L
.41758 .3869 L
.47253 .3869 L
.47253 .33196 L
.41758 .33196 L
.41758 .3869 L
.47253 .3869 L
.47253 .35943 L
.53663 .35943 L
s
.40385 .36401 m
.413 .35943 L
.40385 .35485 L
s
p
/Times findfont 10 scalefont setfont
[( )] .44505 .39606 0 -1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .44505 .35943 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .44505 .35943 -1 -1 Mshowa
P
P
p
.004 w
.53663 .35943 m
.60073 .35943 L
.60073 .3869 L
.65568 .3869 L
.65568 .33196 L
.60073 .33196 L
.60073 .3869 L
.65568 .3869 L
.65568 .35943 L
.71978 .35943 L
s
.587 .36401 m
.59615 .35943 L
.587 .35485 L
s
p
/Times findfont 10 scalefont setfont
[( )] .62821 .39606 0 -1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .62821 .35943 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .62821 .35943 -1 -1 Mshowa
P
P
p
p
.004 w
newpath
.35348 .28617 .01832 0 365.73 arc
s
.34432 .28617 m
.36264 .28617 L
.35348 .28617 L
.35348 .29533 L
.35348 .27701 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .34127 .30449 1 -1 Mshowa
P
p
.5 Mabswid
.37179 .28617 Mdot
P
p
.004 w
.35043 .3167 m
.35348 .31059 L
.35653 .3167 L
s
.35348 .3228 m
.35348 .30449 L
s
P
p
.004 w
.32906 .28922 m
.32295 .28617 L
.32906 .28312 L
s
.31685 .28617 m
.33516 .28617 L
s
P
p
.004 w
.35043 .25565 m
.35348 .26175 L
.35653 .25565 L
s
.35348 .24954 m
.35348 .26786 L
s
P
P
p
p
.004 w
newpath
.53663 .28617 .01832 0 365.73 arc
s
.52747 .28617 m
.54579 .28617 L
.53663 .28617 L
.53663 .29533 L
.53663 .27701 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .52442 .30449 1 -1 Mshowa
P
p
.5 Mabswid
.55495 .28617 Mdot
P
p
.004 w
.53358 .3167 m
.53663 .31059 L
.53968 .3167 L
s
.53663 .3228 m
.53663 .30449 L
s
P
p
.004 w
.51221 .28922 m
.50611 .28617 L
.51221 .28312 L
s
.5 .28617 m
.51832 .28617 L
s
P
p
.004 w
.53358 .25565 m
.53663 .26175 L
.53968 .25565 L
s
.53663 .24954 m
.53663 .26786 L
s
P
P
p
p
.004 w
newpath
.17033 .28617 .01832 0 365.73 arc
s
.16117 .28617 m
.17949 .28617 L
.17033 .28617 L
.17033 .29533 L
.17033 .27701 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .15812 .30449 1 -1 Mshowa
P
p
.5 Mabswid
.18864 .28617 Mdot
P
p
.004 w
.16728 .3167 m
.17033 .31059 L
.17338 .3167 L
s
.17033 .3228 m
.17033 .30449 L
s
P
p
.004 w
.14591 .28922 m
.1398 .28617 L
.14591 .28312 L
s
.1337 .28617 m
.15201 .28617 L
s
P
p
.004 w
.16728 .25565 m
.17033 .26175 L
.17338 .25565 L
s
.17033 .24954 m
.17033 .26786 L
s
P
P
p
.004 w
.53663 .21291 m
.60073 .21291 L
.60073 .24038 L
.65568 .24038 L
.65568 .18544 L
.60073 .18544 L
.60073 .24038 L
.65568 .24038 L
.65568 .21291 L
.71978 .21291 L
s
.66941 .21749 m
.66026 .21291 L
.66941 .20833 L
s
p
/Times findfont 10 scalefont setfont
[( )] .62821 .17628 0 1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .62821 .21291 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .62821 .21291 -1 -1 Mshowa
P
P
p
.004 w
.35348 .21291 m
.41758 .21291 L
.41758 .24038 L
.47253 .24038 L
.47253 .18544 L
.41758 .18544 L
.41758 .24038 L
.47253 .24038 L
.47253 .21291 L
.53663 .21291 L
s
.48626 .21749 m
.47711 .21291 L
.48626 .20833 L
s
p
/Times findfont 10 scalefont setfont
[( )] .44505 .17628 0 1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .44505 .21291 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .44505 .21291 -1 -1 Mshowa
P
P
p
.004 w
.17033 .21291 m
.23443 .21291 L
.23443 .24038 L
.28938 .24038 L
.28938 .18544 L
.23443 .18544 L
.23443 .24038 L
.28938 .24038 L
.28938 .21291 L
.35348 .21291 L
s
.30311 .21749 m
.29396 .21291 L
.30311 .20833 L
s
p
/Times findfont 10 scalefont setfont
[( )] .2619 .17628 0 1 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .2619 .21291 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .2619 .21291 -1 -1 Mshowa
P
P
p
.004 w
.31685 .10913 m
.33516 .13355 L
.29853 .13355 L
.31685 .10913 L
.31685 .06639 L
s
.31685 .17628 m
.31685 .13355 L
s
p
/Times findfont 10 scalefont setfont
[(h[1] )] .32906 .12439 -1 3 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .32906 .12439 -1 1 Mshowa
P
P
p
.004 w
.5 .10913 m
.51832 .13355 L
.48168 .13355 L
.5 .10913 L
.5 .06639 L
s
.5 .17628 m
.5 .13355 L
s
p
/Times findfont 10 scalefont setfont
[(h[2] )] .51221 .12439 -1 3 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .51221 .12439 -1 1 Mshowa
P
P
p
.004 w
.1337 .10913 m
.15201 .13355 L
.11538 .13355 L
.1337 .10913 L
.1337 .06639 L
s
.1337 .17628 m
.1337 .13355 L
s
p
/Times findfont 10 scalefont setfont
[(h[0] )] .14591 .12439 -1 3 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .14591 .12439 -1 1 Mshowa
P
P
p
.004 w
.1337 .35943 m
.11538 .35943 L
s
newpath
.10623 .35943 .00916 0 365.73 arc
s
p
/Times findfont 10 scalefont setfont
[(x[n] )] .08333 .35943 1 0 Mshowa
P
P
.004 w
.17033 .35943 m
.17033 .3228 L
s
.35348 .35943 m
.35348 .3228 L
s
.53663 .35943 m
.53663 .3228 L
s
.35348 .21291 m
.35348 .24954 L
s
.53663 .21291 m
.53663 .24954 L
s
.17033 .21291 m
.17033 .24954 L
s
.1337 .28617 m
.1337 .17628 L
s
p
3 Mabswid
.17033 .35943 Mdot
p
/Times findfont 10 scalefont setfont
[(1 )] .17033 .36126 0 -1 Mshowa
P
P
p
3 Mabswid
.35348 .35943 Mdot
p
/Times findfont 10 scalefont setfont
[(2 )] .35348 .36126 0 -1 Mshowa
P
P
p
3 Mabswid
.53663 .35943 Mdot
p
/Times findfont 10 scalefont setfont
[(3 )] .53663 .36126 0 -1 Mshowa
P
P
p
3 Mabswid
.71978 .21291 Mdot
p
/Times findfont 10 scalefont setfont
[(14 )] .72161 .21474 -1 -1 Mshowa
P
P
p
3 Mabswid
.53663 .21291 Mdot
p
/Times findfont 10 scalefont setfont
[(5 )] .53846 .21474 -1 -1 Mshowa
P
P
p
3 Mabswid
.35348 .21291 Mdot
p
/Times findfont 10 scalefont setfont
[(6 )] .35531 .21474 -1 -1 Mshowa
P
P
p
3 Mabswid
.17033 .21291 Mdot
p
/Times findfont 10 scalefont setfont
[(7 )] .17216 .21474 -1 -1 Mshowa
P
P
p
3 Mabswid
.1337 .17628 Mdot
p
/Times findfont 10 scalefont setfont
[(8 )] .13095 .17628 1 0 Mshowa
P
P
p
3 Mabswid
.31685 .17628 Mdot
p
/Times findfont 10 scalefont setfont
[(9 )] .3196 .17628 -1 0 Mshowa
P
P
p
3 Mabswid
.5 .17628 Mdot
p
/Times findfont 10 scalefont setfont
[(10 )] .50275 .17628 -1 0 Mshowa
P
P
.31685 .28617 m
.31685 .17628 L
s
.5 .28617 m
.5 .17628 L
s
p
p
newpath
.31685 .02976 .01832 0 365.73 arc
s
.30769 .02976 m
.32601 .02976 L
.31685 .02976 L
.31685 .03892 L
.31685 .0206 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .32906 .04808 -1 -1 Mshowa
P
p
.34127 .03281 m
.34737 .02976 L
.34127 .02671 L
s
.33516 .02976 m
.35348 .02976 L
s
P
p
.3138 .06029 m
.31685 .05418 L
.3199 .06029 L
s
.31685 .06639 m
.31685 .04808 L
s
P
p
.28632 .03281 m
.29243 .02976 L
.28632 .02671 L
s
.28022 .02976 m
.29853 .02976 L
s
P
p
.5 Mabswid
.31685 .01145 Mdot
P
P
p
p
newpath
.5 .02976 .01832 0 365.73 arc
s
.49084 .02976 m
.50916 .02976 L
.5 .02976 L
.5 .03892 L
.5 .0206 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .51221 .04808 -1 -1 Mshowa
P
p
.52442 .03281 m
.53053 .02976 L
.52442 .02671 L
s
.51832 .02976 m
.53663 .02976 L
s
P
p
.49695 .06029 m
.5 .05418 L
.50305 .06029 L
s
.5 .06639 m
.5 .04808 L
s
P
p
.46947 .03281 m
.47558 .02976 L
.46947 .02671 L
s
.46337 .02976 m
.48168 .02976 L
s
P
p
.5 Mabswid
.5 .01145 Mdot
P
P
.35348 .02976 m
.46337 .02976 L
s
p
.75641 .02976 m
.77473 .02976 L
s
newpath
.78388 .02976 .00916 0 365.73 arc
s
p
/Times findfont 10 scalefont setfont
[(y[n] )] .80678 .02976 -1 0 Mshowa
P
P
.1337 .06639 m
.1337 .02976 L
.28022 .02976 L
s
p
3 Mabswid
.1337 .06639 Mdot
p
/Times findfont 10 scalefont setfont
[(11 )] .13095 .06639 1 0 Mshowa
P
P
p
3 Mabswid
.31685 .06639 Mdot
p
/Times findfont 10 scalefont setfont
[(12 )] .3141 .06639 1 0 Mshowa
P
P
p
3 Mabswid
.5 .06639 Mdot
p
/Times findfont 10 scalefont setfont
[(13 )] .49725 .06639 1 0 Mshowa
P
P
.1337 .35943 m
.17033 .35943 L
s
p
3 Mabswid
.35348 .02976 Mdot
p
/Times findfont 10 scalefont setfont
[(16 )] .35531 .03159 -1 -1 Mshowa
P
P
p
3 Mabswid
.53663 .02976 Mdot
p
/Times findfont 10 scalefont setfont
[(17 )] .53846 .03159 -1 -1 Mshowa
P
P
p
p
/Times-Bold findfont 12 scalefont setfont
[(Linear-phase )] .35348 .46932 0 0 Mshowa
P
P
p
p
/Times-Bold findfont 12 scalefont setfont
[(FIRrealizationtype2 )] .35348 .43269 0 0 Mshowa
P
P
p
p
/Times-Bold findfont 11 scalefont setfont
[( )] .97619 .35943 0 0 Mshowa
P
P
p
p
/Times-Bold findfont 11 scalefont setfont
[( )] .02381 .35943 0 0 Mshowa
P
P
p
p
newpath
.71978 .28617 .01832 0 365.73 arc
s
.71062 .28617 m
.72894 .28617 L
.71978 .28617 L
.71978 .29533 L
.71978 .27701 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .70757 .30449 1 -1 Mshowa
P
p
.5 Mabswid
.7381 .28617 Mdot
P
p
.71673 .3167 m
.71978 .31059 L
.72283 .3167 L
s
.71978 .3228 m
.71978 .30449 L
s
P
p
.69536 .28922 m
.68926 .28617 L
.69536 .28312 L
s
.68315 .28617 m
.70147 .28617 L
s
P
p
.71673 .25565 m
.71978 .26175 L
.72283 .25565 L
s
.71978 .24954 m
.71978 .26786 L
s
P
P
.71978 .21291 m
.71978 .24954 L
s
.71978 .3228 m
.71978 .35943 L
s
p
.68315 .10913 m
.70147 .13355 L
.66484 .13355 L
.68315 .10913 L
.68315 .06639 L
s
.68315 .17628 m
.68315 .13355 L
s
p
/Times findfont 10 scalefont setfont
[(h[3] )] .69536 .12439 -1 3 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[( )] .69536 .12439 -1 1 Mshowa
P
P
p
p
newpath
.68315 .02976 .01832 0 365.73 arc
s
.67399 .02976 m
.69231 .02976 L
.68315 .02976 L
.68315 .03892 L
.68315 .0206 L
s
P
p
/Times findfont 10 scalefont setfont
[( )] .69536 .04808 -1 -1 Mshowa
P
p
.70757 .03281 m
.71368 .02976 L
.70757 .02671 L
s
.70147 .02976 m
.71978 .02976 L
s
P
p
.6801 .06029 m
.68315 .05418 L
.6862 .06029 L
s
.68315 .06639 m
.68315 .04808 L
s
P
p
.65263 .03281 m
.65873 .02976 L
.65263 .02671 L
s
.64652 .02976 m
.66484 .02976 L
s
P
p
.5 Mabswid
.68315 .01145 Mdot
P
P
.53663 .02976 m
.64652 .02976 L
s
.71978 .02976 m
.75641 .02976 L
s
.68315 .28617 m
.68315 .17628 L
s
p
.82967 .21291 m
.82967 .2587 L
.85714 .2587 L
.85714 .31364 L
.8022 .31364 L
.8022 .2587 L
.85714 .2587 L
.85714 .31364 L
.82967 .31364 L
.82967 .35943 L
s
.83425 .32738 m
.82967 .31822 L
.82509 .32738 L
s
p
/Times findfont 10 scalefont setfont
[( )] .8663 .28617 -1 0 Mshowa
P
p
/Times-Italic findfont 10 scalefont setfont
[(z)] .82967 .28617 1 0 Mshowa
P
p
/Times findfont 9 scalefont setfont
[(-1 )] .82967 .28617 -1 -1 Mshowa
P
P
.71978 .35943 m
.82967 .35943 L
s
.71978 .21291 m
.82967 .21291 L
s
p
3 Mabswid
.71978 .35943 Mdot
p
/Times findfont 10 scalefont setfont
[(4 )] .71978 .36126 0 -1 Mshowa
P
P
p
3 Mabswid
.68315 .17628 Mdot
p
/Times findfont 10 scalefont setfont
[(15 )] .6859 .17628 -1 0 Mshowa
P
P
p
3 Mabswid
.68315 .06639 Mdot
p
/Times findfont 10 scalefont setfont
[(18 )] .6804 .06639 1 0 Mshowa
P
P
p
3 Mabswid
.75641 .02976 Mdot
p
/Times findfont 10 scalefont setfont
[(19 )] .75824 .03159 -1 -1 Mshowa
P
P
p
p
/Times-Bold findfont 11 scalefont setfont
[( )] .97619 .35943 0 0 Mshowa
P
P
p
p
/Times-Bold findfont 11 scalefont setfont
[( )] .02381 .35943 0 0 Mshowa
P
P
P
0 0 m
1 0 L
1 .48077 L
0 .48077 L
closepath
clip
newpath
% End of Graphics
MathPictureEnd
^*)