function H=rbf_dot(X,Y,deg)
%Author：kailugaji
%高斯核函数/径向基函数 K(x, y)=exp(-d^2/sigma), d=(x-y)^2, 假设X与Y维度一样
%Deg is kernel size,高斯核的sigma
[N_X,~]=size(X);
[N_Y,~]=size(Y);
G = sum((X.*X),2);
H = sum((Y.*Y),2);
Q = repmat(G,1,N_Y(1));
R = repmat(H',N_X(1),1);
H = Q + R - 2*X*Y';
H=exp(-H/2/deg^2);  %N_X*N_Y
end