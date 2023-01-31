classdef SolutionComparison
    methods (Static)
        function [population,frontnumbers]=nondominatedsort(population,pop,no_of_objs)
            
            count=0;
            frontnumbers=[];
            for i=1:pop   %这个循环的作用是找到非支配层为rank1的层
                for j=i:pop
                    if i==j
                        continue;
                    end
                    better=0;
                    worse=0;
                    if population(i).convio < population(j).convio
                        population(i).dominatedset=[population(i).dominatedset j];
                        population(i).dominatedsetlength=population(i).dominatedsetlength+1;
                        population(j).dominationcount=population(j).dominationcount+1;
                    elseif population(i).convio > population(j).convio
                        population(j).dominatedset=[population(j).dominatedset i];
                        population(j).dominatedsetlength=population(j).dominatedsetlength+1;
                        population(i).dominationcount=population(i).dominationcount+1;
                    else
                        for k = 1:no_of_objs%no_of_objs  =2  1:代表目标函数1  2：代表目标函数2
        
                                
                                if population(i).obj(k) < population(j).obj(k)
                                    better=1;
                                elseif population(i).obj(k) > population(j).obj(k)
                                    worse=1;
                                end

                        end
                        %得到了每一个个体的支配集和被支配集
                        if worse==0 && better>0%说明i支配j
                            population(i).dominatedset=[population(i).dominatedset j];
                            population(i).dominatedsetlength=population(i).dominatedsetlength+1;
                            population(j).dominationcount=population(j).dominationcount+1;
                        elseif better==0 && worse>0 %说明j支配i
                            population(i).dominationcount=population(i).dominationcount+1;
                            population(j).dominatedset=[population(j).dominatedset i];
                            population(j).dominatedsetlength=population(j).dominatedsetlength+1;
                        end
                    end
                    
                end
                if population(i).dominationcount==0  %说明没有其他的解能支配它，它便是最好的
                    population(i).front=1;%front为1的就是非支配解
                    
                    count=count+1;  %count记录了非支配解的个数
                end
            end
            frontnumbers=[frontnumbers,count];%每层的个体数
            front=0;
            
            
            
            
            
            while count>0
                count=0;
                front=front+1;
                for i=1:pop
                    if population(i).front==front
                        for j=1:population(i).dominatedsetlength
                            ind=population(i).dominatedset(j);%把高层rank里的解的每一个
                            %支配个体的的被支配数减1
                            population(ind).dominationcount=population(ind).dominationcount-1;
                            if population(ind).dominationcount==0
                                population(ind).front=front+1;
                                count=count+1;
                            end
                        end
                    end
                end
                frontnumbers=[frontnumbers,count];
            end
        end
        
        function [population,minimums]=diversity(population,frontnumbers,pop,no_of_objs)
             for i=1:pop
                population(i).CD = 0;
            end
            [xx,y]=sort([population.front]);
            population=population(y);%这里的处理方法可以学习一下
            currentind=0;
            for i=1:population(pop).front%从第一个非支配层开始
                %frontnumbers 存储的是每一层的个体数
                %subpopulation :把一层的个体存下来+
                subpopulation = [];
                subpopulation=population(currentind+1:currentind+frontnumbers(i));
                
                minima=zeros(1,no_of_objs);
                x=zeros(1,frontnumbers(i));
                for j = 1:no_of_objs
                    for k = 1:frontnumbers(i)
                         x(k)=subpopulation(k).obj(j);
                    end
                    
                    [xx,y] = sort(x);%对某一层的进行排序
                    x=x(y);
                    subpopulation=subpopulation(y);
                        minima(j)=subpopulation(1).obj(j);%该层的最小值
                        max=subpopulation(frontnumbers(i)).obj(j);%该层的最大值

                    
                    subpopulation(1).CD=inf;
                    subpopulation(frontnumbers(i)).CD=inf;
                    normobj=(x-minima(j))./(max-minima(j));
                    for k = 2:frontnumbers(i)-1
                        subpopulation(k).CD = subpopulation(k).CD + (normobj(k+1)-normobj(k-1));
                    end
                end
                if i == 1
                    minimums=minima;
                end
                %
                [xx,y]=sort(-[subpopulation.CD]);
                subpopulation=subpopulation(y);
                population(currentind+1:currentind+frontnumbers(i))=subpopulation;
                currentind=currentind+frontnumbers(i);
            end
            for i = 1: pop
                population(i).rank=i;
            end
        end
        
    end
end