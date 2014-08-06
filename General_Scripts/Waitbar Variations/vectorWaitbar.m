function status = vectorWaitbar(varargin)

% Except for those parts marked as originally written by mathworks,
% the remainder of this m-file is subject to the following
% ---------------------------------------------------------------------
% |You may use this code for anything. However, if you do use it or   |
% |modify it or incorporate it into any project or product or service |
% |the result shall be subject to GPLv3 and you must include this     |
% |header and footer notice.                                          |
% |                                                                   |
% |GNU GENERAL PUBLIC LICENSE -- Version 3, 29 June 2007              |
% |see http://www.gnu.org/licenses/gpl.html                           |
% |                                                                   |
% | (C) michaelB brost -- December 23, 2008                           |
% ---------------------------------------------------------------------
% unless the original mathworks waitbar.m code's license supercedes GPLv3.
%
% vectorized version of matlab's standard waitbar function "waitbar.m"
%
% status = vectorWaitbar(xVec) will create an initialized waitbar array
%          with length(xVec) horizontal status bars of lengths
%          xVec(1), xVec(2), ...
%
% status = vectorWaitbar(xVec, messageCell) as above but with an initialized
%          message string where xVec is a valid entry and the corresponding
%          messageCell member is valid
%
% status = vectorWaitbar(xVec, handleVec) will update the status bar
%          for each valid xVec component. It will skip all nans and
%          invalid handles in handleVec. handleVec can be either a vector
%          of individual handles to the status bars or the parent handle.
%
% status = vectorWaitbar(xVec, handleVec, messageCell) will update
%          the status bar for each valid xVec component. It will skip
%          all nans and invalid handles in handleVec and empty or invalid
%          cell entries in messageCell
%
% examples:
% x = [0 0 0.2 0];
% hndVec = vectorWaitbar(x);  % create 4 element vectorWaitbar
%          initialized to lengths [0, 0, 20 percent, 0]
%
%
% x1 = [0   0   0.2 0];
% x2 = [0.2 0.3 0.4 0.5];
% hndVec = vectorWaitbar(x1);          % as above
%          vectorWaitBar(x2, handVec); %update status bars
%
% x1 = [0   0   0.2 0];
% x2 = [0.2 0.3 0.4 0.5];
% msg1 = {'item 1', 'item 2', 'item 3', 'item 4'};
% msg2 = {'item 1 updated', 'item 2 updated', 'item 3 updated', 'item 4 updated'};
% hndVec = vectorWaitbar(x1, msg1); % as above
%          vectorWaitBar(x2, handVec, msg2); %update status bars

% ---------------------- algorithm ---------------------
xVec = [];
hVec = [];
mVec = [];

initialize = true;

switch(nargin)
    case 0,
        xVec = 0;

    case 1,
        if(ischar(varargin{1})),
            if(strcmp(lower(varargin{1}), 'demo')==true),
                doDemo;
                status = [];
                return;
            end
        end

        if(isnumeric(varargin{1})),
            xVec = varargin{1}(:);
        else,
            doError('single input must be a numeric vector ');
            status = [];
            return;
        end

    case 2,
        if(isnumeric(varargin{1}) && isnumeric(varargin{2})),
            xVec = varargin{1}(:);
            hVec = varargin{2}(:);
            if(length(xVec) ~= length(hVec)),
                doError('first and second inputs unequal lengths ');
                status = [];
                return;
            end

            initialize = false;

        elseif(isnumeric(varargin{1}) && iscell(varargin{2})),
            xVec = varargin{1}(:);
            mVec = varargin{2}(:);
            if(length(xVec) ~= length(mVec)),
                doError('first and second inputs unequal lengths ');
                status = [];
                return;
            end

        else,
            doError('invalid combined first and second input arguments ');
            status = [];
            return;
        end
    case 3
        if(isnumeric(varargin{1}) && isnumeric(varargin{2}) && iscell(varargin{3})),
            xVec = varargin{1}(:);
            hVec = varargin{2}(:);
            mVec = varargin{3}(:);
        else
            doError(varargin);
            status = [];
            return;
        end

        if(length(xVec) ~= length(hVec)),
            doError('input 1 and 2 length mismatch ');
            status = [];
            return;
        end

        if(length(xVec) ~= length(mVec)),
            doError('input 1 and 3 length mismatch ');
            status = [];
            return;
        end

        initialize = false;


    otherwise,
        doError('bad inputs ');
        status = [];
        return;
end

nStatus = length(xVec);

