%This program plots the mean field eq.
close all
clear all
tic
T = 200;
bvals = 1:1:50;
n=1000;
A_0 = n;
count = 0;
numreps = 100;
finalS = zeros(size(bvals,2),numreps);
histS = zeros(size(bvals,2), 101);
for b = bvals
    count = count + 1
    
    for rep = 1:numreps
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
            tic
            [v, Population_t(1, t)] = progressor(v, b);
            v = zeros(1, n);
            for j= 1:Population_t(1,t)
                k = randi(n);
                v(k) = v(k) + 1;
            end
            toc
        end
        p = Population_t(1, end);
    end
    
    %Take the histogram
    minVal = 0;%min(finalS(count,:));
    maxVal = 10000; %max(finalS(count,:));
    histS(count,:) = hist(finalS(count,:), 0:100:10000);
end
imagesc(bvals, 0:100:10000, histS'/numreps, [0 0.1])
toc