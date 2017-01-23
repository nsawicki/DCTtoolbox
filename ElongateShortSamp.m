function [output,N] = ElongateShortSamp(x,percent_retained,scale)
%compressed: the final reconstruction using the first N coefs
%N: is the number of coefficients used in reconstruction
%x: original sound with L and R channel
%percent_retained: what percentage off the original signals energy you
%wish to retain
%suppress_output: 0 if you want graphical output, 1 if you want to supress
%output

xl = x(:,1);
xr = x(:,2);
t = 0:1./44100:1./44100*(length(x)-1);
n = 1:length(x).*scale;

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
plot(X)
tmp = length(X);
freqzL(:,1) = (ind(1:N)'./(2*tmp)).*44100;
freqzL(:,2) = X(ind(1:N))';
    
output(:,1) = zeros(length(t).*scale,1);
for i = 1:size(freqzL,1)
    Xtmp = X;
    Xtmp(1:length(x) ~= ind(i)) = 0;
    output(:,1)  = output(:,1)  + (sqrt(2./length(x))).*(freqzL(i,2).*cos(pi*(2*n-1).*(ind(i)-1)./(2*length(x)))');
    tmp =  idct(Xtmp);
end

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

tmp = length(X);
freqzR(:,1) = (ind(1:N)'./(2*tmp)).*44100;
freqzR(:,2) = X(ind(1:N))';



output(:,2) = zeros(length(t).*scale,1);
for i= 1:size(freqzR,1)
    Xtmp = X;
    Xtmp(1:length(x) ~= ind(i)) = 0;
    output(:,2)  = output(:,2)  + (sqrt(2./length(x))).*(freqzR(i,2).*cos(pi*(2*n-1).*(ind(i)-1)./(2*length(x)))');
end
   

figure()
subplot(1,2,1)
plot(x)

subplot(1,2,2)
plot(output);
axis([0 length(x(:,1)) min(x(:)) max(x(:))]);
   