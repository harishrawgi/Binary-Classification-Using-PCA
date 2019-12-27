%% Function description
% The function reads the image data and pre-processes it
%
% Inputs: path to images
%
% Outputs: X1t, X2t, Y1, Y2

%% Function code
function [X1t, X2t, Y1, Y2] = read_data(path)

% set the number of images to be read of each class
n = 200;

% these will store the names of the files
smiling_images = strings(n,1);
neutral_images = strings(n,1);

% construct the names of the files
for k=1:n
    smiling_images(k) = strcat(num2str(k),"b.jpg");
    neutral_images(k) = strcat(num2str(k),"a.jpg");
end

% initialize the X1 and X2 arrays
X1 = zeros(31266,200);
X2 = zeros(31266,200);

% now we read each image one by one 
% convert it to column and add to X1/X2
for i=1:length(smiling_images)
    
    baseFileName = smiling_images(i);
    fullFileName = fullfile(path, char(baseFileName));
    imgArray = imread(fullFileName);
    X1(:,i) = imgArray(:);

    baseFileName = neutral_images(i);
    fullFileName = fullfile(path, char(baseFileName));
    imgArray = imread(fullFileName);
    X2(:,i) = imgArray(:);
end

% now we remove the bias from all the images

% compute the mean along all columns for X1 and X2
mu1 = mean(X1,2);
mu2 = mean(X2,2);

% iterate over the columns and remove the bias
for k=1:size(X1,2)
    X1(:,k) = X1(:,k) - mu1;
    X2(:,k) = X2(:,k) - mu2;
end

% generate the training and testing data
% take the first 180 columns as training data and remaining as testing
X1t = X1(:,1:180);
Y1 = X1(:,181:200);

X2t = X2(:,1:180);
Y2 = X2(:,181:200);