function [good_gene ] = boundaryPrevent( bad_gene, low , upper)
%BOUNDARYPREVENT 越界保护函数
%   此处显示详细说明 
    bad_gene(bad_gene < low) =low(bad_gene < low);
    bad_gene(bad_gene > upper) = upper(bad_gene > upper);
    good_gene = bad_gene;

end

