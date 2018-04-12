% Three states: resting (0), bored(1) and sharer (2)

clear all
close all
qv = [0.001/50 0.001/10 0.001 0.001*10 0.001*50 0.001*500]
for w = 1:1:6
N = 1000;
p = qv(w);
Iter = 100;
TimeSteps= 1000;
subplot(2,3,w)
X = zeros(1, TimeSteps);
Y = zeros(1, TimeSteps);
Z = zeros(1, TimeSteps);
q=0.05;

NumOfSharers = zeros(1, Iter);
NumOfBored = zeros(1, Iter);
NumOfSharersTot = zeros(TimeSteps, Iter);
%%Mean field equation simulation
X = 1;  %Sharers
Y = 989; %Resting
Z = 10; %Bored
for t = 1:1:TimeSteps-1
    t1 = Y(t)*p;
    t2 = q*X(t)*Y(t)/1000;
    t3 = q*X(t)*Z(t)/1000;
    t4 = q*Z(t)*Y(t)/1000;
    X(t+1) = X(t) + t1 + t2 - t3;
    Y(t+1) = Y(t)- t1 - t2+t4;
    Z(t+1) = Z(t) + t3-t4;
end
plot(1:1:1000, X, 'r', 'LineWidth', 2);
hold on
People = zeros(100,TimeSteps);
for j = 1:1:Iter
    People = zeros(1, N);
    for l = 1:1:10
        People(l) = 1;
    end

    temp = randi(N);
    while (People(temp) == 1)
        temp = randi(N);
    end
    People(temp) = 2;
    PeopleTemp = People;
    
    for t = 1:1:TimeSteps
        for i = 1:1:N
            if (People(i) == 0)     %resting
                if (p > rand)
                    PeopleTemp(i) = 2;
                end
            elseif (People(i) == 2) %sharer
                if (q > rand)
                    temp = randi(N);
                    while (temp == i)
                        temp = randi(N);
                    end
                    if (People(temp) == 1)
                        PeopleTemp(i) = 1;
                    else
                        PeopleTemp(temp) = 2;
                        PeopleTemp(i) = 2;
                    end
                end
            else
                if(q > rand)
                    temp = randi(N);
                    while (temp ==i)
                        temp = randi(N);
                    end
                    if (People(temp) == 0)
                        PeopleTemp(i) = 0;
                    end
                end
            end
        end
        People = PeopleTemp;
        NumOfSharersTot(t, j) = sum(People==2);
    end
end
    kol = mean(NumOfSharersTot, 2);
    plot(1:1:TimeSteps, kol, 'b', 'LineWidth', 3);
    hold on
    drawnow 


%%Mean field equation simulation
X = 1;  %Sharers
Y = 989; %Resting
Z = 10; %Bored
for t = 1:1:TimeSteps-1
    t1 = Y(t)*p;
    t2 = q*X(t)*Y(t)/1000;
    t3 = q*X(t)*Z(t)/1000;
    t4 = q*Z(t)*Y(t)/1000;
    X(t+1) = X(t) + t1 + t2 - t3;
    Y(t+1) = Y(t)- t1 - t2+t4;
    Z(t+1) = Z(t) + t3-t4;
end

plot(1:1:1000, X, 'r', 'LineWidth', 1);
hold on
titl = ['p = ' num2str(p)];
title(titl, 'FontSize', 16);
xlabel('Timestep', 'FontSize', 16);
ylabel('Number of Sharers', 'FontSize', 16);
%legend('Avg of random simulations', 'Mean field equation sim.');
drawnow
end

%plot(1:1:Iter,NumOfSharers, 'LineWidth', 2);
%xlabel('Iteration', 'FontSize', 16);
%ylabel('Number of Sharers', 'FontSize', 16);