% ----------------  initialization == true  -------------
if(initialize == true),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % begin code from original mathworks waitbar.m %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    oldRootUnits = get(0,'Units');

    set(0, 'Units', 'points');
    screenSize = get(0,'ScreenSize');

    axFontSize=get(0,'FactoryAxesFontSize');

    pointsPerPixel = 72/get(0,'ScreenPixelsPerInch');

    width = 360 * pointsPerPixel;  % per mathworks
    height = 75 * pointsPerPixel;  % per mathworks

    pos = [...
        screenSize(3)/2-width/2,  ...
        screenSize(4) * 0.1, ...
        width,                    ...
        min(height * nStatus, screenSize(4) * 0.7)];    % modified this to account for multiple bars

    fHnd = figure(...
        'Units',          'points', ...
        'BusyAction',     'queue', ...
        'Position',       pos, ...
        'Resize',         'off', ...
        'CreateFcn',      '', ...
        'NumberTitle',    'off', ...
        'IntegerHandle',  'off', ...
        'MenuBar',        'none', ...
        'Tag',            'vectorWaitbar',...
        'Interruptible',  'off', ...
        'WindowStyle',    'normal', ...
        'DockControls',   'off', ...
        'Visible',        'on');  % changed last entry to on

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % end code from original mathworks waitbar.m %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % now walk through the number of status bars to generate...
    clear('status');

    for statusBar = 1:nStatus
        dx = 0.1;
        dH = 1/nStatus;

        % somewhat pleasing location of axes within figure...
        dy = dH * 0.33;

        if(nStatus >= 10), dy = dH * 0.25; end
        if(nStatus >= 20), dy = dH * 0.20; end
        if(nStatus >= 30), dy = dH * 0.15; end

        axPosition = [...
            dx, ...
            dy + (nStatus - statusBar)*dH, ...
            1-2*dx, ...
            0.2/nStatus];

        axHnd = clearAxes(axFontSize, axPosition);

        x = xVec(statusBar) * 100;

        % safe constraints
        x = max(0, min(x, 100));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % begin code from original mathworks waitbar.m %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        xpatch = [0 x x 0];
        ypatch = [0 0 1 1];
        xline  = [100 0 0 100 100];
        yline  = [0 0 1 1 0];

        pHnd = patch(xpatch, ypatch, 'r', ...
            'EdgeColor', 'b', 'EraseMode', 'none');

        lHnd = line(xline,yline,'EraseMode','none');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % end code from original mathworks waitbar.m %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % somewhat pleasing relocation of title text
        if(isempty(mVec)),
            tHnd = title(sprintf('item %d of %d', statusBar, nStatus));
        else,
            tHnd = title(sprintf('%s', mVec{statusBar}));
        end

        tPos = get(tHnd, 'position');
        tPos(2) = tPos(2) / (1.5^(nStatus/10));
        set(tHnd, 'position', tPos);

        % fontsize reduction
        fontSize = get(tHnd, 'fontsize');
        if(nStatus >= 10),
            fontSize = fontSize * 0.9^(nStatus/10);
        end
        set(tHnd, 'fontsize', fontSize);

        status(statusBar) = axHnd;
    end

    return;

end

% ----------------  initialization == false  -------------

for statusBar = 1:nStatus

    try,
        if(isempty(hVec(statusBar))), continue; end

        x = xVec(statusBar) * 100;
        if(isempty(x)), continue; end

        % force clean update every time...
        axes(hVec(statusBar));

        ch = get(hVec(statusBar), 'children');

        % force reset
        xd = [0 100 100 0]';
        vd = [xd, [0 0 1 1]'];
        set(ch(2), 'vertices',  vd);
        oldFc = get(ch(2), 'facecolor');
        set(ch(2), 'facecolor', [1 1 1]);

        % set new length
        xd = [0 x x 0]';
        set(ch(2), 'xdata', xd);
        set(ch(2), 'facecolor', oldFc);
        vd(:, 1) = xd;
        set(ch(2), 'vertices', vd);

        if(isempty(mVec)),            continue; end
        if(isempty(mVec{statusBar})), continue; end

        tHnd = get(hVec(statusBar), 'title');
        set(tHnd, 'string', mVec{statusBar});

    catch,
        continue;

    end
end

status = hVec(:);

return;

function doError(s)
fprintf('%s: %s \n', mfilename, s);
return;

function hnd = clearAxes(axFontSize, axPosition)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin code from original mathworks waitbar.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hnd = axes(...
    'XLim',              [0 100],...
    'YLim',              [0 1],...
    'FontSize',          axFontSize,...
    'Position',          axPosition, ...
    'XTickMode',         'manual',...
    'YTickMode',         'manual',...
    'XTick',             [], ...
    'YTick',             [],...
    'XTickLabelMode',    'manual',...
    'XTickLabel',        [],...
    'YTickLabelMode',    'manual',...
    'YTickLabel',        []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end code from original mathworks waitbar.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function doDemo
m = 5;
x = repmat(0.5, [1, m]);

h = vectorWaitbar(x);
pause(1.5);
n = 30;

for iter=1:n,

    for c=1:m
        msg{c} = sprintf(...
            'random item %d of %d --> iteration %d of %d', ...
            c, m, iter, n);
    end

    vectorWaitbar(rand(1, m), h, msg);
    pause(0.2);
end

pause(2);
close(gcf);

% ---------------------------------------------------------------------
% |You may use this code for anything. However, if you do use it or   |
% |modify it or incorporate it into any project or product or service |
% |the result shall be subject to GPLv3 and you must include this     |
% |header and footer notice.                                          |
% |                                                                   |
% |GNU GENERAL PUBLIC LICENSE -- Version 3, 29 June 2007              |
% |see http://www.gnu.org/licenses/gpl.html                           |
% |                                                                   |
% |michaelB brost -- December 23, 2008                                |
% ---------------------------------------------------------------------

