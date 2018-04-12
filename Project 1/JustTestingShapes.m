close all
clear all

N = 16;


%Initialize the matrix and randomly set the value to 0 (ready), 1(firing)
%or 2(resting).

Pread = 0.3;    %Probability of being in firing state

B_ar = zeros(N,N);
B_temp = zeros(N,N);
% for i = 1:1:N
%     for j = 1:1:N
%         z = randi(10);
%         if (z > 7)
%             B_ar(i,j) = 1;
%         else
%             B_ar(i,j) = 0;
%         end
%     end
% end
B_ar(7,8) = 1;
B_ar(7,9) = 1;
B_ar(8,8) = 1;
B_ar(8,9) = 1;


B_ar(6,9) = 2;
B_ar(7,7) = 2;
B_ar(8,10) = 2;
B_ar(9,8) = 2;

subplot(2,2,1);
imagesc(B_ar);
title(['\fontsize{16}t = 0']);
caxis([0 2]);
colorbar;
drawnow;
hold on;

%At each timestep, check the neighbours and determine a new state
%for each state
r = 1;
for t = 1:1000
    r = r+1;
    for i = 1:1:N
        for j = 1:1:N
            B_temp(i,j) = newState(B_ar, i, j);
        end
    end
    B_ar = B_temp;
        k = waitforbuttonpress;
        if k == 1
            error('Stopped');
        end
        if (t == 4)
            subplot(2,2, r)
        else
            subplot(2,2,r);
        end
        imagesc(B_ar);
                title(['\fontsize{16}t = ', num2str(t)]);

drawnow;
hold on;
        caxis([0 2]);
        colorbar;

    
    
end
