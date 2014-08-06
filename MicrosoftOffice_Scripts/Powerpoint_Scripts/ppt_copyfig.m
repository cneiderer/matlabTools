function [slide_count] = ppt_copyfig(filename,ppt_title,fnumber,figs_per_slide,flabel,op,custom_layout)
% ppt_copyfig
%   Adds a plot (or group of plots) to the end of a ppt presentation
%
% Inputs:
%   filename        ->  path and name of the presentation
%   ppt_title       ->  title of the powerpoint slide (should be a cell of slide
%                       titles for more than one figure)
%   fnumber         ->  MATLAB figure number (or a vector of numbers)
%   figs_per_slide  ->  the number of figures to put on 1 slide (optional) 
%   flabel          ->  cell of labels corresponding to each fnumber
%   op              ->  an open presentation (optional)
%   custom_layout   ->  a special layout
%
% Outputs:
%   slide_count     -> 

% Since we are going to access this as a cell array later, if it's not one,
% convert it to a cell array
if ~iscell(ppt_title)
    ppt_title=cellstr(ppt_title);
end

% Set figs_per_slide to default value if not set
if ~exist('figs_per_slide','var')
    figs_per_slide=1;
end

% Convert figs_per_slide to pptLayout enumerated values
switch figs_per_slide
    case 1
        layout=16; % 1 object
    case 2
        layout=29; % 2 objects (obj1 left, obj2 right)
    case 3 
        layout=30; % 1 object on the left, 2 on the right 
                   % (obj1 left, obj2 top right, obj3 bottom right)
    case -3
        layout=31; % 2 objects on the left, 1 on the right
                   % (obj1 top left, obj2 bottom left, obj3 right)
        figs_per_slide=3;
    case 4
        layout=24; % 4 objects (obj1 top left, obj2 top right, 
                   % obj3 bottom left, obj4 bottom right)
    otherwise
        error('Not a valid # of figures per slide, try 1-4')
end

% If an open presentation was passed in, use it, otherwise open powerpoint
% and the presentation
if exist('op','var') && op~=0
    open_pres=true;
else
    open_pres=false;
end

ppt=actxserver('Powerpoint.Application');

% Activate Powerpoint and then minimize it
ppt.Activate;
ppt.WindowState=2;

if exist(filename,'file')
    op=ppt.Presentations.Open(filename,[],[],-1);
else
    op=ppt.Presentations.Add;
%     op.ApplyTemplate('S:\Curtis_Neiderer\MATLAB_Toolbox\Templates\spec_analysis_template.ppt')
end

% Set the ViewType to Slides to allow for pasting tricks
op.Windows.Item(1).ViewType=1;

title_ind=0;

if ~exist('custom_layout','var')
    custom_layout=0;
else
    layout=11; % Title only
end

for iFig=1:figs_per_slide:length(fnumber)
    slide_count=op.Slides.Count;
    slide_count=slide_count+1;
%     new_slide=op.Slides.Add(slide_count,layout); % Breaks for PPT 2007
    new_slide=invoke(op.Slides,'Add',slide_count,layout);
    title_ind=title_ind+1;
    
    try
        set(new_slide.Shapes.Title.TextFrame.TextRange,'Text',ppt_title{title_ind});
        % Set font size
        new_slide.Shapes.Title.TextFrame.TextRange.Font.Size=35;
    catch
        continue
    end
    
    try
        for ii=0:figs_per_slide-1
            figure(fnumber(iFig+ii));
            drawnow;
            print(fnumber(iFig+ii),'-dmeta');
            
            % Get the figure properties (in points since that's what ppt
            % uses)
            def_pos=get(fnumber(iFig+ii),'Position');
            def_units=get(fnumber(iFig+ii),'Units');
            set(fnumber(iFig+ii),'Units','points');
            fig_data=get(fnumber(iFig+ii));
            set(fnumber(iFig+ii),'Units',def_units);
            set(fnumber(iFig+ii),'Position',def_pos);
            
            % Select the new_slide so that View.Paste works correctly
            new_slide.Select
            
            % The placeholder numbers change when an object is inserted in
            % them so object 2 in the shapes collection will always be the
            % first object placeholder
            if ~custom_layout
                new_slide.Shapes.Item(2).Select;
            end
            
            % Paste into the current placeholder
            op.Application.Windows.Item(1).View.Paste; 
            
            % Get a reference to the figure that was just inserted
            pic(ii+1)=op.Application.Windows.Item(1).Selection.ShapeRange.Item(1);
            
            pic_h=get(pic(ii+1),'Height');
            pic_w=get(pic(ii+1),'Width');
            
            pic(ii+1).Line.Visible=-1; % -1=TRUE to MSOffice

            % If not a custom layout, figure is done moving, so add
            % classification and labels
            if ~custom_layout
%                 % insert secret classification label
%                 insert_classification(new_slide,pic(ii+1),'SECRET');

                % insert label above image
