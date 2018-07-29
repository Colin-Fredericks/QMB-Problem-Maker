%Generate all array questions
clear
close all

fpath = 'C:\Users\brian\Google Drive\Quant Methods for Biology\Adaptive\Sections\';

fnames = {[fpath '2. Basics\Basics questions.xlsx']; ...
          [fpath '3. Arrays\Array questions.xlsx']; ...
          [fpath '4. Images\Images questions.xlsx']; ...
          [fpath '5. Loops\Loop questions.xlsx']};

addpath('Problem functions')

KC_info = {};
for ii = 1:length(fnames)
    KC_info = [KC_info; get_KCs_from_excel(fnames{ii})];
end

%Write to excel file
xlswrite('All KCs used in questions.xlsx',KC_info);