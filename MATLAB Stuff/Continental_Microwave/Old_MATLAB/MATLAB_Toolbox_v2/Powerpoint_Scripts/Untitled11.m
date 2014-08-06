ppttemplate('d:mfiles\pptreport\firsttemplate.ppt')

%
% ppttemplate.m
%

plot(rand(1,20))

pptpaste(1,'Rectangle 5');
pptpaste(1,'Rectangel 6'):

plot(rand(1,40))

ppttext(2,'Rectangle 4','This really is only a test');
pptpaste(2,'Rectangle 5');

plot(rand(1,60))

pptpaste(3,'Rectangle 5');
pptpaste(3,'Rectangle 6');

pptsave('d:\mfiles\pptreport\myfirst.ppt');