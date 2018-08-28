function itemKC_sheet = make_itemKC_sheet(input_fname,section_name)
% MAKE_ITEMKC_SHEET - makes the "Items" sheet for KC_linkages.xlsx
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

itemKC_sheet= {};
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
                
                % Item ID
                item_ID = section{1,1};

                %Get knowledge components
                ans_rows= section(ismember(section(:,2),'answer'),:);
                
                %The way I have written problems, either every answer will
                %have the KC list, or just the true ones
                true_ind = strcmpi(ans_rows(:,5),'true');
                if any(true_ind)
                    KC_list = ans_rows{find(true_ind,1),4};
                else
                    KC_list = ans_rows{1,4};
                end
                
                %Remove spaces just in case and split by commas
                KC_list(isspace(KC_list)) = [];
                KC_list = strsplit(KC_list,',');
                
                %Add a line for each KC
                for kk = 1:length(KC_list)
                    itemKC_sheet(end+1,1:4) = {item_ID,'','',KC_list{kk}};
                end
        end
        fprintf('Finished sheet %s\n',sheets{ii})
    end
end


output_fname = [section_name '_itemKC_sheet.xlsx'];
fprintf('Writing to file: %s\n',output_fname)
xlswrite(output_fname,itemKC_sheet);