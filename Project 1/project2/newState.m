%The input should be reimplemented to be a 3x3 array.

function B=newState(A, i, j)
B = A;
N = size(A,1);
p = 0.001;
q = 0.03;
r = q;%r = 0.0001;
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

Neighbors = [A(up, left) A(up, j) A(up, right) A(i, left) A(i, right) A(down, left) A(down, j) A(down, right)];
if (A(i,j) == 0)    %If its a resting cell, no interaction
    if (p > rand)
       B(i,j) = 2;
    end
elseif (A(i,j) == 1)    %if its a bored cell
    if (r > rand && Neighbors(randi(8)) == 0)
            B(i,j) = 0;
    end
else
    if (q > rand)
        num = randi(8);
        MyN =  Neighbors(num);
        if (MyN == 0)
            Neighbors(num) = 2;
            
            B(up, left) = Neighbors(1);
            B(up, j)= Neighbors(2);
            B(up, right)= Neighbors(3);
            B(i, left) = Neighbors(4);
            B(i, right) = Neighbors(5);
            B(down, left)= Neighbors(6);
            B(down, j)= Neighbors(7);
            B(down, right)= Neighbors(8);
        elseif (MyN == 1)
            B(i,j) = 1;
        end
    end
end
end