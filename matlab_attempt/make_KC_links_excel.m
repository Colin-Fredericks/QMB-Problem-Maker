% Make KC_links excel file
clear
close all

addpath util
units = {'Arrays'};
output_fname = 'KC_links.xlsx';

%Initlize sheets with headers
KC_sheet = {'KC ID','KC name'};
KCKC_sheet = {'Post-req KC ID','Post-req KC name', ...
    'Pre-req KC ID','Pre-req KC name','Connection Strength'};
item_sheet = {'Item ID','Module','Category','Item Name', ...
    'Difficulty Level','Max Serve Times','Required next item ID', ...
    'Suggested next item ID','Student Group'};
itemKC_sheet = {'Item ID','category','Item name','KC ID','KC name', ...
    'Slip probability','Guess probability','Learning value'};

%Iterate through units
for unit = units
    
    % unit is a 1x1 cell, so need to extract the value
    unit_str = unit{1};

    %Uncompress tree XML file by calling python script
    windows_cmd = ['!@activate bunnies > nul && python drawio.py ' ...
        '"XML Trees\' unit_str '.xml"'];
    eval(windows_cmd)

    % Parse the uncompressed tree xml file
    tree_file = ['XML Trees\' unit_str ' uncompressed.xml'];
    [unit_KC_sheet,unit_KCKC_sheet] = make_KCKC_sheet(tree_file);
    
    %Append to sheets
    KC_sheet = [KC_sheet; unit_KC_sheet];
    KCKC_sheet = [KCKC_sheet; unit_KCKC_sheet];
    
    %Make the Item sheet
    problem_file = ['Excel problems\' unit_str ' questions.xlsx'];
    unit_item_sheet = make_items_sheet(problem_file);
    
    %Append to item sheet. Add some empty columns for the ones we haven't
    %filled
    [nItems,nCols] = size(unit_item_sheet);
    nHeaders = size(item_sheet,2);
    empty_cells = cell(nItems,nHeaders-nCols);
    item_sheet = [item_sheet; [unit_item_sheet empty_cells]];
    
    %Make the Item KC sheet
    unit_itemKC_sheet = make_itemKC_sheet(problem_file,item_sheet,KC_sheet);
    
    %Append to itemKC sheet. Add empty columns for ones that weren't filled
    [nItems,nCols] = size(unit_itemKC_sheet);
    nHeaders = size(itemKC_sheet,2);
    empty_cells = cell(nItems,nHeaders-nCols);
    itemKC_sheet = [itemKC_sheet; [unit_itemKC_sheet empty_cells]];
end

% Delete Excel file if it exits
if exist(output_fname)
    fprintf('Deleting old %s\n',output_fname);
    delete(output_fname)
end

% Write each sheet to excel file
xlswrite(output_fname,item_sheet,'Items');
xlswrite(output_fname,KC_sheet,'KC');
xlswrite(output_fname,itemKC_sheet,'Item-KC');
xlswrite(output_fname,KCKC_sheet,'KC-KC');
fprintf('Finished writing: %s\n',output_fname);

        
        







