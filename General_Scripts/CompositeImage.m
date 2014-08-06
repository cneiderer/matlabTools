%   COMPOSITEIMAGE - tessellates images
%   Simon Robinson. 9.2.2009
%      
%   Creates a tessellated image with a user-selected number of rows and
%   columns from a number of images of the same size
%
%   Example 
%
%   The following lines can be used to generate some images for the
%   examples below
%
% load mri;
% D = squeeze(D);
% D = (255/max(D(:)))*D;
% if ispc == 1
%     root_dir = 'C:\CompositeImageExample';
% else
%     root_dir = '/home/CompositeImageExample';
% end
% mkdir(root_dir);
% for i = 1:size(D,3)
%     imwrite(D(:,:,i),fullfile(root_dir, ['slice_' int2str(i) '.png']));
% end
%
%   Example 1) Create a 3x3 image, specifying the first slice number, last
%   slice number and interval
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beginning of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% root_dir = 'C:\CompositeImageExample';
% define_images_explicitly = 'no';
% filename_root = 'slice_';
% first_image_number = 2;
% last_image_number = 18;
% interval = 2;
% no_rows = 3;
% zero_pad = 'no'; %if image numbers are padded with zeros - e.g. slice_001 to slice_999 rather than slice_1 to slice_999
% composite_filename = 'composite_image.png';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Example 2) Create a 2x5 image, specifying particular slices to be included
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beginning of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% root_dir = 'C:\CompositeImageExample';
% define_images_explicitly = 'yes';
% filename_root = 'slice_';
% image_numbers = [3 6 9 27 4 1 17 8 21 11];
% no_rows = 2;
% zero_pad = 'no'; %if image numbers are padded with zeros - e.g. slice_001 to slice_999 rather than slice_1 to slice_999
% composite_filename = 'composite_image.png';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beginning of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of user-specified parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear image_fn_dir;

if strcmp(define_images_explicitly, 'no')==1
    max_str_length=ceil(log10(last_image_number));
    no_images=floor((last_image_number-first_image_number)/interval+1);
else
    no_images=numel(image_numbers);
end

for i=1:no_images
    if strcmp(define_images_explicitly, 'no')
        str_image_number = num2str(first_image_number + (i-1)*interval);
        switch zero_pad
            case 'yes'
                if size(str_image_number) < max_str_length
                    str_image_number = ['0' str_image_number];
                end
        end
        image_fn_dir = dir(fullfile(root_dir, [filename_root str_image_number '.*']));       
    else
        image_fn_dir = dir(fullfile(root_dir, [filename_root int2str(image_numbers(i)) '.*']));
    end
    if numel(image_fn_dir) > 1
        error('filename_root and image_number do not uniquely identify an image')
    elseif numel(image_fn_dir) == 0
        error('there are no images matching that pattern')
    end
    image_fn = fullfile(root_dir, image_fn_dir.name);
    imI = imread(image_fn);
    if i == 1
        no_collumns = ceil(no_images/no_rows);
        size_y = size(imI, 1);
        size_x = size(imI, 2);
        size_z = size(imI, 3);
        switch size_z
            case 1
                colour = 'no';
                canvas = zeros(no_rows*size_y, no_collumns*size_x, 'uint8');
            case 3
                colour = 'yes';
                canvas = zeros(no_rows*size_y, no_collumns*size_x, 3, 'uint8');
        end
        % for colour pngs = 3, for b/w =1
        image_format = image_fn_dir.name(findstr(image_fn_dir.name, '.')+1:end);
    end
    row_no = 1 + floor((i-1)/no_collumns);
    col_no = i + (1 - row_no)*no_collumns;
    disp([num2str(i) '-> [' num2str(row_no) ',' num2str(col_no) ']']);
    try
        switch colour
            case 'yes'
                canvas((row_no-1)*size_y+1:row_no*size_y,(col_no - 1)*size_x+1:col_no*size_x,:) = imI(:,:,:);
            case 'no'
                canvas((row_no-1)*size_y+1:row_no*size_y,(col_no - 1)*size_x+1:col_no*size_x) = imI(:,:);
        end
        %   image(canvas);
    catch
        disp('');
    end
end
imwrite(canvas, fullfile(root_dir, composite_filename), image_format);
disp(['Written ' fullfile(root_dir, composite_filename)]);
disp('***Finished***');