%                 if exist('flabel','var') && ~isempty(flabel)
%                     insert_label(new_slide,pic(ii+1),flabel{ii+1});
%                 end
            end
        end
        
    catch
        continue
    end
    
    if custom_layout
        
        % This is a custom layout so move the pic where it belongs 
        if figs_per_slide > 2
            error('This won''t work')
        end
        
        new_slide.Shapes.Title.TextFrame.TextRange.Font.Size=34;
        
        for ii=1:figs_per_slide
            title_pos.top=new_slide.Shapes.Title.Top;
            title_pos.left=new_slide.Shapes.Title.Left;
            title_pos.h=new_slide.Shapes.Title.Height;
            title_pos.w=new_slide.Shapes.Title.Width;
            h_buf=10;
            v_buf=5;
            h_shift=0;
            v_shift=0;
            
            if ii > 1
                h_shift=h_shift+pic(ii-1).Width;
            end
            
            pic(ii).Top=title_pos.top+title_pos.h+v_buf;
            
            if figs_per_slide == 2
                pic(ii).Left=title_pos.left+(ii-1)*(h_buf+h_shift);
                pic(ii).Width=310;
            end
            
            insert_classification(new_slide,pic(ii),'SECRET');
            
        end
    end
end

release(new_slide);
for ii=1:length(pic)
    release(pic(ii));
end

clear new_slide pic ii

try
    % Reset to Normal View
    op.Windows.Item(1).ViewType=9;
    if ~exist(filename,'file')
        invoke(op,'SaveAs',filename,1);
    else
        invoke(op,'Save');
    end

catch

    [msgstr,msgid]=lasterr;
    if strcmp(msgid,'MATLAB:COM:E2147500037')
        disp(['The file ',filename,' is currently read only (possibly open).'])
        [pathstr,name,ext]=fileparts(filename);
        filename=fullfile(pathstr,[name,'_2',ext]);
        
        try
            if ~exist(filename,'file')
                invoke(op,'SaveAs',filename,1);
            else
                error('Please clean up your directory and try again')
            end
        catch
            error('Please clean up you directory and try again')
        end
    end
end

% If the script opened the presentation, close it
if ~open_pres
    invoke(op,'Close');
    
    if ppt.Presentations.Count == 0 
        ppt.Quit;
    end
    
    release(op);
    release(ppt);
    
end

disp(['Completed adding slides to: ',filename]);

%% Display the SECRET text on the lower right of a picture
function [] = insert_classification(slide,pic,class)

% Top Left Classification
% Set TL position
secret_text_tl=slide.Shapes.AddLabel(1,...
    single(pic.Left),single(pic.Top),14.5,28);
% Add classification text and format
secret_text_tl.TextFrame.TextRange.Text=class;
secret_text_tl.TextFrame.TextRange.Font.Bold=-1; % -1=TRUE to MSOffice
secret_text_tl.TextFrame.TextRange.Font.Size=12;
secret_text_tl.TextFrame.TextRange.Font.Color.RGB=ppt_RGB(255,0,0);
secret_text_tl.TextFrame.WordWrap=0;

% Bottom Right Classification
secret_text_br=secret_text_tl.Duplicate;
% Grab the bounding width and height 
text_width=secret_text_tl.TextFrame.TextRange.BoundWidth;
text_height=secret_text_tl.TextFrame.TextRange.BoundHeight;
% Set BR position
secret_text_br.Left=single(pic.Left+pic.Width-text_width);
secret_text_br.Top=single(pic.Top+pic.Height-text_height);

% Release Label Objects
secret_text_tl.release;
secret_text_br.release;

%% Display a label on the lower right of a picture
function [] = insert_label(slide,pic,label)

test=1;
label_text=slide.Shapes.AddLabel(1,...
    single(pic.Left+(pic.Width/2)),single(pic.Top)-14.5,14.5,28);
label_text.TextFrame.TextRange.Text=label;
label_text.TextFrame.TextRange.Font.Bold=-1; % -1=TRUE to MSOffice
label_text.TextFrame.TextRange.Font.Size=12;
label_text.TextFrame.TextRange.Font.Color.RGB=ppt_RGB(255,0,0);
label_text.TextFrame.WordWrap=0;

% Grab the bounding width and height instead because they represent where
% the text is not the frame itself
text_width=label_text.TextFrame.TextRange.BoundWidth;
text_height=label_text.TextFrame.TextRange.BoundHeight;

% Reposition the text in the bottom right corner of the image
label_text.Left=single(pic.Left+(pic.Width/2)-(text_width/2));
label_text.Top=single(pic.Top-(text_height+7));
label_text.release;

%% 
function [rgb] = ppt_RGB(r,g,b)
% ppt_RGB.m converts r,g,b values in teh 0-255 range to the rgb value
%   required by powerpoint objects
%
% rgb=ppt_RGB(r,g,b) where 0<= r,g & b <256
%

rgb=r+256*g+256*256*b;