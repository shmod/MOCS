%Use this program to simulate and run the progressor.m file for many
%iterations. This variant of the code runs simulations for a lot of
%parameters and plots the phase transition grpah.
close all
clear all

b = 1:1:50;
n =  1000;
A_0 = 100;
T = 100;

Population_t = zeros(size(b,2), T);
figure
 for i = 1:size(b,2)

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
    plot(1:T, Population_t(i,:));
    xlabel('Time iteration', 'FontSize', 16);
    ylabel('Time iteration', 'Fontsize', 16);
    hold on
end
