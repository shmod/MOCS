%This program calculates and plots the lyaponov exponent
close all
clear all

T = 5000;
b = [10 20 30];
n=1000;
lya = zeros(50,1);
p_t = zeros(50, T);
p_tp = zeros(50, T);
for j = 1:50
    b = j;
    p_t(j,1) = 1000;
    p_tp(j,1) = b*1000*exp(-1000/n)/n*(1-1000/(2*n));
    for t = 1:1:T
        p_t(j,t+1) = p_t(j,t)^2*exp(-p_t(j,t)/n)*b/(2*n);
        p_tp(j,t+1) = b*p_t(j,t)*exp(-p_t(j,t)/n)/n*(1-p_t(j,t)/(2*n));
    end
%      plot(1:1:T-1,abs(abs(diff(p_t(j,:)))), 'LineWidth', 2)
%      xlabel('a_t', 'FontSize', 16);
%      ylabel('|a_{t+1}-a_t|', 'Fontsize', 16);
%      titl = ['b = ' num2str(b)];
%      title(titl);
%      legend('|a_{t+1}-a_t|')
%     pause(4)
%     drawnow 
end
%a = p_t-p_tp;

for k = 1:T-1
        lya = lya + 1/T*log(abs(p_tp(:,k)));
end
plot(1:50, lya)
xlabel('b', 'FontSize', 16);
ylabel('Lyapunov exponent', 'FontSize', 16)
title('The Lyapunov exponent calculated from the mf-eq.')
lgd = legend('b*t*exp(-t/n)/n*(1-t/(2*n))')
lgd.FontSize = 14;