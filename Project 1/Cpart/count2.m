function [r,t]=count2(A, i, j, state1,state2)
r = 0;
t = 0;
N = size(A,1);


if (j == 1)
    left = N;
    right = 2;
elseif (j == N)
    left = N-1;
    right = 1;
else
    left = j-1;
    right = j+1;
end

if (i == 1)
    up = N;
    down = 2;
elseif (i == N)
    up = N-1;
    down = 1;
else
    up = i-1;
    down = i+1;
end


if (A(up,left) == state1)
    r = r+1;
elseif (A(up,left) == state2)
    t = t+1;
end

if (A(up,j) == state1)
    r = r+1;
elseif (A(up,j) == state2)
    t = t+1;
end

if (A(up,right) == state1)
    r = r+1;
elseif (A(up,right) == state2)
    t = t+1;
end

if (A(i,left) == state1)
    r = r+1;
elseif (A(i,left) == state2)
    t = t+1;
end

if (A(i,right) == state1)
    r = r+1;
elseif (A(i,right) == state2)
    t = t+1;
end

if (A(down,left) == state1)
    r = r+1;
elseif (A(down,left) == state2)
    t = t+1;
end

if (A(down,j) == state1)
    r = r+1;
elseif (A(down,j) == state2)
    t = t+1;
end

if (A(down,right) == state1)
    r = r+1;
elseif (A(down,right) == state2)
    t = t+1;
end

end
