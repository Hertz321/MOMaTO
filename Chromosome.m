classdef Chromosome
    
    properties
        rnvec;
        obj;
        convio;
        skill_factor;
        front;%属于第几层
        CD;
        rank;%表示是第几个个体
        dominationcount=0;
        dominatedset=[];
        dominatedsetlength=0;
        improvedFromOtherTask;
        cluster_num;
    end
    
    methods
        
        function object=initialize(object,dim)
            object.rnvec=(rand(1,dim));
        end
        
        function Gfunction = evalGfunction(Task , x)
            Xcov=x.rnvec(Task.boundaryCvDv+1:end);
            % obj :任务实例   xCov：个体在统一空间中的值，在该函数中需要decode
            decodeXcov = (Task.Upper(Task.boundaryCvDv + 1:end) - Task.Low(Task.boundaryCvDv + 1:end)) ...
                .* Xcov + Task.Low(Task.boundaryCvDv + 1:end);
            %先从元胞数组中提取出来相应的矩阵和向量 , ID存储于obj中
%             shift = shift{obj.ID};
%             rotationMatrix = matrix{obj.ID};

            %个体转换
            decodeXcov = decodeXcov - Task.shift;
            decodeXcov = decodeXcov * Task.matrix;
          [good_gene] = boundaryPrevent(decodeXcov, Task.Low(Task.boundaryCvDv + 1:end) , ...
                Task.Upper(Task.boundaryCvDv + 1:end));
            switch Task.Gfunction
                case 'Sphere'
                    Gfunction = sum(decodeXcov .^ 2);
                case 'Rosenbrock'
                    t = 0;
                    for i = 1:length(decodeXcov)-1
                        t = t +  100 * (decodeXcov(i)^2 - decodeXcov(i + 1))^2  + (1 - decodeXcov(i)^2);
                    end
                    Gfunction = t;
                case 'Ackley'
                    sum1 = sum(decodeXcov .^ 2) / length(decodeXcov);
                    sum2 = sum(cos(2 * pi .* decodeXcov) ./ length(decodeXcov));
                    Gfunction = -20 * exp(-0.2 * sqrt(sum1)) - exp(sum2) + 20 +exp(1);
                case 'Griewank'
                    t = sqrt([1:length(decodeXcov)]);
                    sum1 = sum(decodeXcov .^ 2);
                    prod1 = prod(cos(decodeXcov ./ t));
                    Gfunction = 1+ sum1 / 4000 - prod1;
                case 'Rastrigin'
                    a = 10 * length(decodeXcov);
                    Gfunction = sum(decodeXcov .^ 2 - 10 .* cos(2 * pi .* decodeXcov)) + a;
                case 'Mean'
                   a = abs(decodeXcov);
                   Gfunction = sum(a) / length(decodeXcov);
                    Gfunction = 9 * Gfunction;
                case 'Weierstrass'
                    a = 0.5;
                    b = 3;
                    kmax = 20;
                    Gfunction=0;
                    D=length(decodeXcov);
                    for i = 1:D
                        for k = 0:kmax
                            Gfunction = Gfunction + a^k*cos(2*pi*b^k*(decodeXcov(i)+0.5));
                        end
                    end
                    for k = 0:kmax
                        Gfunction = Gfunction - D*a^k*cos(2*pi*b^k*0.5);
                    end
            end
        end
        
        %-------------------对多样性变量的处理函数-------------------------
        function F1Function = evalF1(Task , x)
            
            Xdiv=x.rnvec(1:Task.boundaryCvDv);
            decodeXdiv = (Task.Upper(1:Task.boundaryCvDv) - Task.Low(1:Task.boundaryCvDv)) ...
                .* Xdiv + Task.Low(1:Task.boundaryCvDv);
            
            if strcmp(Task.F1Function , 'linear')
                A = sum(decodeXdiv);
                F1Function = A / length(decodeXdiv);
            else
                A = sum(decodeXdiv .^ 2);
                F1Function = sqrt(sum(A));
            end
        end
        
        %------------------Hfunction------------------------------
        function Hfunction = evalH(Task , F1Function , Gfunction)
            if strcmp(Task.Hfunction, 'convex')
                Hfunction = 1 - sqrt((F1Function / Gfunction));
            else
                Hfunction = 1 - (F1Function / Gfunction) ^ 2;
            end
        end

        function [f1 , f2] = evaluate(object, Task, benchMark_num)
            x=object.rnvec;
            switch benchMark_num
                case {1,2,3}                
                    g = evalGfunction(Task, object);
                    f1 = (1+ g) * cos(x(1) * 0.5 * pi);
                    f2 = (1 + g) * sin(x(1) * 0.5 * pi);
                otherwise
                    f1 =  evalF1(Task,object);
                    g =  evalGfunction(Task, object);
                    g = g+1;
                    if strcmp(Task.Hfunction, 'convex')
                        f2 = g*(1 - sqrt((f1 / g)));
                    else
                        f2 = g*(1 - (f1 / g) ^ 2);
                    end
            end
        end
        
        function population=reset(population,pop)
            for i=1:pop
                population(i).dominationcount=0;
                population(i).dominatedset=[];
                population(i).dominatedsetlength=0;
            end
        end
    end
    
end

