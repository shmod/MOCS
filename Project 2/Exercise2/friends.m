% This program simulates the dynamics between groups of friends
% and creates a world with N people and G groups at each timestep.
clear all

N = 100;
G = 1:N;
T = 100;
r = 0.01;      %Probability of splitting a group
size_of_groups = zeros(N, T+1);
size_of_groups(:, 1) = ones(N,1);
msums = zeros(1,10);
for t = 1:1:T
    % Choose a random person k will be this person
    % G(k) will be the group that she belongs too and size_of_group(G(K))
    % will be the size of the group that this person belongs to.
    
    k = ceil(rand()*N);
    nK = sum(G == G(k));    % Number of persons in the same group
    size_of_groups(:, t+1) = size_of_groups(:, t);
    if (nK == 1) % If this person is a loner
        
        % Put this person in a new group
        new_k = ceil(rand()*N);
        size_of_groups(G(new_k), t+1) = size_of_groups(G(new_k), t+1) + 1;
        size_of_groups(G(k), t+1) = size_of_groups(G(k), t+1) - 1;
        G(k) = G(new_k);
        
    elseif (nK*r > rand()) 
        size_of_groups(G(k), t+1) = 1;
        indexes_of_former_friends = find(G == G(k));
        for (l = 1:1:nK-1)
            j = 1;
            while(size_of_groups(j, t) ~= 0)
                j = j + 1;
            end
            size_of_groups(j,t+1) = size_of_groups(j, t+1) + 1;
            G(indexes_of_former_friends(l)) = j;
        end
    end
    msums(1,t) = sum(size_of_groups(:,t));
    
    if ( msums(1,t) ~= N)
        error('Wrong!')
        return;
    end
end

histS(count,:)=hist(finalS(count,:),hrange);
