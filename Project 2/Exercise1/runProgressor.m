%Use this program to simulate and run the progressor.m file for many
%iterations.
close all
clear all

b = [5 10 20 30 40];
n =  1000;
A_0 = 100;
T = 100;

Population_t = zeros(size(b,2), T);
figure
subplot(2,2,1);
for i = 1:4

    b_i = b(i);
    %Initialize our vector of sites v
    v = zeros(1, n);
    for j= 1:A_0
        k = randi(n);
        v(k) = v(k) + 1;
        Population_t(i,1) = Population_t(i,1) + 1;
    end
    
    %Iterate through time
    for t = 2:T
        [v, Population_t(i, t)] = progressor(v, b_i);
        v = zeros(1, n);
        for j= 1:Population_t(i,t)
            k = randi(n);
            v(k) = v(k) + 1;
        end
    end
    subplot(2,2,i);
    plot(0:T-1, Population_t(i,:),'LineWidth', 1);
    xlabel('Time iteration', 'FontSize', 16);
    ylabel('Population size', 'Fontsize', 16);
    titl = ['b = ' num2str(b_i)];
    title(titl);
    hold on
end