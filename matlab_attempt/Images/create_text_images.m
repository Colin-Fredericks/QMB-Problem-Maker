%make images with text on them
clear
close all

T = readtable('..\Data\word_lookup.csv');

%Instantiate textInserter object for current word
font_name = 'Times New Roman';
font_size = 72;
font_color = 250+[0 0 0];
pic_dim = [200 420];
background_color = [255];

for ii = 1:size(T,1)    

    %Create image with background color
    mainI = background_color + zeros(pic_dim(1),pic_dim(2), 'uint8');

    position = [10 40];
    mainI = rgb2gray(insertText(mainI,position,T.word{ii},'Font',font_name, ...
        'FontSize',font_size,'TextColor',font_color, ...
        'BoxOpacity',0));


    imwrite(mainI,['Cropped\word' num2str(ii) '.png'])

    %Show the image
    figure
    imshow(mainI,[])
end