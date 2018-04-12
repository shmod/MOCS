close all
clear all
tic
N = 40;


%Initialize the matrix and randomly set the value to 0 (ready), 1(firing)
%or 2(resting).
Num_firing_it = zeros(100,1000);
Num_firing = 0;
Pread = 0.3;    %Probability of being in firing state
for l = 1:1:100
    l
    B_ar = zeros(N,N);
    B_temp = zeros(N,N);
    for i = 1:1:N
        for j = 1:1:N
            z = randi(10);
            if (z > 7)
                B_ar(i,j) = 1;
            else
                B_ar(i,j) = 0;
            end
        end
    end
    
    %At each timestep, check the neighbours and determine a new state
    %for each state
    for t = 1:1000
        
        for i = 1:1:N
            for j = 1:1:N
                B_temp(i,j) = newState(B_ar, i, j);
            end
        end
        B_ar = B_temp;
        %Calculate the number of firing cells.
        temp = sum(sum(B_ar==1));
        Num_firing_it(l,t) = temp;
        
    end
    
    
end
toc