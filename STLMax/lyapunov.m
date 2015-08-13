%% Calculate the maximum lyapunov coefficient of a time series
%
% lle - The calculated largest lyapunov exponent (aka. LMax)
% x - the full time series.
% dt - the sampling frequency.
function lle = lyapunov(x,dt)

[ndata nvars]=size(x);

N2 = floor(ndata/2);
N4 = floor(ndata/4);
TOL = 1.0e-6;

exponent = zeros(N4+1,1);

% Picking the second quartile of the data should mean it is sufficiently evolved
for i = N4:N2 
   dist = norm(x(i+1,:)-x(i,:));
   indx = i+1;
   for j=1:ndata-5
       if (i ~= j) && norm(x(i,:)-x(j,:))<dist
           dist = norm(x(i,:)-x(j,:));
           indx = j; % closest point!
       end
   end
   % Estimate the local rate of expansion (i.e. largest eigenvalue)
   expn = 0.0;
   for k = 1:5
       if norm(x(i+k,:)-x(indx+k,:))>TOL && norm(x(i,:)-x(indx,:))>TOL
           expn = expn + (log(norm(x(i+k,:)-x(indx+k,:)))-log(norm(x(i,:)-x(indx,:))))/k;
       end
   end
   exponent(i-N4+1)=expn/5;
end

% Now, calculate the overal average over N4 data points
sum=0;
for i=1:N4+1
    sum = sum+exponent(i);
end

% Return the average value
lle = sum/((N4+1)*dt);  
