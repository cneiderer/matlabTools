% SQRCFILTER	This function generates the filter coefficients for a SQuare
%		root Raised Cosine (SQRC) filter.  The coefficients of the 
%		filter are samples of a continuous SQRC filter, where the
%		sample Times are based upon taps, TimeDelay, and
%		Sps.  Once the coefficients are computed,
%		they are multiplied by a Hamming window and scaled so the
%		filter has unity gain. 
%
% 		This function implements the following function, b(n):
%
%			b(n) = (cos[(1+Alpha)*n]/(4*Alpha))/((pi/4*Alpha)^2-n^2) +
%	        pi*(sin[(1-Alpha)*n]/(((4*Alpha)^2)*n))/((pi/4*Alpha)^2-n^2)
%
% 		where n is based upon number of taps, Time delay, and samples per symbol.
% 		The computation for n is
%
%		n = (Time-(taps-1)/2-TimeDelay)*pi/Sps, where 0 <= Time < taps
%
% USAGE:	
%		Taps = SqrcFilter(Alpha,NumTaps,Sps,TimeDelay)
%
% INPUTS:
%		Alpha = rolloff
%		NumTaps = filter length
%		Sps = samples per symbol
%		TimeDelay = Time delay in samples
%
% OUTPUTS:
%		Taps = SQRC filter taps
%

function Taps = SqrcFilter(Alpha,NumTaps,Sps,TimeDelay)

% Compute filter delay
Delay = (NumTaps - 1)/2;

for TapIndex = 0:NumTaps-1
   
	% Compute time value
	Time = (TapIndex - Delay - TimeDelay)*pi/Sps;

    % Compute taps
	if (Time == 0)
		Num = 1/(4*Alpha) + pi*(1-Alpha)/(16*Alpha^2);
		Den = (pi/(4*Alpha))*(pi/(4*Alpha));
		Taps(TapIndex+1)= Num/Den;

	elseif (abs(Time) == pi/(4*Alpha))
		Num = -((1+Alpha)/(4*Alpha))*sin((pi/4)*(1/Alpha+1)) - ...
		 (1/pi)*sin((pi/4)*(1/Alpha-1))+ ((1-Alpha)/(4*Alpha))*cos((pi/4)*(1/Alpha-1));
		Den = -pi/(2*Alpha);
		Taps(TapIndex+1)= Num/Den;

	else
		Num = (1/(4*Alpha))*cos(Time*(1+Alpha)) + (pi/(16*(Alpha^2)*Time))*sin(Time*(1-Alpha));
		Den = (pi/(4*Alpha))*(pi/(4*Alpha)) - Time^2;
		Taps(TapIndex+1)= Num/Den;

	end

end

% Window taps and normalize
%Taps = Taps.*hamming(NumTaps).';
%Taps = Taps/sum(Taps);
