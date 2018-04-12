% Three states: resting (0), bored(1) and sharer (2)

function S = NumOfShar(B)
N = 1000;
p = 0.001;
q = 0.01;
Iter = 1000;
TimeSteps= 300;


NumOfSharers = zeros(1, Iter);
NumOfBored = zeros(1, Iter);
NumOfSharersTot = zeros(TimeSteps, Iter);
% %%Mean field equation simulation
% X = 1;  %Sharers
% Y = 998; %Resting
% Z = 1; %Bored
% for t = 1:1:TimeSteps-1
%     t1 = Y(t)*p;
%     t2 = q*X(t)*Y(t)/1000;
%     t3 = q*X(t)*Z(t)/1000;
%     X(t+1) = X(t) + t1 + t2 - t3;
%     Y(t+1) = Y(t)- t1 - t2;
%     Z(t+1) = Z(t) + t3;
% end
% plot(1:1:1000, X, 'r', 'LineWidth', 2);
% hold on 

for j = 1:1:1
    People = zeros(1, N);
    for l = 1:1:B
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
            end
        end
        People = PeopleTemp;
        NumOfSharersTot(t, j) = sum(People==2);
    end
    %%NumOfSharers(j) = sum(People == 2);
    NumOfBored(j) = sum(People == 1);
    S = NumOfSharersTot(end,1);
    %plot(1:1:TimeSteps, NumOfSharersTot(:,j), 'b');

end
end




