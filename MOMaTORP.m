function [IGD,population]=MOMaTORP(Tasks,pop,gen,muc,mum,benchMark_num)
global PopCon
PopCon = 0;
fun = 3;
%% initialization
task_num=length(Tasks);
for i=1:task_num
    D(i)=Tasks(i).dim;
end
dim=max(D);
id_num = 1;
sub_pop = pop/task_num;
for i=1:pop
    child(i)=Chromosome;
    population(i)=Chromosome;
    population(i)=initialize(population(i),dim);
    if i>1 && ~mod(i-1 , pop/task_num)
        id_num = id_num + 1;
    end
    population(i).skill_factor=id_num;
    [population(i).obj(1) , population(i).obj(2)] = evaluate(population(i),Tasks(population(i).skill_factor), benchMark_num);
    population(i).obj = [population(i).obj(1) , population(i).obj(2)];
end

%Non dominated sorting
Zmin = [];
for i = 1:task_num
    population_subpop =population([population.skill_factor]==i);
    popobj=vec2mat([population_subpop.obj],2);
    [ front, FrontNO,~] = NDSort(popobj,inf);
    for j = 1:length(population_subpop)
        population_subpop(j).front = FrontNO(j);
    end
    %crowing distance
    [population_subpop,~]=SolutionComparison.diversity(population_subpop,front,length(population_subpop...
        ),length(population_subpop(1).obj));
    population((i-1) * (pop/task_num) +1 : i*(pop/task_num)) = population_subpop;
    Zmin1  = min(popobj(all(PopCon<=0,2),:),[],1); %更新理想点
    Zmin(i,:) = Zmin1;
end
% initPro=0.9;
 for generation=1:gen  
    Rnvec=reshape([population.rnvec] , [dim,pop]);
    difference=inf.*ones(task_num);
    sigma = 1;
    for count1 = 1:task_num
        StartIndex = (count1-1) * sub_pop+1;
        EndIndex = count1*sub_pop;
        for count2=1:task_num
            StartIndex1 = (count2-1) * sub_pop+1;
            EndIndex1 = count2*sub_pop;
            if count1==count2
                continue;
            end
            difference(count1,count2) = mmd(Rnvec(:,StartIndex:EndIndex), Rnvec(:,StartIndex1:EndIndex1), sigma);
        end
    end
    
    [clusterModel , population] = MTKT(population , task_num , difference);
    
    %% Create offspring population
    count=1;
    for i=1:task_num
        for j=1:sub_pop/2
            StartIndex = (i-1) * sub_pop+1;%the index of the first individual of task i in the whole population
            EndIndex = i*sub_pop;%the index of the last individual of task i in the whole population
            if rand(1)< 0.3  %self evolution   amp(i)
                p1=randi([StartIndex , EndIndex] , 1);
                [child(count).rnvec,child(count+1).rnvec]=Evolve.crossover(population(StartIndex+j-1).rnvec,population(p1).rnvec,muc,dim);
                child(count).rnvec = Evolve.mutate(child(count).rnvec,mum,dim,1/dim);
                child(count+1).rnvec = Evolve.mutate(child(count+1).rnvec,mum,dim,1/dim);
            else%knowledge transfer
                [child(count).rnvec, child(count+1).rnvec] = Evolve.LocalEDA(clusterModel , i , population(StartIndex+j-1).cluster_num);
            end
            child(count).skill_factor=i;
            child(count+1).skill_factor=i;
            [child(count).obj(1) , child(count).obj(2)] = evaluate(child(count), Tasks(child(count).skill_factor) , benchMark_num);
            [child(count+1).obj(1) , child(count+1).obj(2)] = evaluate(child(count+1), Tasks(child(count+1).skill_factor) , benchMark_num);
            child(count).obj = [child(count).obj(1) , child(count).obj(2)];
            child(count+1).obj = [child(count+1).obj(1) , child(count+1).obj(2)];
            count=count+2;
        end
        population_childsubpop =child([child.skill_factor]==i);%在第一个任务中的个体   
       for j = 1:length(population_childsubpop)
        childpopobj(j,:) = population_childsubpop(j).obj;
       end
        Zmin(i,:) = min([Zmin(i,:);childpopobj],[],1);%更新理想点
    end
    %% combine Population and Offspring
    population=reset(population,pop);
    intpopulation(1:pop)=population;
    intpopulation(pop+1:2*pop)=child;
    %% Non dominated sorting
    for i = 1:task_num
        [Z,N] = UniformPoint(100,2); 
        population_subpop = intpopulation([intpopulation.skill_factor]==i); 
        popobj=vec2mat([population_subpop.obj],2);
        [FrontNo,MaxFNo] = NDSort3(popobj,PopCon,N);

        population_subpop = EnvironmentalSelection(fun,FrontNo,MaxFNo,popobj,population_subpop,N,Z,Zmin(i,:));
        population((i-1) * (pop/task_num) +1 : i*(pop/task_num)) = population_subpop(1:(pop/task_num));
    end
    
    %% calculate IGD
    for i = 1:task_num
        data = vec2mat([population((i-1) * (pop/task_num) +1 : i*(pop/task_num)).obj],2);
        igd = calculate_IGD(data , benchMark_num);
        if  generation == 1
            IGD(i , generation) = igd;
        elseif igd < IGD(i,generation-1)
            IGD(i , generation) = igd;
        else
            IGD(i , generation) = IGD(i,generation - 1);
        end
    end
    disp(['new_Generation:' , num2str(generation),' IGD:', num2str(IGD(1,generation))]);
end
end