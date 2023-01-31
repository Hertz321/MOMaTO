classdef SolutionComparison
    methods (Static)
        function [population,frontnumbers]=nondominatedsort(population,pop,no_of_objs)
            
            count=0;
            frontnumbers=[];
            for i=1:pop   %���ѭ�����������ҵ���֧���Ϊrank1�Ĳ�
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
                        for k = 1:no_of_objs%no_of_objs  =2  1:����Ŀ�꺯��1  2������Ŀ�꺯��2
        
                                
                                if population(i).obj(k) < population(j).obj(k)
                                    better=1;
                                elseif population(i).obj(k) > population(j).obj(k)
                                    worse=1;
                                end

                        end
                        %�õ���ÿһ�������֧�伯�ͱ�֧�伯
                        if worse==0 && better>0%˵��i֧��j
                            population(i).dominatedset=[population(i).dominatedset j];
                            population(i).dominatedsetlength=population(i).dominatedsetlength+1;
                            population(j).dominationcount=population(j).dominationcount+1;
                        elseif better==0 && worse>0 %˵��j֧��i
                            population(i).dominationcount=population(i).dominationcount+1;
                            population(j).dominatedset=[population(j).dominatedset i];
                            population(j).dominatedsetlength=population(j).dominatedsetlength+1;
                        end
                    end
                    
                end
                if population(i).dominationcount==0  %˵��û�������Ľ���֧��������������õ�
                    population(i).front=1;%frontΪ1�ľ��Ƿ�֧���
                    
                    count=count+1;  %count��¼�˷�֧���ĸ���
                end
            end
            frontnumbers=[frontnumbers,count];%ÿ��ĸ�����
            front=0;
            
            
            
            
            
            while count>0
                count=0;
                front=front+1;
                for i=1:pop
                    if population(i).front==front
                        for j=1:population(i).dominatedsetlength
                            ind=population(i).dominatedset(j);%�Ѹ߲�rank��Ľ��ÿһ��
                            %֧�����ĵı�֧������1
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
            population=population(y);%����Ĵ���������ѧϰһ��
            currentind=0;
            for i=1:population(pop).front%�ӵ�һ����֧��㿪ʼ
                %frontnumbers �洢����ÿһ��ĸ�����
                %subpopulation :��һ��ĸ��������+
                subpopulation = [];
                subpopulation=population(currentind+1:currentind+frontnumbers(i));
                
                minima=zeros(1,no_of_objs);
                x=zeros(1,frontnumbers(i));
                for j = 1:no_of_objs
                    for k = 1:frontnumbers(i)
                         x(k)=subpopulation(k).obj(j);
                    end
                    
                    [xx,y] = sort(x);%��ĳһ��Ľ�������
                    x=x(y);
                    subpopulation=subpopulation(y);
                        minima(j)=subpopulation(1).obj(j);%�ò����Сֵ
                        max=subpopulation(frontnumbers(i)).obj(j);%�ò�����ֵ

                    
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