%Use this program to simulate and run the progressor.m file for many
%iterations.
function p = runProgr2(b, n, A_0, T)

Population_t = zeros(1, T);
%Initialize our vector of sites v
v = zeros(1, n);
for j= 1:A_0
    k = randi(n);
    v(k) = v(k) + 1;
    Population_t(1,1) = Population_t(1,1) + 1;
end
 N = size(v, 2);
 
%Iterate through time
for t = 2:T
    x_t = 0;
    for i = 1:1:N
        if (v(i) == 2)
            x_t = x_t + b;
        end
    end
    
    v = zeros(1, n);
    for j= 1:x_t
        k = ceil(rand()*n);
        v(k) = v(k) + 1;
    end
end

p = Population_t(1, end);
end
