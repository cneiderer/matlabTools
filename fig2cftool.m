function fig2cftool(varargin)

%By Nick Sinclair Jul 7, 2010. nws5@@@pitt...edu

%many thanks to PB: http://www.mathworks.com/matlabcentral/newsreader/author/46470
% for his post on the forum explaining how to get to the Cftool properties.

if ~isempty(varargin), 
    fighandle = varargin{1};
    set(0,'CurrentFigure',fighandle)
    axhandle = gca; 
else
    axhandle = gca; 
end

a=findobj(axhandle,'Type','line');
xx=get(a,'xdata');
yy=get(a,'ydata');

props ={'XLim','YLim','Xscale','Yscale', ... %The properties you want copied over to the cftool axis
    'YTickLabelMode','XTickLabelMode','YDir', ... %A lot of these are 
    'XDir','DataAspectRatio','DataAspectRatioMode'}; 

cftool
set(0,'ShowHiddenHandles','on'); %Show hidden handles
c = get(0,'Children'); % get all children of the root obj.
d = findobj(c,'flat','Type','figure','Tag','Curve Fitting Figure'); % Find cftool figure
cfax = findall(d,'Type','axes'); % Find axes'

for i = 1:length(xx), 
    name = get(a(i),'DisplayName');  
    logic = (name == '.') + (name == ' '); %toss spaces and bad chars from name
    name = name(~logic);                    %go ahead and add more. 
    clear xdata;
    
%     u = genvarname([name, 'xdata']);  %this is cut just to shorten the
%     evalc([u '= xx{i}']);             %labels, put it back if you want
    xdata = xx{i};                      % and cut this line
    v = genvarname([name, 'ydata']);    
    evalc([v '= yy{i}']); 
    
%     eval(['cftool(' u ',' v ')']); %and replace this line with the previous
    eval(['cftool(xdata,' v ')']); %and replace this line with the previous   
   %This is just a trick to name the data set
      
end
set(cfax,props,get(axhandle,props));
set(0,'ShowHiddenHandles','off'); %Show hidden handles
