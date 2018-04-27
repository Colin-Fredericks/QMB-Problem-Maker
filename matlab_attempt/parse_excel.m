function parse_excel(input_fname,varargin)
% PARSE_EXCEL - Reads in the problem descriptions in one excel file and
% writes the dynamic problems to separate EXCEL files
%
%   parse_excel(FNAME) reads in the Excel file FNAME that contains the
%   problem descriptions and variable expressions that will be used for
%   dynamic problem generations. The output is one excel file for each
%   problem in a seaparate directory
%
%   parse_excel(FNAME,'PropertyName',PropertyValue, ... ) allows for
%   multiple properties to be set below
%
%       excel_sheet - Name or number of sheet in excel file used by xlsread
%           Default: 1
%       output_dir - Name of output directory for individual excel files
%           Default: 'Filled-in Excel files'
%       num_dynamic - Number of dynamic copies of each problem to make.
%           This will only apply if the 'dynamic' property in the excel
%           file is set to true. Default: 1
%      
%       
%

% Input variables
num_dynamic = 1; %Number of dyanmic questions to make
sheet = 1; %Sheet in excel file
output_dir = 'Filled-in Excel files'; %Output directory for excel files

% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

% Read in file
excel_data = xls_read_as_string(input_fname,sheet);

%Check if output firectory exists
if ~exist(output_dir,'dir')
    mkdir(output_dir);
end
    

% Figure out lines where questions start
problem_starts = find(~cellfun(@isempty,excel_data(:,1)));
num_problems = length(problem_starts);
problem_starts(end+1) = size(excel_data,1)+1; %Add last row for last problem


for ii = 1:num_problems
    for jj = 1:num_dynamic
        
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
                if strfind(var_expr,var_names{mm})
                    var_expr = strrep(var_expr,var_names{mm},var_values{mm});
                end
            end
            
            % Now evaluate. Dont save value if code is only meant to
            % execute, which is denoted by the CODE variable
            if strcmp(var_names{kk},'CODE')
                eval(var_expr);
            else
                var_eval =  eval(var_expr);
            end
            
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
        % Now iterate through each element, replacing any variables
        % with generated values. Also add code tags for $ characters
        % -----------------------------------------------------------------
        for mm = 1:numel(section)
            
            %First variables
            for nn = 1:length(var_names)
                if strfind(section{mm},var_names{nn})
                    section{mm} = strrep(section{mm},var_names{nn},var_values{nn});
                end
            end
            
            %Now XML escape characters
            section{mm} = escape_XML(section{mm});
            
            %Finally, the $ tags for matlab code
            section{mm} = strrep(section{mm},'/$','</code>');                
            section{mm} = strrep(section{mm},'$','<code class="lang-matlab">');
            
        end
            
        % -----------------------------------------------------------------
        % Since we no longer need variables remove from section and write
        % to an output file
        % -----------------------------------------------------------------
        non_var_rows = ~ismember(section(:,2),'variable');
        section = section(non_var_rows,:);
        output_fname = [section{1,1} '.' num2str(jj-1)];
        xlswrite([output_dir '\' output_fname '.xlsx'],section);
        
        % Check to see if this is a dynamic problem. If not, break from the
        % loop and more on to next problem
        if ~strcmp(section(ismember(section(:,2),'dynamic'),3),'true')            
            break;            
        end
    end
    fprintf('Finished %d of %d problems\n',ii,num_problems)
end