% Attempt to parse question file into something that can be used by python
% script
clear
close all


num_dynamic = 5; %Number of dyanmic questions to make
input_fname = 'new_questions'; %Excel file name
sheet = 'matlab_questions'; %Sheet in excel file
output_dir = 'Filled-in Excel files';

% Read in file
excel_data = xls_read_as_string(input_fname,sheet);

%Check if output firectory exists
if ~exist(output_dir,'dir')
    mkdir(output_dir);
end
    

% Figure out lines where questions start
problem_starts = find(~cellfun(@isempty,excel_data(:,1)));
num_problems = length(problem_starts);
problem_starts(end+1) = size(excel_data,1); %Add last row for last problem


for ii = 1:num_problems
    for qq = 1:num_dynamic
        
        % -----------------------------------------------------------------
        % Extract the excel data for just this problem
        % -----------------------------------------------------------------
        rows = problem_starts(ii) : problem_starts(ii+1)-1;
        section = excel_data(rows,:);    
    
        
        % -----------------------------------------------------------------        
        % Evaluate variables
        % -----------------------------------------------------------------
        ind_var = find(ismember(section(:,2),'variable'));
        var_names = section(ind_var,3);
        var_values = cell(length(ind_var),1);
        for kk = 1:length(ind_var)
            
            % Expression to be evaluated
            var_expr = section{ind_var(kk),4};
            
            % First, see if this expression calls another variable and 
            % Replace with the value if necessary.
            for mm = 1:length(var_names)
                if strfind(var_expr,var_names{mm});
                    var_expr = strrep(var_expr,var_names{mm},var_values{mm});
                end
            end
            
            %Now evaluate
            var_eval =  eval(var_expr);
            
            % If string, save as answer
            if ischar(var_eval)
                var_values{kk} = var_eval;
            % If cell array of strings, try taking first value
            elseif iscellstr(var_eval)
                if length(var_eval)==1
                    var_values(kk) = var_eval;
                else
                    error('Something went wrong with evaluating: %s',val_expr);
                end
            % Else, try converting from num2str (should work for bools and
            % numeric values)
            else
                var_values{kk} = num2str(var_eval);
            end
        end
        
        % -----------------------------------------------------------------
        % Now replace variables in answers and questionText with generated
        % values
        % -----------------------------------------------------------------
        
        % First the question text
        questionText = section{1,3};
        for mm = 1:length(var_names)
            if strfind(questionText,var_names{mm});
                questionText = strrep(questionText,var_names{mm},var_values{mm});
            end
        end
        section{1,3} = questionText;
        
        % Now the answers. 
        ind_ans = find(ismember(section(:,2),'answer'));
        for kk = 1:length(ind_ans)
            answerText = section{ind_ans(kk),3};
            for mm = 1:length(var_names)
                if strfind(answerText,var_names{mm});
                    answerText = strrep(answerText,var_names{mm},var_values{mm});
                end
            end
            section{ind_ans(kk),3} = answerText;
        end        
         
        % -----------------------------------------------------------------
        % Since we no longer need variables remove from section and write
        % to an output file
        % -----------------------------------------------------------------
        non_var_rows = ~ismember(section(:,2),'variable');
        section = section(non_var_rows,:);
        output_fname = [section{1,1} '.' num2str(qq-1)];
        xlswrite([output_dir '\' output_fname '.xlsx'],section);
        
        % Check to see if this is a dynamic problem. If not, break from the
        % loop and more on to next problem
        if ~strcmp(section(ismember(section(:,2),'dynamic'),3),'true')            
            break;            
        end
    end
    fprintf('Finished %d of %d problems\n',ii,num_problems)
end