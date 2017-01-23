function [compressed,N,Nfreqz] = DisplayDCT(x,percent_retained)
%compressed: the final reconstruction using the first N coefs
%N: is the number of coefficients used in reconstruction
%x: original sound with L and R channel
%percent_retained: what percentage off the original signals energy you
%wish to retain
%suppress_output: 0 if you want graphical output, 1 if you want to supress
%output

xl = x(:,1);
xr = x(:,2);

close all
X = dct(xl);
[XX,ind] = sort(abs(X),'descend');
i = 1;
while norm(X(ind(1:i)))/norm(X)<percent_retained
   i = i + 1;
end
Needed = i;

N = Needed;

subplot(1,2,1)
stem(X)



X = dct(xr);
[XX,ind] = sort(abs(X),'descend');
i = 1;
while norm(X(ind(1:i)))/norm(X)<percent_retained
   i = i + 1;
end
Needed = i;

X(ind(Needed+1:end)) = 0;
xx = idct(X);

compressed(:,2) = xx;
N = Needed;

subplot(1,2,2)
plot(X)
