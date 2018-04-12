%This program plots the mean field eq.
close all
clear all

T = 200;
bvals = 5:1:10;
n=1000;
A_0 = n;
count = 0;
numreps = 100;
finalS = zeros(size(bvals,2),numreps);
histS = zeros(size(bvals,2), 10001);
for b = bvals
    uall = [];
    count = count + 1
    
    for rep = 1:numreps
        finalS(count, rep) = runProgr2(b, n, A_0, T);
    end
    
    %Take the histogram
    minVal = 0;%min(finalS(count,:));
    maxVal = 10000; %max(finalS(count,:));
    histS(count,:) = hist(finalS(count,:), [minVal:1:maxVal]);
end