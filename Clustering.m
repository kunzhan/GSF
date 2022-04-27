function [ACC, MIhat, Purity,Pi, Ri, Fi,ARi,clusternum,kmem] = Clustering(So,c,groundtruth,gamma1,gamma2 ,islocal,k)
% X:                cell array, 1 by view_num, each array is num by d_v
% c:                number of clusters
% v:                number of views
% k:                number of adaptive neighbours
%groundtruth£º      groundtruth of the data, num by 1

% if nargin < 7
%     k = 9;
% end;

v= size(So,3);
num = size(So,1);
NITER = 30;

% A = sum(So,3);
% A = (A + A')/2;
% DA = diag(sum(A));
% LA = DA - A;
% [U, ~, ~]=eig1(LA, c, 0);
% S = ones(num);
% for i = 1:v
%     S = S.*So(:,:,i);
% end

S = ones(num);
for i = 1:v
    S = S-diag(diag(S));
    S = S.*So(:,:,i);
end
S = (S + S')/2;
DA = diag(sum(S));
LA = DA - S;
[U, ~, ~]=eig1(LA, c, 0);
Sa = S;
% [clusternum, ~] = graphconncomp(sparse(Sa))
%% =====================   Normalization =====================
% % for i = 1 :v
%     for  j = 1:num
%       X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) ) ;
%     end
% end
%% =====================  updating =====================
distX = L2_distance_1(U',U');
% distX = L2_distance_1(X{3}',X{3}');
[~,idx] = sort(distX,2);
obj = [];
for iter = 1:NITER
    %update S
    S = zeros(num);
    distu = L2_distance_1(U',U');
    for i=1:num
        if islocal ==1
            idxa0 = idx(i,2:k + 1);
        else
            idxa0 = 1:num;
        end
        dui = distu(i,idxa0);
        dus = Sa(i,idxa0);
        ad = -(dui - gamma1*dus)/(2*gamma2);
        S(i,idxa0) = EProjSimplex_new(ad);
    end
    
    S = (S + S')/2;
    D = diag(sum(S));
    L = D - S;
    U_old = U;
    % Update U
    [U, ~, ev]=eig1(L, c, 0);
    thre = 1*10^-5;
    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));
    ob = trace(U'*L*U) - gamma1*trace(S*Sa) + gamma2*trace(S*S') ;
    obj = [obj ob];
    if fn1 > thre
        gamma2 = gamma2/2;
    elseif fn2 < thre
        gamma2 = gamma2*2;  U = U_old;
    else
        break;
    end
%     sprintf('iter = %d',iter)
    
end
plot(obj);
%% =====================  result =====================
% plot(obj);
[clusternum, y]=graphconncomp(sparse(S)); y = y';
[ACC, MIhat, Purity] = ClusteringMeasure(groundtruth, y);
ARi = RandIndex(groundtruth,y);
[Fi,Pi,Ri] = compute_f(groundtruth,y);

obj1 = zeros(1,100);
for i=1:100
    [C(:,i),~,sumd] = kmeans(U,c,'EmptyAction','drop');
    obj1(i) = sum(sumd);
end
% idx = find(obj1 == min(obj1));
% Y = C(:,idx(1));
kmem = min(obj1);
% AR = RandIndex(groundtruth,Y)
% [F,P,R] = compute_f(groundtruth,Y)
% [acci, nmii, Pui] = ClusteringMeasure(groundtruth, Y)


end