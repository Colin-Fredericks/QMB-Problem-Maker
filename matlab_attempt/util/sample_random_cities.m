function cities = sample_random_cities(num_cities)
% SAMPLE_RANDOM_CITIES - pick random cities
%
%
%   names = sample_random_firstnames(n) will sample n names from the top
%   500 most common first names between 1963 and 2017 

%Open list of cities
load Data\top500cities cityTable

% Sample cities based on population, i.e. cities with higher population are
% picked more often
pdf = cityTable.population/sum(cityTable.population);
rows = zeros(num_cities,1);
for ii = 1:num_cities
    while true
        possible_index = randi(size(cityTable,1),1);
        if rand<pdf(possible_index)            
            break;
        end
    end
    rows(ii) = possible_index;
end


cities = cityTable{rows,'city'};

%Return just the string if only one word is sampled
if num_cities==1
    cities = cities{1};
end

