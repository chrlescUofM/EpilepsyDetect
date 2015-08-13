%% Phase space reconstruction ---- author:"Merve Kizilkaya"
%
%Y - an M x m matrix
%x - time series 
%m - embedding dimension
%tao - time delay
%npoint - total number of reconstructed vectors

function Y=psr_deneme(x,m,tao,npoint)
N=length(x);
if nargin == 4
    M=npoint;
else
    M=N-(m-1)*tao;
end

Y=zeros(M,m); 

for i=1:m
    Y(:,i)=x((1:M)+(i-1)*tao)';
end