%% Function description
% The function performs classification and computes the number of
% miclassification over the data set
%
% Inputs: path (path to the folder containing images)
%         k (how many top eigen vectors to be considered)
% Outputs: m (number of misclassifications)

%% Function code
function misclassification_count = misclassifications(path, k)

% get the pre-processed data from the folder
[X1t, X2t, Y1, Y2] = read_data(path);

% get the top k eigen vectors
[U1,U2] = get_topk_U(X1t, X2t, k);

% initialize the count to zero
misclassification_count=0;

% compute the error in estimating samples from Y1 using U1 and U2

% get the dimensions of Y1
m = size(Y1,1);
n = size(Y1,2);

% initialize the error in estimates for Y1
e1_y1 = zeros(n,1);
e2_y1 = zeros(n,1);

for a_idx = 1:n
    
    % initialize the projected vectors onto U1 and U2
    proj_onto_U1 = zeros(m,1);
    proj_onto_U2 = zeros(m,1);
    
    % compute the projection of a onto U1
    for u1_idx = 1:size(U1,2)
        proj_onto_U1 = proj_onto_U1 + ((U1(:,u1_idx)'*Y1(:,a_idx))*U1(:,u1_idx))/(U1(:,u1_idx)'*U1(:,u1_idx));
    end
    % compute the error in estimating a using this projection
    e1_y1(a_idx) = (norm(Y1(:,a_idx) - proj_onto_U1)) / norm(Y1(:,a_idx));
    
    % compute the projection of a onto U2
    for u2_idx = 1:size(U2,2)
        proj_onto_U2 = proj_onto_U2 + ((U2(:,u2_idx)'*Y1(:,a_idx))*U2(:,u2_idx))/(U2(:,u2_idx)'*U2(:,u2_idx));
    end
    % compute the error in estimating a using this projection
    e2_y1(a_idx) = (norm(Y1(:,a_idx) - proj_onto_U2)) / norm(Y1(:,a_idx));
    
    % error is less for the prediction of neutral while the truth lable is
    % smiling, so it is a misclassification
    if e1_y1(a_idx) > e2_y1(a_idx)
        misclassification_count = misclassification_count + 1;
    end
end


% compute the error in estimating samples from Y2 using U1 and U2

% get the dimensions of Y2
m = size(Y2,1);
n = size(Y2,2);

% initialize the error in estimates for Y2
e1_y2 = zeros(n,1);
e2_y2 = zeros(n,1);

for a_idx = 1:n
    
    % initialize the projected vectors onto U1 and U2
    proj_onto_U1 = zeros(m,1);
    proj_onto_U2 = zeros(m,1);
    
    % compute the projection of a onto U1
    for u1_idx = 1:size(U1,2)
        proj_onto_U1 = proj_onto_U1 + ((U1(:,u1_idx)'*Y2(:,a_idx))*U1(:,u1_idx))/(U1(:,u1_idx)'*U1(:,u1_idx));
    end
    % compute the error in estimating a using this projection
    e1_y2(a_idx) = (norm(Y2(:,a_idx) - proj_onto_U1)) / norm(Y2(:,a_idx));
    
    % compute the projection of a onto U2
    for u2_idx = 1:size(U2,2)
        proj_onto_U2 = proj_onto_U2 + ((U2(:,u2_idx)'*Y2(:,a_idx))*U2(:,u2_idx))/(U2(:,u2_idx)'*U2(:,u2_idx));
    end
    % compute the error in estimating a using this projection
    e2_y2(a_idx) = (norm(Y2(:,a_idx) - proj_onto_U2)) / norm(Y2(:,a_idx));

    % error is less for the prediction of smiling while the truth lable is
    % neutral, so it is a misclassification
    if e1_y2(a_idx) < e2_y2(a_idx)
        misclassification_count = misclassification_count + 1;
    end
end