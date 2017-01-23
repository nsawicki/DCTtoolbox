function [output] = windowedDCT(x,winLength,numOverlap,upsample_factor)

[x_length,numChannels] = size(x);

i = 1;
output = zeros(winLength*upsample_factor,1);
col_iter = 1;

while( i + winLength <= x_length)
    
    xtmp = x(i:i+winLength-1);
    
    Xtmp = dct(xtmp,winLength*upsample_factor);
    output(:,col_iter) = Xtmp';
    
    col_iter = col_iter + 1;
   i = i + (winLength - numOverlap) 
end

imagesc((output))
colorbar