close all
clear all

N = 100;


%Initialize the matrix and randomly set the value to 0 (ready), 1(firing)
%or 2(resting).

Pread = 0.2;    %Probability of being in firing state

B_ar = zeros(N,N);
B_temp = zeros(N,N);
for i = 1:1:N
    for j = 1:1:N
        z = rand;
        if (z <Pread)
            B_ar(i,j) = 1;
        else
            B_ar(i,j) = 0;
        end
    end
end
imagesc(B_ar);
caxis([0 2]);
colorbar;
title(['\fontsize{16}t = 0']);
%At each timestep, check the neighbours and determine a new state
%for each state
r = 1;

for t = 1:10000
    
    for i = 1:1:N
        for j = 1:1:N
            B_temp(i,j) = newState(B_ar, i, j);
        end
    end
    B_ar = B_temp;
    %if (t == 10 || t == 20 || t == 100 || t == 1000)
    %    k = waitforbuttonpress;
    %    if k == 1
    %        error('Stopped');
    %    end
      
    pause(0.5)
    r = r+1
    
    imagesc(B_ar);
    caxis([0 2]);
    colorbar;
    title(['\fontsize{16}t = ', num2str(t)]);
    
    %end
    
    
end
