function T = make_random_table(varargin)
% MAKE_RANDOM_TABLE
%
%   T = make_random_table() makes a table with some random data
%
%   T = make_random_table('PropertyName',PropertyValue, ...) allows
%   properties to be set
%
%       Properties
%       1. rangeVariables - range of numbers used to pick number of
%          variables. Default: [2 10]
%       2. rangeObservations - range of numbers used to pick number of
%          observations. Default: [6 20]
%       3. variableNames - cell array of variable names that will overwrite
%          the random selection process. Default: {} (not used)
%


rangeVariables = [2 8];
rangeObservations = [6 20];
variableNames = {};

% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

% Possible names for variables.
stringVarNames = {'FirstName','LastName','City','EyeColor','HairColor', ...
    'RandomString','RandomWord'};
numberVarNames = {'Age','Height','ID','RandomDecimal', ...
    'RandomInteger'};

% Possible hair and eye color choices. There's only a few choices so make 
% sure to sample with replacement
eye_colors = {'amber','blue','brown','hazel','green','gray'}';
hair_colors = {'brown','white','blond','auburn','red','gray'}';

% Pick random variables if variableNames not an input
if isempty(variableNames)
    
    % Pick total number of variables
    nVariables = randi(rangeVariables,1);

    % Split variables up by type. Make sure there's at least 1 string and 1
    % numeric variable. Also make sure each doesn't exceed 6
    nStringVariables = randi([max(1,nVariables-length(numberVarNames)) ...
                              min(nVariables-1,length(stringVarNames))],1);
    nNumberVariables = nVariables - nStringVariables;
    
    % Get header of variable names
    header = [randsample(stringVarNames,nStringVariables), ...
              randsample(numberVarNames,nNumberVariables)];
    
    %Variable types
    varTypes = [repmat({'char'},1,nStringVariables), ...
                repmat({'double'},1,nNumberVariables)];

% Only do input variables if selected
else    
    
    nVariables = length(variableNames);
    
    % Loop through to get correct variable types and check to see if the
    % names exist
    varTypes = cell(size(variableNames));
    for iVar = 1:nVariables
        if ismember(variableNames{iVar},stringVarNames)
            varTypes{iVar} = 'char';
        elseif ismember(variableNames{iVar},numberVarNames)
            varTypes{iVar} = 'double';
        else
            error('Invalid variable name: %s\n',variableNames{iVar});
        end
    end
            
    % header is just the variable names
    header = variableNames;      
    
end

% Pick number of observations
nObservations= randi(rangeObservations,1);

% Shuffle the header and varTypes
shuffleInd = randperm(nVariables);
header = header(shuffleInd);
varTypes = varTypes(shuffleInd);

% Turn off the warning for allocating character arrays
warning('off','MATLAB:table:PreallocateCharWarning')

% Allocate table
T = table('Size',[nObservations nVariables],'VariableTypes',varTypes, ...
    'VariableNames',header);

% Loop through columns, getting random data
for iVar = 1:nVariables    
   
    switch header{iVar}
        case 'FirstName'
            T{:,iVar} = sample_random_firstnames(nObservations);
        case 'LastName'
            T{:,iVar} = sample_random_lastnames(nObservations);
        case 'City'
            T{:,iVar} = sample_random_cities(nObservations);
        case 'RandomWord'
            T{:,iVar} = sample_random_words(nObservations);
        case 'EyeColor'
            T{:,iVar} = randsample(eye_colors,nObservations,true);
        case 'HairColor'
            T{:,iVar} = randsample(hair_colors,nObservations,true);
        case 'RandomString'
            words = cell(nObservations,1);
            for iWord = 1:nObservations
                words{iWord} = randsample('a':'z',randi([4 6],1),true);
            end
            T{:,iVar} = words;
        case 'Age'
            T{:,iVar} = randi([18 65],nObservations,1);
        case 'Height'
            T{:,iVar} = round(randn(nObservations,1)*7 + 165);
        case 'ID'
            T{:,iVar} = randi([100000 999999],nObservations,1);
        case 'RandomDigits'
            digits = cell(nObservations,1);
            for iDigit = 1:nObservations
                digits{iDigit} = sprintf('%d-%d',randi([100 999],1),randi([1000 9999],1));
            end
            T{:,iVar} = digits;
        case 'RandomDecimal'
            T{:,iVar} = rand(nObservations,1);
        case 'RandomInteger'
            T{:,iVar} = randi([-100 100],nObservations,1);  
        otherwise
            error('Unknown variable name found');
    end
end
            


