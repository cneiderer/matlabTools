function [new_shape] = AddFigure(slide,h_fig,plot_area,send_to_back,bitmap)

for ifig=1:length(h_fig)
    
    % printing with the dmeta option (not the bitmap option) allows you to
    % have other windows overlapping the figure while it's being copied..
    
    if exist('bitmap','var') && ~isempty(bitmap) && ~isequal(bitmap,false)
        figure(h_fig(ifig));
        drawnow;
        print(h_fig(ifig),'-dbitmap');
    else
        print(h_fig(ifig),'-dmeta');
        new_shape=slide.Shapes.Paste;
    end
    
    if nargin < 3 || isempty(plot_area)
        return;
    end
    
    scalew=plot_area(ifig,3)/new_shape.Width;
    scaleh=plot_area(ifig,4)/new_shape.Height;
    scale=min(scalew,scaleh);
    
    cx=plot_area(ifig,1)+plot_area(ifig,3)/2.0;
    cy=plot_area(ifig,2)+plot_area(ifig,4)/2.0;
    
    new_shape.Left=fix(cx-new_shape.Width*scale/2.0);
    new_shape.Top=fix(cy-new_shape.Height*scale/2.0);
    new_shape.Height=fix(new_shape.Height*scale);
    
    if nargin < 4 || isempty(send_to_back) || ~send_to_back
        return;
    end
    
    new_shape.ZOrder('msoSendToBack')
end