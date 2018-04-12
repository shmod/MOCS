% In this program the cells can be in four different states;
% null (0), hunter(1), prey(2) and hunter-killer(3).
% A null cell can turn into a prey cell if it has a neighbouring
% prey-cells and no neighbouring hunter cells. It can also turn into a
% hunter cell with a some probability.
% A hunter turn into a hunter-killer if it is neighbours a hunter-killer or
% it can turn into a null cell with some probability.
% A prey turn into a hunter if it is surrounded by hunters and non-null
% cells (nowhere to escape). At any moment a prey can move into a null-cell
% unless with a certain probability p. This probability is reduced as the
% amount of hunter neighbours increase.

%Parameters:
%Probability matrix of Null => prey: [0 5 7.5 10 12.5 15 17.5 20]


function B=newState(A, i, j)
B = (A(i,j));
N = size(A,1);
z = rand;
if (A(i,j) == 0)                  %If null cell
    Null_to_pray = [0 3 6 9 12 16 20 25 30]/100;
    Null_to_hunt = [3 3 3 2 2 2 1 1 1]/1000;
    [amount_of_prey, amount_of_hunter] = count2(A, i, j, 2, 1);
    if ~(amount_of_hunter) && (Null_to_pray(amount_of_prey+1) > z)
        B = 2;
    elseif  (Null_to_hunt(amount_of_hunter+1) > z)
        B = 1;
    end
elseif (A(i,j) == 1)            %If hunter cell
    [amount_of_hk, amount_of_null] = count2(A, i, j, 3, 0);
    Hunt_to_hk = [0.5 0.75 0.8 0.9 0.95 1 1 1];   
    if (amount_of_hk && Hunt_to_hk(amount_of_hk) > z)
        B = 3;
    elseif (z < 0.001)
        B = 0;
    elseif (amount_of_null >= 6 && z < 0.10)
        B = 0;
    end
elseif (A(i,j) == 2)            %Prey cell
    [amount_of_hunter, amount_of_null] = count2(A, i, j, 1, 0);
    amount_of_prey = count(A, i, j, 2);
    perc_of_null = amount_of_null/8;
    Prey_to_hunter = [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]*(1-perc_of_null);   
    if (amount_of_hunter) && (Prey_to_hunter(amount_of_hunter)>z)
        B = 1;
    elseif (amount_of_hunter) && (0.02>z)
        B = 3;
    elseif (amount_of_prey == 8) && (z < 0.02)
        %B = 1;
    elseif (z <0.03 && amount_of_prey > 5 && amount_of_hunter == 0)
        B = 0;
    end
elseif (A(i,j) == 3)
    [amount_of_hk, amount_of_prey] = count2(A, i, j, 3, 2);
    amount_of_hunter = count(A, i, j, 1);
    if ((amount_of_hk + amount_of_prey) == 8) && z<0.3     %If completely surrounded by "friendly" cells
        B = 2;
    elseif (z<0.02 && ~(amount_of_hunter))  %Defence deteriorating
        %B = 2;
    end
end
    
    
    
    
    
    
    
    
    
    
    