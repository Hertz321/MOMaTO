function [good_gene ] = boundaryPrevent( bad_gene, low , upper)
%BOUNDARYPREVENT Խ�籣������
%   �˴���ʾ��ϸ˵�� 
    bad_gene(bad_gene < low) =low(bad_gene < low);
    bad_gene(bad_gene > upper) = upper(bad_gene > upper);
    good_gene = bad_gene;

end

