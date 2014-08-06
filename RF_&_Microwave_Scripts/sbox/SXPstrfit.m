function word = SXPstrfit(candidate, nr_of_chars)

% fits a string to a set length
% (useful for writing matrices in ascii)
%
% 11 may 1999

if size(candidate,2) >= nr_of_chars
   word = [candidate(1:nr_of_chars-1) ' '];
else
   for i=1:nr_of_chars-size(candidate,2)
      candidate = [candidate ' '];
   end;
   word = candidate;
end;
