function [img_id,alt_txt,answers,words,symbols] = data12()
% function DATA12 - QMB problem data12
%
%   [img_id,answers,words,symbols] = data12()
%
%


% Load data
load Data\colormatch_data linespec

% Pick one
num_plot = size(linespec,1);
img_id = randi(num_plot,1);
linespec_choice = linespec(img_id,:);

% Data with possible choices
color_words = {'red','green','blue','cyan','yellow','magenta','black'};
color_symbols = 'rgbcymk';
linestyle_words = {'solid line','dashed line','dotted line','dash-dot line'}; 
linestyle_symbols = {'-','--',':','-.'};
marker_words = {'circles','plus signs','asterisks','dots','crosses (x''s)','squares', ...
    'diamonds','upward-pointing triangles','downward-pointing triangles'};
marker_symbols = 'o+*.xsd^v';

%Find matching ind to get words
color_ind = linespec_choice{1}==color_symbols;
marker_ind = linespec_choice{2}==marker_symbols;  
linestyle_ind = ismember(linestyle_symbols,linespec_choice{3});

             
% Assemble words and symbols for explanation
words = [color_words(color_ind) marker_words(marker_ind) ...
    linestyle_words(linestyle_ind)];
symbols = linespec_choice;

alt_txt = sprintf('A graph with a single line. The line has %s %s connected by a %s.', ...
    words{1},words{2},words{3});

% Get the 6 possible orderings as potential answers. Don't forget quotation
% marks ''
possible_orders = perms(1:3);
answers = cell(size(possible_orders,1),1);
for ii = 1:size(possible_orders,1)
    answers{ii} = ['''' strjoin(symbols(possible_orders(ii,:)),'') ''''];
end
    