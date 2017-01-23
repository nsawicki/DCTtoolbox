function [compressed,N] = compress_dctLR(x,percent_retained,suppress_output)
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

X(ind(Needed+1:end)) = 0;
xx = idct(X);

compressed(:,1) = xx;
N = Needed;

if(suppress_output == 0)
subplot(1,2,1)
plot([xl]');

   hold on
   
   plot([compressed(:,1)]');
legend('Original',['Reconstructed, N = ' int2str(Needed)], ...
       'Location','SouthEast');
   
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

if(suppress_output == 0)
subplot(1,2,2)
plot([xr]');

   hold on
   
   plot([compressed(:,2)]');
legend('Original',['Reconstructed, N = ' int2str(Needed)], ...
       'Location','SouthEast');
   
end


   
   