%This function takes an input a vector of size V where V is the amount
%of resource sites and the input at v(i) is the amount of people situated
%at this site at the current timestep. It also takes as input b which is
%the amount of persons who will occupy v(i) at the next timestep if there 
%are exactly two persons at v(i). The functio then returns r, which is the
%new vector and x_t which is the amount of people in our system.

function [v, x_t] = progressor(v, b)
N = size(v, 2);
x_t = 0;
for i = 1:1:N
    if (v(i) == 2)
        v(i) = b;
        x_t = x_t + b;
    else
        v(i) = 0;
    end
end

end

