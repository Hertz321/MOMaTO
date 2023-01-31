classdef Evolve
    methods(Static)
        function [rnvec1, rnvec2] = LocalEDA(clusterModel , TaskID , cluster_num)
            Current_Task_Mean = clusterModel(TaskID).Nich_mean(cluster_num,:);
            Current_Task_Std = clusterModel(TaskID).Nich_std(cluster_num,:);
            rnvec1 = normrnd(Current_Task_Mean , Current_Task_Std);
            rnvec2 = normrnd(Current_Task_Mean , Current_Task_Std);
            rnvec1(rnvec1 > 1) = 1;
            rnvec1(rnvec1 < 0) = 0;
            rnvec2(rnvec2 > 1) = 1;
            rnvec2(rnvec2 < 0) = 0;
        end
        
        function [rnvec1,rnvec2]=crossover(p1,p2,muc,dim)
            rnvec1=zeros(1,dim);
            rnvec2=zeros(1,dim);
            randlist=rand(1,dim);
            for i=1:dim
                if randlist(i)<=0.5
                    k=(2*randlist(i))^(1/(muc+1));
                else
                    k=(1/(2*(1-randlist(i))))^(1/(muc+1));
                end
                rnvec1(i)=0.5*(((1 + k)*p1(i)) + (1 - k)*p2(i));
                rnvec2(i)=0.5*(((1 - k)*p1(i)) + (1 + k)*p2(i));
                
                if rnvec1(i)<0
                    rnvec1(i)=0;
                elseif rnvec1(i)>1
                    rnvec1(i)=1;
                end
                if rnvec2(i)<0
                    rnvec2(i)=0;
                elseif rnvec2(i)>1
                    rnvec2(i)=1;
                end
            end
        end
        
        function rnvec=mutate(p,mum,dim,prob_mut)
            rnvec=p;
            for i=1:dim
                if rand(1)<prob_mut
                    u=rand(1);
                    if u <= 0.5
                        del=(2*u)^(1/(1+mum)) - 1;
                        rnvec(i)=p(i) + del*(p(i));
                    else
                        del= 1 - (2*(1-u))^(1/(1+mum));
                        rnvec(i)=p(i) + del*(1-p(i));
                    end
                end
            end
        end
        
        function rnvec = originDE(p1,p2,p3)
            k = randperm(length(p1));
            F = 0.6;
            temp = p1 + F.*(p2 - p3);
            for i = 1 : length(p1)
                r = 0.6;
                if rand(1) < r || i == k(1)
                    rnvec(i) = temp(i);
                else
                    rnvec(i) = p1(i);
                end
            end
            rnvec(rnvec>1)=1;
            rnvec(rnvec<0)=0;
        end
        
       
    end
end

