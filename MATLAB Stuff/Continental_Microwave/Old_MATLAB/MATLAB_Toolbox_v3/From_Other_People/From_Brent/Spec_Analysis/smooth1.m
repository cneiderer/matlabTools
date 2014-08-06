function [newarray] = original(array, points)

% smooth.m performs smoothing of an array by adjacent poing averaging
% of tha array's data points and returns this new smoother array
% the purpose of this function is to give a clearer view of trends in
% noisy data
%                  Function call
% smoothed_array = smooth(array_to_be_fixed, adjacent_points_to_average)
% 
% 
% the arguments to the function call are the array to be modified
% and the number of points to use in averaging it
% the number of points must be an integer value greater than zero
xtest       = array;
den         = 0;
xtestnew    = 0;
newarray    = 0;
numpoints   = points;
denarray    = 0;
startarray  = 0;
stoparray   = 0;
xtestnewarray = 0;
if points <= 0
    'Error 1 - Number of points must be greater than zero'
    return 
elseif mod(points,1) ~= 0
    'Error 2 - Number of points must be a whole number'
    return
end
for x=1:length(xtest)
    if mod(numpoints,2) == 0
        start = x - numpoints/2;
        stop  = x + numpoints/2;
        skip  = 1;
    else
        start = x - (numpoints - 1)/2;
        stop  = x + (numpoints + 1)/2;
        skip  = 0;
    end
    if start < 1
        start = 1;
    end
    if stop > length(xtest)
        stop = length(xtest);
    end
    for y=start:stop
        if y == x
            if ~skip
                xtestnew = xtestnew + 2*xtest(y);
                den = den + 2; 
            end
        else
        xtestnew = xtestnew + xtest(y);    
        den = den + 1;
        end
    end
    denarray(x) = den;
    startarray(x) = start;
    stoparray(x) = stop;
    xtestnewarray(x) = xtestnew;
    xtestnew = xtestnew/den;
    newarray(x) = xtestnew;
    xtestnew = 0;
    den = 0;
end

return