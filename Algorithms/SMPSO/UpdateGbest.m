function [Gbest,CrowdDis] = UpdateGbest(Gbest,N)
% Update the global best set

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    Gbest    = Gbest(NDSort(Gbest.objs,1)==1);
    CrowdDis = CrowdingDistance(Gbest.objs);
    [~,rank] = sort(CrowdDis,'descend');
    Gbest    = Gbest(rank(1:min(N,length(Gbest))));
    CrowdDis = CrowdDis(rank(1:min(N,length(Gbest))));
end

function CrowdDis = CrowdingDistance(PopObj)
% Calculate the crowding distance of each solution in the same front

    [N,M]    = size(PopObj);
    
    CrowdDis = zeros(1,N);
    Fmax     = max(PopObj,[],1);
    Fmin     = min(PopObj,[],1);
    for i = 1 : M
        [~,rank] = sortrows(PopObj(:,i));
        CrowdDis(rank(1))   = inf;
        CrowdDis(rank(end)) = inf;
        for j = 2 : N-1
            CrowdDis(rank(j)) = CrowdDis(rank(j))+(PopObj(rank(j+1),i)-PopObj(rank(j-1),i))/(Fmax(i)-Fmin(i));
        end
    end
end