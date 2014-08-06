% PULSESOURCE  Generates output of pulsed source
% 
%    [Y] = PULSESOURCE (Time, RiseTime, FallTime, Width,
%                 Period, Delay, High, Low) 
%        Generates the output of the corresponding
%        pulsed source.
% 

function [Y] = PulseSource (X, RT, FT, W, T, D, H, L)

% Check for negative values
if ((RT < 0) | (FT < 0) | (W < 0))
   error ('The rise time, fall time, or width is negative');
end;

% Check for values that add to more than period
if (RT + FT + W > T)
   error ('Pulse is unrealizable (Period is less than components)');
end;

% Check that X is single dimensional
if ((ndims(X) ~= 2) | (min(size(X)) > 1))
   error ('The time must be one-dimensional (This isn''t science fiction.)')
end;   

for num = 1:length(X),
	ThisX = mod(X(num) - D, T);

	if (X(num) - D < 0)
   	Y(num) = L;
	elseif (ThisX < RT),
   	RiseX = ThisX;
	   Y(num) = L + (H - L)*RiseX/RT;
	elseif (ThisX < RT + W),
   	Y(num) = H;
	elseif (ThisX < RT + W + FT),
   	FallX = ThisX - RT - W;
	   Y(num) = H - (H - L)*FallX/RT;
	else
	   Y(num) = L;
   end;
end;   
