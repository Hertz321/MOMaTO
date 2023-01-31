function [Tasks] = benchmark( benchMark_num )
%GETTASK 此处显示有关此函数的摘要
%   此处显示详细说明
task_num=50;
switch benchMark_num
    case 1
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMDTLZ';
            Tasks(i).Gfunction = 'Sphere';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).dim=dim;
            Low = -100 .* ones(1 , 49);
            Upper = 100 .* ones(1 , 49);
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 2
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMDTLZ';
            Tasks(i).Gfunction = 'Rastrigin';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).dim=dim;
            Low = -50 .* ones(1 , 49);
            Upper = 50 .* ones(1 , 49);
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 3
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMDTLZ';
            Tasks(i).Gfunction = 'Griewank';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).dim=dim;
            Low = -100 .* ones(1 , 49);
            Upper = 100 .* ones(1 , 49);
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 4
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,3)==1
                Tasks(i).Gfunction = 'Sphere';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            elseif  mod(i,3)==2
                Tasks(i).Gfunction = 'Rosenbrock';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Ackley';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'concave';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 5
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,3)==1
                Tasks(i).Gfunction = 'Rastrigin';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,3)==2
                Tasks(i).Gfunction = 'Griewank';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Weierstrass';
                Low = -0.5 .* ones(1 , 49);
                Upper = 0.5 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'concave';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 6
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,3)==1
                Tasks(i).Gfunction = 'Rosenbrock';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,3)==2
                Tasks(i).Gfunction = 'Griewank';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Weierstrass';
                Low = -0.5 .* ones(1 , 49);
                Upper = 0.5 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'concave';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 7
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,3)==1
                Tasks(i).Gfunction = 'Sphere';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            elseif  mod(i,3)==2
                Tasks(i).Gfunction = 'Ackley';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Rastrigin';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'concave';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 8
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,5)==1
                Tasks(i).Gfunction = 'Sphere';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            elseif  mod(i,5)==2
                Tasks(i).Gfunction = 'Rosenbrock';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,5)==3
                Tasks(i).Gfunction = 'Ackley';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,5)==4
                Tasks(i).Gfunction = 'Rastrigin';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Weierstrass';
                Low = -0.5 .* ones(1 , 49);
                Upper = 0.5 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'convex';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 9
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,5)==1
                Tasks(i).Gfunction = 'Rosenbrock';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,5)==2
                Tasks(i).Gfunction = 'Ackley';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,5)==3
                Tasks(i).Gfunction = 'Rastrigin';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,5)==4
                Tasks(i).Gfunction = 'Griewank';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Weierstrass';
                Low = -0.5 .* ones(1 , 49);
                Upper = 0.5 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'convex';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
    case 10
        dim=50;
        for i = 1 : task_num
            file_dir = strcat(".\MData\benchmark_", string(benchMark_num));
            shift_file = strcat("\bias_", string(i));
            rotation_file = strcat("\matrix_", string(i));
            Tasks(i).matrix = load(strcat(file_dir, rotation_file));
            Tasks(i).shift = load(strcat(file_dir, shift_file));
            Tasks(i).type='MMZDT';
            Tasks(i).dim=dim;
            Tasks(i).F1Function='linear';
            if mod(i,6)==1
                Tasks(i).Gfunction = 'Sphere';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            elseif  mod(i,6)==2
                Tasks(i).Gfunction = 'Rosenbrock';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,6)==3
                Tasks(i).Gfunction = 'Ackley';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,6)==4
                Tasks(i).Gfunction = 'Rastrigin';
                Low = -50 .* ones(1 , 49);
                Upper = 50 .* ones(1 , 49);
            elseif  mod(i,6)==5
                Tasks(i).Gfunction = 'Griewank';
                Low = -100 .* ones(1 , 49);
                Upper = 100 .* ones(1 , 49);
            else
                Tasks(i).Gfunction = 'Weierstrass';
                Low = -0.5 .* ones(1 , 49);
                Upper = 0.5 .* ones(1 , 49);
            end
            Tasks(i).Hfunction = 'convex';
            Tasks(i).boundaryCvDv = 1;
            Tasks(i).Low = [0 , Low];
            Tasks(i).Upper = [1 , Upper];
        end
end
end

