%% Function description
% The function computes the top k eigenvectors of X1X1' and X2X2'
%
% Inputs: X1 and X2
%         k (number of eigen vectors reqd           
%
% Outputs: U1 and U2 (stores the top k eigen vectors)

%% Function code
function [U1,U2] = get_topk_U(X1, X2, k)

% get the top k eigen vectors (U) using the in-built svds function
[U1,dont_care1,dont_care2] = svds(X1,k);
[U2,dont_care1,dont_care2] = svds(X2,k);