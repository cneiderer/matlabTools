function [new_slide,plot_area] = AddFigSlide(pres,slide_title,h_fig,fig_props)

%
% AddFigSlide.m creates a slide in a Powerpoint presentation and pastes in
%   one to four MATLAB figures, given the figure handles
%
% [new_slide,plot_area]=AddFigSlide(pres,slide_title,h_fig,fig_props)
%   pres is an open presentation
%   slide_title is a string
%   h_figs is a single handle or vector of handles to figures; should not
%       have more than 4 figure handles because all figures will go on one
%       slide
%   fig_props is an optional argument with fields 'border' and 'secret',
%       which can both hold values true or false
%

if nargin < 4
    fig_props=struct();
end

figs_per_slide=length(h_fig);
[new_slide,plot_area]=AddNormalSlide(pres,figs_per_slide,slide_title);

for ifig=1:length(h_fig)
    shape=AddFigure(new_slide,h_fig(ifig),plot_area(ifig,:));
    
    if isfield(fig_props,'secret') && fig_props.secret
        insert.Line.Visible='msoTrue';
    end
end

function insert_secret(slide,pic)

secret_text=slide.Shapes.AddLabel(1,...
    single(pic.Left+pic.Width)-7,...
    single(pic.Top+pic.Height)-16,...
    9,16);

secret_text.TextFrame.TextRange.Text='SECRET';
secret_text.TextFrame.TextRange.Font.Bold='msoTrue';
secret_text.TextFrame.TextRange.Font.Size=12;
secret_text.TextFrame.TextRange.Font.Color.RGB=ppt_RGB(255,0,0);
