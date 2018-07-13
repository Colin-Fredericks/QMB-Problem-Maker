%Test image cropping randomization
clear
close all

im_name = 'columns';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);


%Create row and col choices
row2 = round(size_im(1)/2);
row_choices = { '1:end', ...
               ['1:end-' num2str(row2)], ...
               ['end-' num2str(row2) ':end']};
col2 = round(size_im(2)/2);
col_choices = { '1:end', ...
               ['1:end-' num2str(col2)], ...
               ['end-' num2str(col2) ':end']};


figure
imshow(im)

figure
for ii = 1:length(row_choices)
    for jj = 1:length(col_choices)
        id = (ii-1)*3+jj;
        cropped_im = eval(['im(' row_choices{ii} ',' col_choices{jj} ',:)']);
        subplot(3,3,id);
        imshow(cropped_im);
        
        imwrite(cropped_im,['Cropped\' im_name '_endcrop' num2str(id) '.jpg']);
    end
end
% 
% figure
% subplot(2,2,1)
% imshow(im(randi

%<a href="/static/name_of_file.idk"></a>