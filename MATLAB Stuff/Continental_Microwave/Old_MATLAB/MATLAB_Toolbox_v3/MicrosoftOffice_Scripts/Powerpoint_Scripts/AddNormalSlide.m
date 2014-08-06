function [new_slide,plot_area] = AddNormalSlide(pres,objs_per_slide,slide_title)

plot_area=ones(0,4);
if ~exist('objs_per_slide','var') || isempty(objs_per_slide)
    objs_per_slide=1;
end

% Choose the layout based on objs_per_slide
switch objs_per_slide
    case 1
        layout=16; % 1 object
    case 2
        layout=29; % 2 objects
    case 3
        layout=30; % 1 object on the left, 2 on the right
    case -3
        layout=31; % 2 objects on the left, 1 on the right
    case 4
        layout=24; % 4 objects
    case 0
        layout=11; % title only
    otherwise
        error('Not a valid # of objects per slide,try 1-4')
end

% Make the new slide
new_slide=invoke(pres.Slides,'Add',pres.Slides.Count+1,layout);

% Add the title
if exist('slide_title','var') && ~isempty(slide_title)
    set(new_slide.Shapes.Title.TextFrame.TextRange,'Text',slide_title);
%     % Set the font size
%     new_slide.Shapes.Title.TextFrame.TextRange.Fong.Size=35;
end

% Find the bounds of all placeholder objects in body
if nargout > 1
    for i=2:new_slide.Shapes.Count % skip the title object
        plot_area(i-1,:)=[new_slide.Shapes.Item(2).Left,...
            new_slide.Shapes.Item(2).Top,...
            new_slide.Shapes.Item(2).Width,...
            new_slide.Shapes.Item(2).Height];
        new_slide.Shapes.Item(2).Delete;
    end
end

% IF no argument slide_title provided, delete the title placeholder
if ~exist('slide_title','var')
    new_slide.Shapes.Title.Delete;
end