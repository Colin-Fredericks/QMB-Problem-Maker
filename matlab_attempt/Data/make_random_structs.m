

% Make random data for struct problem

addpath ..\util
num_structs = 30;


for ii = 1:num_structs  
  
    % Pick some random datas
    myStruct.randomInteger = randi(100,1);
    myStruct.randomDouble = rand*10;
    myStruct.randomString = randsample('a':'z',randi([3 6],1));
    myStruct.randomWord = sample_random_words(1);

    % Save to file
    save(sprintf('randomStruct%d.mat',ii),'myStruct')
end
    


