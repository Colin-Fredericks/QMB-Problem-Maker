clear
close

%NaN matrix with NaN on 3 diagonals
nan_mat = diag(NaN(100,1)) + diag(NaN(99,1),1) + diag(NaN(99,1),-1);

%Array of random integers. Each column gets progessively larger
myArray = rand(100).*(1:100)*2; 

%Add to nan_mat
myArray = myArray + nan_mat;

% Shuffle columns and rows
myArray = myArray(randperm(100),:);
myArray = myArray(:,randperm(100));

%Confirm
figure,
imagesc(isnan(myArray))

%Should return 1
all(isnan(mean(myArray)))

%Save
save nan_matrix.mat myArray

