function [eigvec, eigval, eigval_full] = eig1(A, c, isMax, isSym)

if nargin < 2
    c = size(A,1);
    isMax = 1;
    isSym = 1;
elseif c > size(A,1)
    c = size(A,1);
end;

if nargin < 3
    isMax = 1;
    isSym = 1;
end;

if nargin < 4
    isSym = 1;
end;

if isSym == 1
    A = max(A,A');
end;
[v d] = eig(A);%[V,D]=eig(A)：求矩阵A的全部特征值，构成对角阵D，并求A的特征向量构成V的列向量。
d = diag(d);%用列向量表示特征值
%d = real(d);
if isMax == 0
    [d1, idx] = sort(d);
else
    [d1, idx] = sort(d,'descend');
end;

idx1 = idx(1:c);
eigval = d(idx1);
eigvec = v(:,idx1);

eigval_full = d(idx);