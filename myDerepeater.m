%--%
function derep = myDerepeater(bits,reps,symbols)
    derep = zeros(symbols,1);
    j = 0;
    for i=1:reps:length(bits)-reps+1
        j = j + 1;
        bit = bits(i:i-1+reps);
        derep(j) = mode(bit);
    end
end