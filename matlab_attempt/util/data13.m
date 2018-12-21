function [correct,incorrect,linespec_str,correct_words,explanation] = data13()
% function DATA13 - QMB problem data13
%
%   [correct,incorrect,linespec_str,words,symbols] = data13()
%
%

% Chance for 'None of these'
chance_none = 0.2;

% Load data
load Data\colormatch_data linespec

% Pick one plot for the question
num_plot = size(linespec,1);
correct_id = randi(num_plot,1);
linespec_choice = linespec(correct_id,:);
linespec_str = strjoin(linespec(correct_id,:),'');

% Data with possible choices
color_words = {'red','green','blue','cyan','yellow','magenta','black'};
color_symbols = 'rgbcymk';
linestyle_words = {'solid line','dashed line','dotted line','dash-dot line'}; 
linestyle_symbols = {'-','--',':','-.'};
marker_words = {'circles','plus signs','asterisks','dots','crosses (x''s)','squares', ...
    'diamonds','upward-pointing triangles','downward-pointing triangles'};
marker_symbols = 'o+*.xsd^v';


% Assemble words and symbols for explanation
color_ind = linespec_choice{1}==color_symbols;
marker_ind = linespec_choice{2}==marker_symbols;  
linestyle_ind = ismember(linestyle_symbols,linespec_choice{3});
correct_words = [color_words(color_ind) marker_words(marker_ind) ...
        linestyle_words(linestyle_ind)];    
    
% Decide if the correct image is one of the choices
if rand > chance_none 
    
    %Assemble answers
    alt_txt = sprintf('A graph with a single line. The line has %s %s connected by a %s.', ...
        correct_words{1},correct_words{2},correct_words{3});
    correct = sprintf('<a href="/static/colormatch_%d.png" target="_blank"><img src="/static/colormatch_%d.png" alt="%s"/></a>', ...
        correct_id,correct_id,alt_txt);
    
    % Pick 3 incorrect answers
    wrong_ind = randsample([1:correct_id-1 correct_id+1:num_plot],3);
    for ii = 1:3
        linespec_choice = linespec(wrong_ind(ii),:);
        color_ind = linespec_choice{1}==color_symbols;
        marker_ind = linespec_choice{2}==marker_symbols;  
        linestyle_ind = ismember(linestyle_symbols,linespec_choice{3});
        words = [color_words(color_ind) marker_words(marker_ind) ...
            linestyle_words(linestyle_ind)];
        alt_txt = sprintf('A graph with a single line. The line has %s %s connected by a %s.', ...
            words{1},words{2},words{3});
        incorrect{ii} = sprintf('<a href="/static/colormatch_%d.png" target="_blank"><img src="/static/colormatch_%d.png" alt="%s"/></a>', ...
            wrong_ind(ii),wrong_ind(ii),alt_txt);
    end
    incorrect{4} = 'None of these';
    
    % NO extra explanation necessary
    explanation = ''; 

else
    
    %Correcxt image is not shown
    correct = 'None of these';
    
    % Pick 4 wrong answers
    wrong_ind = randsample([1:correct_id-1 correct_id+1:num_plot],4);
    for ii = 1:4
        linespec_choice = linespec(wrong_ind(ii),:);
        color_ind = linespec_choice{1}==color_symbols;
        marker_ind = linespec_choice{2}==marker_symbols;  
        linestyle_ind = ismember(linestyle_symbols,linespec_choice{3});
        words = [color_words(color_ind) marker_words(marker_ind) ...
            linestyle_words(linestyle_ind)];
        alt_txt = sprintf('A graph with a single line. The line has %s %s connected by a %s.', ...
            words{1},words{2},words{3});
        incorrect{ii} = sprintf('<a href="/static/colormatch_%d.png" target="_blank"><img src="/static/colormatch_%d.png" alt="%s"/></a>', ...
            wrong_ind(ii),wrong_ind(ii),alt_txt);
    end
    
    % Explanation
    explanation = 'However, a line with these properties is not one of the choices. '; 
end
    
