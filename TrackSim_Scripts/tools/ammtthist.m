figure; hold on;
hist(b2e(b2e<282),10)

hist(b2e(b2e>282 & b2e<290),10)

hist(b2e(b2e>478),10)


hist(e2b(e2b<284),10)

hist(e2b(e2b>400),10)
% hold on
% hist(e2b(e2b>340 & e2b<360),10)
% 
% hist(b2e(b2e>340 & b2e<360),10)

hist(e2m(e2m<568),10)

hist(m2e,10)








numel(b2e(b2e<282))

numel(b2e(b2e>282 & b2e<300))

numel(b2e(b2e>478))


numel(e2b(e2b<300))

numel(e2b(e2b>380))
% hold on
% numel(e2b(e2b>340 & e2b<360),10)
% 
% numel(b2e(b2e>340 & b2e<360),10)

numel(e2m)

numel(m2e)