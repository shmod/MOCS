function B=newState(A, i, j)
N = size(A,1);
if (A(i,j) == 1 || A(i,j) ==2)                  %Check if it is a firing
    B = mod((A(i,j)+1), 3);                     %or resting cell
else
    if (i == j && i == 1)
        Neighbours = [A(i+1,j); A(i,j+1); A(N,1); A(1,N); A(i+1,j+1); A(N,j+1); A(i+1, N); A(N,N)];
    elseif (i == 1)
        Neighbours = [A(i+1,j); A(i,mod(j,N)+1); A(N, j); A(i,j-1); A(i+1,j-1); A(N, j-1); A(i+1,mod(j,N)+1); A(N,mod(j,N)+1)];
    elseif (j == 1)
        Neighbours = [A(mod(i,N)+1,j); A(i,j+1); A(i-1, j); A(i,N); A(mod(i,N)+1,j+1); A(mod(i,N)+1,N); A(i-1,j+1);A(i-1,N)];
    else
        Neighbours = [A(mod(i,N)+1,j); A(i-1,j); A(i,mod(j,N)+1); A(i,j-1); A(mod(i,N)+1,j-1); A(i-1, j-1); A(i-1, mod(j,N)+1); A(mod(i,N)+1,mod(j,N)+1) ];
    end
    Num_firing = sum(Neighbours == 1);
    if (i == 10 && j == 9)
        Neighbours
    end
    if (Num_firing == 2)
        B = 1;
    else
        B = 0;
    end
end