function r=count(A, i, j, state)
r = 0;
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


if (A(up,left) == state)
    r = r+1;
end
if (A(up,j) == state)
    r = r+1;
end
if (A(up,right) == state)
    r = r+1;
end
if (A(i,left) == state)
    r = r+1;
end
if (A(i,right) == state)
    r = r+1;
end
if (A(down,left) == state)
    r = r+1;
end
if (A(down,j) == state)
    r = r+1;
end
if (A(down,right) == state)
    r = r+1;
end

end
