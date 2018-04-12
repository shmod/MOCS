%This program plots the mean field eq.
close all
clear all

T = 6000;
b = [10 20 30];
n=1000;
figure
for j = 1:3
    a_t = zeros(1,T);
    a_t(1) = 1000;
    for t = 1:1:T
        t
        a_t(t) = t^2*exp(-t/n)*b(j)/(2*n);
    end
    subplot(1,3,j);
    plot(1:T,1:T, 'LineWidth', 2)
    hold on
    plot(1:1:T,a_t, 'LineWidth', 2)
    xlabel('a_t', 'FontSize', 16);
    ylabel('a_{t+1}', 'Fontsize', 16);
    titl = ['b = ' num2str(b(j))];
    title(titl);
    legend('a_{t+1} = a_t', 'a_{t+1} = f(a_t)')
end