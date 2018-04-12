close all
clear all

N = 32;


%Initialize the matrix and randomly set the value to 0 (resting), 1(bored)
%or 2(sharer).

B_ar = zeros(N,N);
B_temp = zeros(N,N);

%10 initially bored ones
i = randi(N);
j = randi(N);

for l = 1:1:50
    while (B_ar(i,j) == 1)
        i = randi(N);
        j = randi(N);
    end
    B_ar(i,j) = 1;
end

while(B_ar(i,j) == 1)
    i = randi(N);
    j = randi(N);
end
B_ar(i,j) = 2;
mymap = [0 0 0
   230 25 75
   255 225 25]/255;
imagesc(B_ar);
colormap(mymap);
caxis([0 2]);
colorbar;
title(['\fontsize{16}t = 0']);
B_temp = B_ar;
%At each timestep, check the neighbours and determine a new state
%for each state
r = 1;
figure
k = waitforbuttonpress;
if k == 1
    error('Stopped');
end
for t = 1:1:1000
    for i = 1:1:N
        for j = 1:1:N
            B_temp = newState(B_temp, i, j);
        end
    end
    B_ar = B_temp;
    %if (t == 10 || t == 20 || t == 100 || t == 1000)
    %    k = waitforbuttonpress;
    %    if k == 1
    %        error('Stopped');
    %    end
    pause(0.005)
    r = r+1;
    
    imagesc(B_ar);
    colormap(mymap);
    caxis([0 2]);
    colorbar;
    title(['\fontsize{16}t = ', num2str(t)]);
    drawnow
    %end
    
    
end
