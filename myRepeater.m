function rep = myRepeater(bits,reps)
    rep = [];
    new = zeros(reps,1);
    for i=1:length(bits)
        % Selects the Bit
        bit = bits(i);
        % Repeats the bits
        for j=1:reps
            new(j) = bit;
        end
        % Adds the bits
        rep = [rep new'];
    end
    rep = rep';
end