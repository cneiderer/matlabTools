function addpath_recurse(directory,ignore,flag,remove)
%ADDPATH_RECURSE  Adds the specified directory and its subfolders
%   addpath_recurse(directory,ignore,flag)
%
%   By default, all hidden directories, overloaded method directories
%   (preceded by '@'), and directories marked 'private' are ignored.
%
%   Descriptions of Input Variables:
%   directory: full path to the starting directory.  All subdirectories
%       will be added to the path as well.  If this is not specified, then
%       the current directory will be used.
%   ignore: a cell array of strings specifying directory names to ignore.
%       This will cause all subdirectories beneath this directory to be
%       ignored as well.
%   flag:   as in addpath, this may be either 0/1, or 'begin','end', by
%       default the value is 'begin'
%   remove: this is a true/false flag that if set to true will run this
%       function "in reverse" and recursively remove directories from the
%       path
%
%   Descriptions of Output Variables:
%   none
%
%   Example(s):
%   >> addpath_recurse(pwd,{'.svn'}); %adds the current directory and all
%   subdirectories, ignoring the SVN-generated .svn directories
%   >> addpath_recurse(pwd,{'ignoreDir'},'',true); %removes all
%   directories beneath the current directory, except those including and
%   beneath 'ignoreDir' from the search path
%
%   See also: addpath

% Author: Anthony Kendall
% Contact: anthony [dot] kendall [at] gmail [dot] com
% Created: 2008-08-08

%Parse the inputs
if nargin<2
    if nargin==0
        directory = pwd;
    end
    ignore={''};
    flag = 0;
    remove = false;
elseif nargin==2
    if ischar(ignore)
        ignore = cell(char);
    end
    flag = 0;
    remove = false;
elseif nargin>=3
    if isempty(flag)
        flag = 0;
    end
    if ischar(flag)
        assert(any(strcmpi(flag,{'begin','end'})),'Illegal value of "flag", see HELP');
    else
        assert(isscalar(flag) && (flag==0 || flag==1),'Illegal value of "flag", see HELP');
    end
    if nargin==4
        assert(islogical(remove),'The "remove" flag must be a logical value, see HELP');
    else
        remove = false;
    end
end

%Add the current directory to the path or remove it according to 'remove'
assert(exist(directory,'dir')>0,'The input directory does not exist');
if remove
    warning off MATLAB:rmpath:DirNotFound
    rmpath(directory)
    warning on MATLAB:rmpath:DirNotFound
else
    addpath(directory,flag);
end

%Get list of directories beneath the specified directory, this two-step
%process is faster
currDir = dir([directory,filesep,'*.']);
currDir = currDir([currDir.isdir]); %This handles files without an extension

%Loop through the directory list and recursively call this function
for m = 1:length(currDir)
    if ~any(strcmpi(currDir(m).name,{'private','.','..',ignore{:}})) && ...
            ~any(strncmp(currDir(m).name,{'@','.'},1))
        addpath_recurse([directory,filesep,currDir(m).name],ignore,flag,remove);
    end
end


%% ---------- %% Sub-Functions %% ---------- %%

function assert(expr, msg, internal_call)
%assert checks whether the expr is true or not and raises an error if not.
%
%  Info / Example
%  ==============
%  A common call to assert looks like this:
%         Example: assert(a == b);
%  The assertion will fail, if a is not equal to b.
%
%  In addition, a message can be specified:
%         Example: assert(a == b, 'a is not equal to b.');
%  The message is only used, if the assertion fails.
%
%  Some xUnit frameworks provide a fail() method. This method can be
%  "simulated" through setting expr to false or 0:
%         Example: assert(false);
%         Example: assert(0);
%
%  The parameter internal_call is used to trim the top entries of the stack
%  trace, e.g. for user-defined assert methods (see the code of
%  assert_equals for an example).

%  This Software and all associated files are released unter the
%  GNU General Public License (GPL), see LICENSE for details.
%
%  §Author: Thomas Dohmke <thomas@dohmke.de> §
%  $Id: assert.m 18 2006-05-26 16:41:44Z thomi $
 
if (nargin == 1)
    msg = 'no message.';
    internal_call = 0;
end;
if (nargin == 2)
    internal_call = 0;
end;
if (internal_call > 1)
    internal_call = 1;
end;
if ((isempty(expr)) || (~expr))
    stack = dbstack('-completenames');
    stacktrace = '';
    for i = 2 + internal_call:size(stack, 1)
        stacktrace = sprintf('%s\n  In %s at line %d', ...
            stacktrace, ...
            stack(i).file, stack(i).line);
    end;
    stacktrace = sprintf('%s\n', stacktrace);
    error(['MLUNIT FAILURE:Traceback (most recent call first): ', ...
        stacktrace, ...
        'AssertionError: ', ...
        msg]);
end;