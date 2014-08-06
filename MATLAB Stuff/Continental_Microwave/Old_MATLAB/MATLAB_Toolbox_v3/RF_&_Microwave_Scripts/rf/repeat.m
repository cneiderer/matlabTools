% REPEAT  Upsample a vector by inserting repeated samples
% 
%    [y] = REPEAT (x,N) upsamples x by a factor N using repetition
% 

function [Y] = repeat(x, N);
Y = [];
for i = 1:length(x)
  Y = [Y x(i).*ones(1,N)];
end;
