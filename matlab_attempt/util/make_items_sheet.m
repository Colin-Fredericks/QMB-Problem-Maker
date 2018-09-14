function item_sheet = make_items_sheet(input_fname,section_name)
% MAKE_ITEMS_SHEET - makes the "Items" sheet for KC_linkages.xlsx
%
%   C = make_items_sheet(FNAME) reads in the Excel file FNAME that contains 
%   problem descriptions and variable expressions that will be used for
%   dynamic problem generations. The output is the a cell array that can be
%   copied and pasted into the KC_linkages.xlsx file
%

%Get list of sheets
[~,sheets] = xlsfinfo(input_fname);

% If section isn't an input, get the first word in the filename, e.g.
% basics, arrays, loops, etc.
if nargin<2
   [~,name,~] = fileparts(input_fname);
   words_in_name = strsplit(name);
   section_name = words_in_name{1};
end

item_sheet = {};
fprintf('Parsing %s excel sheets to get items\n',section_name)
for ii = 1:length(sheets)
    
    %Only process Content Grouping sheets
    if strcmp(sheets{ii}(1:2),'CG')
        
        % Read in file
        excel_data = xls_read_as_string(input_fname,sheets{ii});

        if isempty(excel_data)
            continue;
        end
        % Figure out lines where questions start
        problem_starts = find(~cellfun(@isempty,excel_data(:,1)));
        num_problems = length(problem_starts);
        problem_starts(end+1) = size(excel_data,1)+1; %Add last row for last problem

        % Iterate through problems
        for jj = 1:num_problems

                % Extract the excel data for just this problem               
                rows = problem_starts(jj) : problem_starts(jj+1)-1;        
                section = excel_data(rows,:);    

                % Get item id
                item_id = section{1,1};
                
                % Problem type
                row = strcmp(section(:,2),'problemType');
                problem_type = section{row,3};
                
                % Is dynamic?
                row = strcmp(section(:,2),'dynamic');
                static = '';
                if strcmpi(section{row,3},'false')
                    static = ', static';
                end
                
                % Content grouping 
                content_group = sheets{ii};
                
                % Assemble item name
                item_name = [section_name ', ' item_id ', ' problem_type static]; 
                
                % Add line to sheet
                item_sheet(end+1,1:4) = {item_id,content_group,'Question',item_name};
        
        end
        fprintf('Finished sheet %s\n',sheets{ii})
    end
end

% output_fname = [section_name '_items_sheet.xlsx'];
% fprintf('Writing to file: %s\n',output_fname)
% xlswrite(output_fname,item_sheet);