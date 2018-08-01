function KC_info = get_KCs_from_excel(input_fname)
% GET_KCS_FROM_EXCEL - Like parse_excel, but for getting Knowledge
% Components
%
%   get_KCs_from_excel(FNAME) reads in the Excel file FNAME that contains 
%   problem descriptions and variable expressions that will be used for
%   dynamic problem generations. The output is the problems and their KCs
%

%Get list of sheets
[~,sheets] = xlsfinfo(input_fname);

KC_info = {};
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
                problem_name = section{1,1};

                %Append to cell array
                KC_info(end+1,1:3) = {sheets{ii},problem_name,KC_list};

            fprintf('Finished %d of %d problems\n',jj,num_problems)
        end
        fprintf('Finished sheet %s\n',sheets{ii})
    end
end