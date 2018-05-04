errors = 0.1:2*pi/15:2*pi;
neis = 3:1:15;

alignments = zeros(size(errors,2), size(neis,2));
iter = 20;
tempAlign = zeros(1,iter);

for i = 1:size(errors,2);
    for j = 1:size(neis,2);
        i
        j
        for l = 1:iter
            tempAlign(l) = Align2Dforce(errors(i), neis(j));
        end
        alignments(i,j) = mean(tempAlign);
    end
end