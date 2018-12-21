% Make 1D data arrays for summary statistics

num_arrays = 20;
size_array = [10 10];

for ii = 1:num_arrays
    
    min_val = randsample(0:10:90,1);
    max_val = randsample(min_val:10:100,1);
        
    myArray = randi([min_val max_val],size_array);
    
    save(['rand_2D_array_' num2str(ii)],'myArray');
end