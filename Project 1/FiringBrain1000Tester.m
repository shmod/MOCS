close all
clear all

N = 20;


%Initialize the matrix and randomly set the value to 0 (ready), 1(firing)
%or 2(resting).

Pread = 0.3;    %Probability of being in firing state

B_ar = zeros(N,N);
B_temp = zeros(N,N);
% for i = 1:1:N
%     if (mod(i,3) == 0)
%         B_ar(i,:) = ones(1,N);
%     elseif (mod(i,3) == 1)
%         B_ar(i,:) = ones(1,N)*2;
%     end
% end
B_ar(7,10) = 1;
B_ar(8,8) = 1;
B_ar(9,9) = 1;
B_ar(9,11) = 1;
B_ar(10,7) = 1;
B_ar(11,9) = 1;

B_ar(8,9) = 2;
B_ar(8,11) = 2;
B_ar(9,8) = 2;
B_ar(10,10) = 2;
B_ar(11,8) = 2;

subplot(3,3,1);
imagesc(B_ar);
caxis([0 2]);
colorbar;
title(['\fontsize{16}t = 0']);
drawnow;
hold on;
figure
%At each timestep, check the neighbours and determine a new state
%for each states
r = 2
for t = 1:1
    
    for i = 1:1:N
        for j = 1:1:N
            B_temp(i,j) = newState(B_ar, i, j);
        end
    end
    B_ar = B_temp;

        imagesc(B_ar);
        caxis([0 2]);
        colorbar;
        subplot(3,3,r)
        r = r+1
        imagesc(B_ar);
                title(['\fontsize{16}t = ', num2str(t)]);
drawnow;
hold on;

        caxis([0 2]);
        colorbar;

    
    
end
