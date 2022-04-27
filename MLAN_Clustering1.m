addpath('../MV_datasets');
clear ;clc


% dataset = load('C101_p1474.mat');%k1 = 91 k2 = 9 gamma1 = gamma2 =1  UTS = 91/11
dataset = load('ORL_ZCQ.mat');%k1 = 39,k2 = 6 gamma1 = 1  gamma2 = 1
% dataset = load('COIL_20_ZCQ.mat');%K1 = 10,K2 = 9


% X = dataset.X;
% groundtruth = dataset.gt;
X = dataset.X_train;
groundtruth = dataset.truth;
c = length(unique(groundtruth));
n = size(X{1},2);
nv = length(X);
S = zeros(n,n,nv);
U = cell(1,nv);

% for i = 1 :nv
%     for  j = 1:n
%         X{i}(:,j) = ( X{i}(:,j) - mean( X{i}(:,j) ) ) / std( X{i}(:,j) ) ;
%     end
% end
% result = zeros(length(5:2:30)*length(3:30),10);
i = 1;
obj = zeros(10,3);

for K1 = 39
    for K2 = 6
        for gam1 = 0
            for gam2 = 0
                gamma1 = 10^gam1;
                gamma2 = 10^gam2;
                for v = 1:nv
                    S(:,:,v) = constructW_PKN(X{v},K1);
                    %                             A0 = (S(:,:,v)+S(:,:,v)')/2;
                    %                             D0 = diag(sum(A0));
                    %                             L0 = D0 - A0;
                    %                             [U{v}, ~, evs] = eig1(L0, c, 0);
                    %                             [clusternum, ~] = graphconncomp(sparse(S(:,:,v)))
                end
                [ACC, MIhat, Purity,Pi, Ri, Fi,ARi,cluster,kmem] = Clustering(S,c,groundtruth,gamma1,gamma2,1,K2);
                %             result(i,:) = [K1,K2,ACC, MIhat, Purity,Pi, Ri, Fi,ARi,cluster];
                %             i = i + 1;
                obj(i,:) = [K1,ACC,kmem];
                %                 fprintf('=========== K1 = %d,K2 = %d clusrer = %d =========\n',K1,K2,cluster)
                %                 fprintf('=========== gamma1 = %f,gamma2 = %f =========\n',gamma1,gamma2);
                %                 fprintf('ACC:%f\n',ACC)
                %                 fprintf('nmi: %f\n', MIhat);
                %                 fprintf('purity: %f\n', Purity);
                %                 fprintf('P: %f\n', Pi);
                %                 fprintf('R: %f\n', Ri);
                %                 fprintf('F: %f\n', Fi);
                %                 fprintf('ARI: %f\n', ARi);
                i = i+1;
            end
        end
    end
end

% for v = 1:nv
%     [S(:,:,v),U{v}] = echo_CAN(X{v}, c);
%     [clusternum, ~] = graphconncomp(sparse(S(:,:,v)))
% end
% [ACC, MIhat, Purity,Pi, Ri, Fi,ARi] = Clustering(S,U,c,groundtruth,1,1,1,2);
%     fprintf('ACC:%f\nNMI:%f\n',ACC,MIhat)

