function [Population] = EnvironmentalSelection(fun,FrontNo,MaxFNo,Population_objs,Population,N,Z,Zmin)

% The environmental selection of NSGA-III

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    if isempty(Zmin)
        Zmin = ones(1,size(Z,2));
    end
    %% Non-dominated sorting
    Next = FrontNo < MaxFNo;
    
    %% Select the solutions in the last front
    Last   = find(FrontNo==MaxFNo);
    switch fun
        case 3
%             [Z,test] = UniformPoint(N-sum(Next),size(Population_objs,2)); 
            Choose = LastSelection(Population_objs(Next,:),Population_objs(Last,:),N-sum(Next),Z,Zmin);
            Next(Last(Choose)) = true;
            Population = Population(Next);
        case 2
            Choose = LastSelection2(Population(Last,:),Population_objs(Last,:),N-sum(Next));
            Population = [Population(Next,:);Choose];
%             a=0;b=0;
%             test = 0;
    end
%     Choose = LastSelection(Population_objs(Next,:),Population_objs(Last,:),N-sum(Next),Z,Zmin);
    
end

function Choose = LastSelection(PopObj1,PopObj2,K,Z,Zmin)
% Select part of the solutions in the last front

    PopObj = [PopObj1;PopObj2] - repmat(Zmin,size(PopObj1,1)+size(PopObj2,1),1);
    [N,M]  = size(PopObj);
    N1     = size(PopObj1,1);
    N2     = size(PopObj2,1);
    NZ     = size(Z,1);

    %% Normalization
    % Detect the extreme points检测极值点
    Extreme = zeros(1,M);
    w       = zeros(M)+1e-6+eye(M);
    for i = 1 : M
        [~,Extreme(i)] = min(max(PopObj./repmat(w(i,:),N,1),[],2));
    end
    % Calculate the intercepts of the hyperplane constructed by the extreme
    % points and the axes  计算由极值点和坐标轴构成的超平面的截距
    Hyperplane = PopObj(Extreme,:)\ones(M,1);
    a = 1./Hyperplane;
    if any(isnan(a))
        a = max(PopObj,[],1)';
    end
    % Normalization
    a = a-Zmin';
    PopObj = PopObj./repmat(a',N,1);
    
    %% Associate each solution with one reference point将每个解决方案与一个参考点关联起来
    % Calculate the distance of each solution to each reference vector
    Cosine   = 1 - pdist2(PopObj,Z,'cosine');
    Distance = repmat(sqrt(sum(PopObj.^2,2)),1,NZ).*sqrt(1-Cosine.^2);
    %Distance = pdist2(PopObj,Z,'euclidean');%上面注释的两个语句也可以哦
    % Associate each solution with its nearest reference point
    [d,pi] = min(Distance',[],1);

    %% Calculate the number of associated solutions except for the last front of each reference point
    rho = hist(pi(1:N1),1:NZ);%除了最后front的每一个参考点，计算关联解的个数
    
    %% Environmental selection
    Choose  = false(1,N2);
    Zchoose = true(1,NZ);
    % Select K solutions one by one
    while sum(Choose) < K
        % Select the least crowded reference point
        Temp = find(Zchoose);
        Jmin = find(rho(Temp)==min(rho(Temp)));
        j    = Temp(Jmin(randi(length(Jmin))));
        I    = find(Choose==0 & pi(N1+1:end)==j);
        % Then select one solution associated with this reference point
        if ~isempty(I)
            if rho(j) == 0
                [~,s] = min(d(N1+I));
            else
                s = randi(length(I));
            end
            Choose(I(s)) = true;
            rho(j) = rho(j) + 1;
        else
            Zchoose(j) = false;
        end
    end
end

function pop_Choose = LastSelection2(pop,obj,K)
    if size(pop,1) > 1
        dis = pdist2(obj,obj);
        Sort = sort(dis,2);
        if K > 2
            crowding_dis = mean(Sort(:,2:3),2);
        else
            crowding_dis = mean(Sort(:,1:2),2);
        end
        crowing_sort = sort(crowding_dis,'descend');
        Choose = crowding_dis>=crowing_sort(K);
        pos = find(Choose==1);
        pop_Choose = pop(pos(1:K),:);
        a=1;
%         if sum(Choose) > K
%             pos = find(crowding_dis==crowing_sort(K));
%             Choose(pos(1:end-1)) = false;
%         end
%         pop_Choose = pop(Choose,:);
    else
        pop_Choose = pop;
    end
end