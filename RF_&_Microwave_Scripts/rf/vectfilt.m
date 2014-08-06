% VECTFILT Filter a vector to have only specific type of elements.  Types are 'real',
%          'imaginary', 'complex', 'positive', 'negative', 'nonzero', 'nonpositive',
%          'nonnegative', 'even', 'odd', 'prime', and 'nonprime'.
% 
%    [Y] = VECTFILT (input, type) filters input using type

function [M] = vectfilt (vect, type)

switch lower(type)
	case 'real'
      M = mask(vect, not(imag(vect)));
   case 'imaginary'
	   M1 = mask(vect, imag(vect));
      M = mask(M1, not(real(M1)));
      M1 = [];   
   case 'complex'
   	M = mask(vect, imag(vect));   
   case 'positive'
      M = mask(vect, vect > 0);
   case 'negative'
      M = mask(vect, vect < 0);      
   case 'nonzero'
      M = mask(vect, vect);
	case 'nonpositive'
      M = mask(vect, vect <= 0);
   case 'nonnegative'
      M = mask(vect, vect >= 0);
   case 'even'
      M = mask(vect, iseven(vect));
   case 'odd'
      M = mask(vect, isodd(vect));
	case 'prime'
      M = mask(vect, isprime(vect));
	case 'nonprime'
      M = mask(vect, not(isprime(vect)));
   otherwise
      error('Unrecognized type');
      M = [];
end;
