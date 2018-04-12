%Set up paremater values
rvals=[1:10:995]
numreps=200;
hrange=[0:10:1000];
histS=zeros(length(rvals),length(hrange));


% Simulate numreps times for each parameter setting
count=0;
for r=rvals
    r
    uall=[];
    count=count+1

    for rep=1:numreps
        S=NumOfSharMax(r);
        finalS(count,rep)=S(end);
    end
end

p = max(finalS,2);