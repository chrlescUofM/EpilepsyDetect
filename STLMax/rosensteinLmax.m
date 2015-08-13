%% A function that uses the Rosenstein formulation to calculate maximum lyapunov exponents.
%
% lle - the largest lyapunov exponent (aka. LMax)
% x - signal
% m - embedding dimension
% tao - time delay
% Fs - sampling frequency.
function [lle] = rosensteinLmax(x,m,tao,maxiter,Fs) 

N = length(x);
M = N-(m-1)*tao;
Y = psr_deneme(x,m,tao);

% Calculate the mean period of the signal spectrum
% This tells us the minimum distance between divergent trajectories.
xf = fft(x);
xf = xf(round(N/2):end);
f = 0:Fs/N:Fs/2;
weight = abs(xf).*f;
avgF = sum(weight)/sum(abs(xf));
avgPeriod = 1/avgF;
meanperiod = ceil(avgPeriod*Fs);

% Simple nearest neighbor calculation.
for i=1:M
    x0=ones(M,1)*Y(i,:);
    distance=sqrt(sum((Y-x0).^2,2));
    for j=1:M
        if abs(j-i)<=meanperiod
            distance(j)=1e10;
        end
    end
    [neardis(i) nearpos(i)]=min(distance);
end

% Limit the number of iterations allowed.
for k=1:maxiter
    maxind=M-k;
    evolve=0;
    pnt=0;
    % Calculate for each dimension in the time delayed embedded state series.
    for j=1:M
        if j<=maxind && nearpos(j)<=maxind
            dist_k=sqrt(sum((Y(j+k,:)-Y(nearpos(j)+k,:)).^2,2));
             if dist_k~=0
                evolve=evolve+log(dist_k);
                pnt=pnt+1;
             end
        end
    end
    if pnt > 0
        d(k)=evolve/pnt;
    else
        d(k)=0;
    end
    
end

%% LLE Calculation
tlinear=1:30;
F = polyfit(tlinear,d(tlinear),1);
lle = F(1)*Fs


