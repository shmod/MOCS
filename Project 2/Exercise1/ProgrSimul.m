%This program plots the mean field eq.
close all
clear all
tic
T = 200;
bvals = 1:1:10;
n=1000;
A_0 = n;
count = 0;
numreps = 100;
finalS = zeros(size(bvals,2),numreps);
histS = zeros(size(bvals,2), 11);
for b = 1:50
    count = count + 1
    for rep = 1:numreps
        finalS(count, rep) = runProgr2(b, n, A_0, T);
    end
    %Take the histogram
    minVal = 0;%min(finalS(count,:));
    maxVal = 10000; %max(finalS(count,:));
end
toc

%Elapsed time is 0.007236 seconds.
