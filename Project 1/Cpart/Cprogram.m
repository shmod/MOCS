% In this program the cells can be in four different states;
% null (0), hunter(1), prey(2) and hunter-killer(3).
% A null cell can turn into a null cell if it has two or more neighbouring
% prey-cells.
% A hunter turn into a hunter-killer if it is neighbours a hunter-killer.
% A prey turn into a hunter if it is surrounded by hunters and non-null
% cells (nowhere to escape). At any moment a prey can move into a null-cell
% unless with a certain probability p. This probability is reduced as the
% amount of hunter neighbours increase.

function y = Cprogram(inp)
close all
N = 100;


%Initialize the matrix and randomly set the value to 0(60%), 1(5%), 2(30%) or 3(5%).

Pread = 0.3;    %Probability of being in firing state

B_ar = zeros(N,N);
B_temp = zeros(N,N);

if strcmpi(inp, 'foundation')
    %B_ar(:,50) = 2;
    B_ar(50,:) = 2;
    B_ar(51,:) = 3;
elseif strcmpi(inp, 'seeds')
    for i = 1:1:5
        for j = 1:1:5
            B_ar(10+i,10+j) = 2;
            B_ar(40+i,40+j) = 2;
        end
    end
    B_ar(13,13) = 3;
    B_ar(43,43) = 3;
    
elseif strcmpi(inp, 'bucket')
    for i = 1:1:25
        B_ar(40+i,40) = 3;
        B_ar(40+i,60) = 3;
    end
    for l = 1:1:20
        B_ar(65, 40+l) = 3;
    end
    for l = 1:1:10
        for i = 1:1:19
            B_ar(54+l, 40+i) = 2;
        end
        
    end
elseif strcmpi(inp, 'square')
    for i = 1:1:40
        B_ar(30+i,30) = 3;
        B_ar(30+i,70) = 3;
    end
    for l = 1:1:40
        B_ar(31, 30+l) = 3;
        B_ar(70, 30+l) = 3;
    end
    for l = 1:1:10
        for i = 1:1:19
            B_ar(54+l, 40+i) = 2;
        end
        
    end
    
else
    for i = 1:1:N
        for j = 1:1:N
            z = rand;
            if (z < 0.90)
                B_ar(i,j) = 0;
            elseif (z < 0.975)
                B_ar(i,j) = 2;
            elseif (z < 0.995)
                B_ar(i,j) = 1;
            else
                B_ar(i,j) = 3;
            end
        end
    end
end
mymap = [0 0 0
    230 25 75
    255 225 25
    60 180 75]/255;

imagesc(B_ar);
colormap(mymap);
caxis([0 3]);
colorbar;
title(['\fontsize{16}t = 0']);
figure
%At each timestep, check the neighbours and determine a new state
%for each state
r = 1;
        k = waitforbuttonpress;
        if k == 1
            error('Stopped');
        end

for t = 1:1000
    t
    for i = 1:1:N
        for j = 1:1:N
            B_temp(i,j) = newStateC(B_ar, i, j);
        end
    end
    B_ar = B_temp;
%     if (t == 90 || t == 200 || t == 400 || t == 600)
%         k = waitforbuttonpress;
%         if k == 1
%             error('Stopped');
%         end
%         subplot(2,2,r);
        
        r = r+1
        imagesc(B_ar);
        colormap(mymap);
        caxis([0 3]);
        colorbar;
        title(['\fontsize{16}t = ', num2str(t)]);
        drawnow
        pause(0.004)
% end
    
    
end
end