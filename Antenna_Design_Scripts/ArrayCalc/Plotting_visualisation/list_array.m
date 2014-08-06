function list_array(optionflag)
% Lists array element details as stored in array_config.
% 
%
% Usage: list_array(optionflag)
%
% optionflag...Flag=1 lists all element data including rotation matricies
%              Flag=0 lists element locations and excitations only  
%
% e.g. list_array(0) % List element excitations only

global array_config;

[Trow,Tcol,N]=size(array_config); % Number of elements in array N

if optionflag==0
 fprintf('\n\nElement   X(m)      Y(m)      Z(m)     Amp(dB) Phase(Deg)   Type\n');
  for n=1:N
  Trot=array_config(1:3,1:3,n);
  Toff=array_config(1:3,4,n);
  x=Toff(1,1);
  y=Toff(2,1);
  z=Toff(3,1);
  Exc=array_config(1:3,5,n);
  Amp=20*log10(Exc(1,1));
  Pha=Exc(2,1)*180/pi;

  eltype=array_config(3,5,n);                     % Select appropriate element model
  switch eltype
   case 0,name='iso';
   case 1,name='patchr';
   case 2,name='patchc';
   case 3,name='dipole';
   case 4,name='dipoleg';
   case 5,name='helix';
   case 6,name='interp';
   case 7,name='user1';
   otherwise,disp('Invalid element type detected');name='invalid';
  end;

  fprintf('%5i%10.4f%10.4f%10.4f%10.2f%10.2f%10s%',n,x,y,z,Amp,Pha,name);      
  fprintf('\n'); 
 end
end

if optionflag==1
Element=array_config;
 fprintf('\n\n      Rotation  Matrix            X/Y/Z     Amp/Pha/Type \n');
 fprintf(    '|=============================|===========|=============|\n');
 for n=1:N
  Element(1,5,n)=20*log10(Element(1,5,n));
  Element(2,5,n)=(Element(2,5,n)*180/pi);
 end
Element
end
