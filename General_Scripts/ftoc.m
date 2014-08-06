function tocString = ftoc(fileName,insertFlag)
%FTOC   Creates a table of contents of functions contained in an m-file.
%   STR = FTOC(FILE) returns a character array table of contents STR for
%   all nested functions and subfunctions within the m-file FILE (built-in
%   functions are not displayed). The line numbers of each function are
%   included, and the indentation of the function names indicates the
%   nesting order. FILE should be an m-file name. If FILE is not found, or
%   there are no subfunctions or nested functions, STR will be an empty
%   string.
%
%   STR = FTOC(FILE,'insert') will return a character array table of
%   contents STR formatted for the purpose of inserting it into the header
%   comment block of the m-file FILE. Each line begins with the character
%   '%' and the line numbers are adjusted to account for the fact that STR
%   will be inserted somewhere within the top comment block of FILE. (NOTE:
%   you will want to first remove any old table of contents from the
%   comment block before pasting the new one in, to make sure the line
%   numbers are adjusted correctly.)
%
%   NOTE: This function was inspired by a posting by Yair Altman on the
%         mathworks newsgroup. It uses MLINTMEX, an undocumented function.
%
%   Examples:
%
%      >> ftoc('ftoc')        % No nested functions or subfunctions
%
%      ans =
%
%           ''
%
%      >> ftoc('staker.m')    % One of my (large) FEX posts
%
%      ans =
%
%          1  staker                      
%        214     initialize_intro         
%        266        callback_intro        
%        296     initialize_main          
%        349        update_main           
%        376        callback_main         
%        481        initialize_profile    
%        552           update_profile     
%        621           callback_profile   
%        708           create_profile     
%        745              callback_create 
%        791           shop_armory        
%        914              callback_shop   
%       1103        edit_preferences      
%       1254           callback_edit      
%       1416     generate_terrain         
%       1588        add_terrain           
%       1608     initialize_game          
%       1918        update_game           
%       2012        callback_game         
%       2140           update_barrel      
%       2164        resize_game           
%       2187        mouse_game            
%       2238           activate_mouse     
%       2290           track_mouse        
%       2343           update_pointer     
%       2449        generate_terrain_edges
%       2483        update_limits         
%       2512        update_controls       
%       2546        update_compass        
%       2562        post_message          
%       2583        render_bomb           
%       2748           render_explosion   
%       2919        end_game              
%       3043           callback_end       
%       3061        display_quit          
%       3103           callback_quit      
%       3148     display_help             
%       3212        callback_help         
%       3237     bomb_error               
%       3305        callback_error        
%       3319     add_game_data            
%       3341     update_game_data         
%       3357     reset_game_data          
%       3386     game2str                 
%       3404     num2arsenal              
%       3419     make_axes                
%       3433     make_button              
%       3453     make_check               
%       3474     make_edit                
%       3494     make_figure              
%       3511     make_list                
%       3532     make_menu                
%       3552     make_panel               
%       3569     make_slider              
%       3585     make_text                
%       3603     plot_line                
%       3617     plot_patch               
%       3631     plot_surface             
%       3647     plot_text                
%       3666     default_preferences      
%       3685     default_player_data      
%       3707  initialize_bomb_data        
%       3802  staker_data                 
%       3831  air_density                 
%       3859  water_density               
%       3870  num2money                   
%       3885  str2rgb                     
%       3905  within_axes                 
%       3919  normrand                    
%       3931  unit                        
%       3945  cross                       
%       3956  rotation_matrix
%
%      >> ftoc('staker.m','insert')    % Note change in line numbers
%
%      ans =
%
%      %                                   
%      % M-file contents:                  
%      %                                   
%      %    1  staker                      
%      %  291     initialize_intro         
%      %  343        callback_intro        
%      %  373     initialize_main          
%      ...
%      % 4008  unit                        
%      % 4022  cross                       
%      % 4033  rotation_matrix             
%      %                           

% Author: Ken Eaton
% Last modified: 10/28/08
%--------------------------------------------------------------------------

  % Check inputs:

  switch nargin,
    case 0,
      error('ftoc:notEnoughInputs','Not enough input arguments.');
    case 1,
      insertFlag = false;
    case 2,
      if (~ischar(insertFlag)),
        error('ftoc:badArgumentType',...
              'Format argument should be of type char.');
      end
      if strcmpi(insertFlag(:).','insert'),
        insertFlag = true;
      else
        error('ftoc:invalidFormat',...
              '''insert'' is the only valid format argument.');
      end
  end
  if (~ischar(fileName)),
    error('ftoc:badArgumentType','Input argument should be of type char.');
  end

  % Get file data using mlintmex:

  fileData = mlintmex('-calls',which(fileName));
  fileData = regexp(fileData,'[NS](\d+) (\d+) \d+ (\w+)\n','tokens');
  nFunctions = numel(fileData);
  if (nFunctions == 0),
    tocString = '';
    return;
  end
  fileData = reshape([fileData{:}],3,nFunctions);

  % Format file data:

  [filePath,fileName] = fileparts(fileName);
  if insertFlag,
    tocString = cellfun(@(x) str2double(x)+nFunctions+5,fileData(2,:),...
                        'UniformOutput',false);
  else
    tocString = cellfun(@(x) str2double(x),fileData(2,:),...
                        'UniformOutput',false);
  end
  tocString = [tocString; ...
               cellfun(@(x) blanks(3*str2double(x)),fileData(1,:),...
                       'UniformOutput',false); ...
               fileData(3,:)];
  tocString = sprintf('%5d  %s%s\n',1,'',fileName,tocString{:});
  index = (tocString == char(10));
  tocString(index) = ' ';
  tocString = deblank(char(mat2cell(tocString,1,diff([0 find(index)])).'));
  if insertFlag,
    tocString = char({'%'; '% M-file contents:'; '%'; ...
                      strcat('%',tocString); '%'});
  end

end
