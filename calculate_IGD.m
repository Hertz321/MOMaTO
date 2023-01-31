function [IGD]=calculate_IGD(data , benchmark_Num)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%���ݲ�ͬ���������IGD��ֵ
%   �˴���ʾ��ϸ˵��
load PF\concave.pf
load PF\convex.pf
load PF\circle.pf
switch benchmark_Num
    case {1,2,3}
        Distance = min(pdist2(circle,data),[],2);
        Distance = Distance .^ 2;
        sum1 = sum(Distance);
        sum1 = sqrt(sum1);
        IGD = sum1 / length(circle);
    case {4,5,6,7}
        Distance = min(pdist2(concave,data),[],2);
         Distance = Distance .^ 2;
        sum1 = sum(Distance);
        sum1 = sqrt(sum1);
        IGD = sum1 / length(concave);
    otherwise
        Distance = min(pdist2(convex,data),[],2);
         Distance = Distance .^ 2;
        sum1 = sum(Distance);
        sum1 = sqrt(sum1);
        IGD = sum1 / length(convex);
end

