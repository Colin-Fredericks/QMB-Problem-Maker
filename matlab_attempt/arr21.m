function [correct_answer,incorrect_answer,display] = arr21(name,values,choice,delim,number)
% function ARR21 - Answers for QMB problem arr21
%
%   [answers,is_correct] = arr21(array_name,array_size,num,chance_none)
%
%

%Make the initial display a row or column vector
if strcmp(choice,'row')
    display = mat2string(values);
    
    % If it's a row vector being appended with a comma, this is okay
    if delim == ','
        correct_answer = ['$' name ' = ' mat2string([values number]) '/$'];
        
        %Get base, i.e. '[1,2,3' without the closing bracket
        base = mat2string(values);
        base = base(1:end-1);        
        incorrect_answer{1} = ['$' name ' = ' base '; ' num2str(number) ']/$'];
        
        %Other incorrect answers
        incorrect_answer{2} = ['$' name ' = ' mat2string([values';number]) '/$'];
        incorrect_answer{3} = ['$' name ' = ' mat2string(values + number) '/$'];
        incorrect_answer{4} = 'None of these. The original commands will produce an error';  
      
    % Appending to a row vector with a semicolon will produce an error
    elseif delim ==';'
        correct_answer = 'None of these. The original commands will produce an error'; 
        
        %Get base, i.e. '[1,2,3' without the closing bracket
        base = mat2string(values);
        base = base(1:end-1);
        incorrect_answer{1} = ['$' name ' = ' base '; ' num2str(number) ']/$'];
        
        %Other incorrect answers
        incorrect_answer{2} = ['$' name ' = ' mat2string([values';number]) '/$'];
        incorrect_answer{3} = ['$' name ' = ' mat2string(values + number) '/$'];
        incorrect_answer{4} = ['$' name ' = ' mat2string([values number]) '/$'];
    end  

%Now handle if the original vector is a column vector
elseif strcmp(choice,'column')
    display = mat2string(values');
    
    %Appending to a column vector with a semicolon is okay
    if delim == ';'
        correct_answer = ['$' name ' = ' mat2string([values';number]) '/$'];
        
        %Get base, i.e. '[1;2;3' without the closing bracket
        base = mat2string(values');
        base = base(1:end-1);        
        incorrect_answer{1} = ['$' name ' = ' base ', ' num2str(number) ']/$'];
        
        %Other incorrect answers
        incorrect_answer{2} = ['$' name ' = ' mat2string([values number]) '/$'];
        incorrect_answer{3} = ['$' name ' = ' mat2string(values + number) '/$'];
        incorrect_answer{4} = 'None of these. The original commands will produce an error';  
    
    % Appending with a comma produces an error
    elseif delim ==','
        correct_answer = 'None of these. The original commands will produce an error'; 
        
        %Get base, i.e. '[1,2,3' without the closing bracket
        base = mat2string(values');
        base = base(1:end-1);
        incorrect_answer{1} = ['$' name ' = ' base ', ' num2str(number) ']/$'];
        
        %Other incorrect answers
        incorrect_answer{2} = ['$' name ' = ' mat2string([values number]) '/$'];
        incorrect_answer{3} = ['$' name ' = ' mat2string(values + number) '/$'];
        incorrect_answer{4} = ['$' name ' = ' mat2string([values';number]) '/$'];
    end  
    
    
end

end



   