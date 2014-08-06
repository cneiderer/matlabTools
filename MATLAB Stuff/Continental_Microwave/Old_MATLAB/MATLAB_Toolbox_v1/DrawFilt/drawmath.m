 
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
         http://www.prenhall.com/lutovac                          
                                                                  
   call:                                                          
   SetDirectory["C:\\AFD\\DRAWFILT"];                             
   SetDirectory[HomeDirectory[]];                                 
   <<AFD\DrawFilt\drawflib.m                                      
   <<AFD\DrawFilt\drawmath.m                                      
   DrawMath[0,0,1,5,10];                                       *) 
(* creation date: 1-Oct-0  time: 23:45*)
Nx = 7;
Ny = 5;
x0 = 0;
y0 = 0;
dx = 4;
x = x0+Table[i*dx/4,{i,4*Nx}];
y = y0+Table[i*dx/4,{i,4*Ny}];
DrawMath[x0_,y0_,dx_,ds_,F_:8] := Module[{
x = x0+Table[i*dx,{i,50}],  y = y0+Table[i*dx,{i,50}]},
Show[{
                                                             
DrawDel[x[[5]],y[[15]],x[[10]]," ","-1 ",0,ds/2,F],          
DrawDel[x[[10]],y[[15]],x[[15]]," ","-1 ",0,ds/2,F],         
DrawDel[x[[15]],y[[15]],x[[20]]," ","-1 ",0,ds/2,F],         
DrawAdd[x[[9]],y[[13]],0,1,2,1," ",3,ds/3,F],                
DrawAdd[x[[14]],y[[13]],0,1,2,1," ",3,ds/3,F],               
DrawAdd[x[[4]],y[[13]],0,1,2,1," ",3,ds/3,F],                
DrawDel[x[[15]],y[[11]],x[[20]]," ","-1 ",2,ds/2,F],         
DrawDel[x[[10]],y[[11]],x[[15]]," ","-1 ",2,ds/2,F],         
DrawDel[x[[5]],y[[11]],x[[10]]," ","-1 ",2,ds/2,F],          
DrawMult[x[[9]],y[[7]],y[[10]]," ","h[1] ",3,ds/3,F],        
DrawMult[x[[14]],y[[7]],y[[10]]," ","h[2] ",3,ds/3,F],       
DrawMult[x[[4]],y[[7]],y[[10]]," ","h[0] ",3,ds/3,F],        
DrawIn[x[[4]],y[[15]],"x[n] ",2,ds,F],                       
DrawLine[x[[5]],y[[15]],x[[5]],y[[14]]],                     
DrawLine[x[[10]],y[[15]],x[[10]],y[[14]]],                   
DrawLine[x[[15]],y[[15]],x[[15]],y[[14]]],                   
DrawLine[x[[10]],y[[11]],x[[10]],y[[12]]],                   
DrawLine[x[[15]],y[[11]],x[[15]],y[[12]]],                   
DrawLine[x[[5]],y[[11]],x[[5]],y[[12]]],                     
DrawLine[x[[4]],y[[13]],x[[4]],y[[10]]],                     
DrawNode[x[[5]],y[[15]],"1 ",2,1,F],                         
DrawNode[x[[10]],y[[15]],"2 ",2,1,F],                        
DrawNode[x[[15]],y[[15]],"3 ",2,1,F],                        
DrawNode[x[[20]],y[[11]],"14 ",1,1,F],                       
DrawNode[x[[15]],y[[11]],"5 ",1,1,F],                        
DrawNode[x[[10]],y[[11]],"6 ",1,1,F],                        
DrawNode[x[[5]],y[[11]],"7 ",1,1,F],                         
DrawNode[x[[4]],y[[10]],"8 ",4,1,F],                         
DrawNode[x[[9]],y[[10]],"9 ",0,1,F],                         
DrawNode[x[[14]],y[[10]],"10 ",0,1,F],                       
DrawLine[x[[9]],y[[13]],x[[9]],y[[10]]],                     
DrawLine[x[[14]],y[[13]],x[[14]],y[[10]]],                   
DrawAdd[x[[8]],y[[6]],2,1,1,0," ",1,ds/3,F],                 
DrawAdd[x[[13]],y[[6]],2,1,1,0," ",1,ds/3,F],                
DrawLine[x[[10]],y[[6]],x[[13]],y[[6]]],                     
DrawOut[x[[21]],y[[6]],"y[n] ",0,ds,F],                      
DrawLVH[x[[4]],y[[7]],x[[8]],y[[6]],0],                      
DrawNode[x[[4]],y[[7]],"11 ",4,1,F],                         
DrawNode[x[[9]],y[[7]],"12 ",4,1,F],                         
DrawNode[x[[14]],y[[7]],"13 ",4,1,F],                        
DrawLine[x[[4]],y[[15]],x[[5]],y[[15]]],                     
DrawNode[x[[10]],y[[6]],"16 ",1,1,F],                        
DrawNode[x[[15]],y[[6]],"17 ",1,1,F],                        
DrawText[x[[10]],y[[18]],"Linear-phase ",F+1],               
DrawText[x[[10]],y[[17]],"FIRrealizationtype2 ",F+1],        
DrawText[x[[27]],y[[15]]," ",F],                             
DrawText[x[[1]],y[[15]]," ",F],                              
DrawAdd[x[[19]],y[[13]],0,1,2,1," ",3,ds/3,F],               
DrawLine[x[[20]],y[[11]],x[[20]],y[[12]]],                   
DrawLine[x[[20]],y[[14]],x[[20]],y[[15]]],                   
DrawMult[x[[19]],y[[7]],y[[10]]," ","h[3] ",3,ds/3,F],       
DrawAdd[x[[18]],y[[6]],2,1,1,0," ",1,ds/3,F],                
DrawLine[x[[15]],y[[6]],x[[18]],y[[6]]],                     
DrawLine[x[[20]],y[[6]],x[[21]],y[[6]]],                     
DrawLine[x[[19]],y[[13]],x[[19]],y[[10]]],                   
DrawDel[x[[23]],y[[11]],y[[15]]," ","-1 ",3,ds/2,F],         
DrawLine[x[[20]],y[[15]],x[[23]],y[[15]]],                   
DrawLine[x[[20]],y[[11]],x[[23]],y[[11]]],                   
DrawNode[x[[20]],y[[15]],"4 ",2,1,F],                        
DrawNode[x[[19]],y[[10]],"15 ",0,1,F],                       
DrawNode[x[[19]],y[[7]],"18 ",4,1,F],                        
DrawNode[x[[21]],y[[6]],"19 ",1,1,F],                        
DrawText[x[[27]],y[[15]]," ",F],                             
DrawText[x[[1]],y[[15]]," ",F],                              
{}
}
,AspectRatio -> Automatic,Axes -> False, PlotRange -> All]];
 (* DrawMath[0,0,1,4*1/0.8,10]; *) 
