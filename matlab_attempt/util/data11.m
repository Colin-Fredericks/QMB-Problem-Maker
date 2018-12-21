function [answers,words,symbols] = data11()
% function DATA11 - QMB problem data11
%
%   [answer,explanation] = data10()
%
%

% Data with possible choices
color_words = {'red','green','blue','cyan','yellow','magenta','black'};
color_symbols = 'rgbcymk';
linestyle_words = {'solid line','dashed line','dotted line','dash-dot line'}; 
linestyle_symbols = {'-','--',':','-.'};
marker_words = {'circles','plus signs','asterisks','dots','crosses (x''s)','squares', ...
    'diamonds','upward-pointing triangles','downward-pointing triangles'};
marker_symbols = 'o+*.xsd^v';


%Pick an answer
while true

    % Sample from the possible choices
    color_ind = randi(length(color_words),1);
    linestyle_ind = randi(length(linestyle_words),1);
    marker_ind = randi(length(marker_words),1);    

    % Answers to avoid: 
    %   bo- (it's the example in the question description)
    %   -. (solid line with dot)    
    condition1 = color_symbols(color_ind) == 'b' & ...
                 marker_symbols(marker_ind) == 'o' & ...
                 strcmp(linestyle_symbols{linestyle_ind},'-');
    condition2 = marker_symbols(marker_ind) == '.' & ...
                 strcmp(linestyle_symbols{linestyle_ind},'-');
             
    % Break if both conditions aren't met
    if ~condition1 && ~condition2
        break
    end
end
             
% Assemble words and symbols for explanation
words = [color_words(color_ind) marker_words(marker_ind) ...
    linestyle_words(linestyle_ind)];
symbols = [{color_symbols(color_ind)} {marker_symbols(marker_ind)} ...
    linestyle_symbols(linestyle_ind)];

% Get the 6 possible orderings as potential answers. Don't forget quotation
% marks ''
possible_orders = perms(1:3);
answers = cell(size(possible_orders,1),1);
for ii = 1:size(possible_orders,1)
    answers{ii} = ['''' strjoin(symbols(possible_orders(ii,:)),'') ''''];
end
    