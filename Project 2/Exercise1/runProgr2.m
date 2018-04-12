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

%Iterate through time
for t = 2:T
    [v, Population_t(1, t)] = progressor(v, b);
    v = zeros(1, n);
    for j= 1:Population_t(1,t)
        k = randi(n);
        v(k) = v(k) + 1;
    end
end
p = Population_t(1, end);
end
