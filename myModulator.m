% The modulator function 
%modSym stores the modulated values of the bits 
function modSym = myModulator(TxBits,mod_type)

if mod_type == 'BPSK'
    % BPSK constellation definition, if bit is 0--constellation is 1:
    % if bit is 1-- constellation is -1
    constellation = exp(1i*2*pi.*TxBits/2);
    constellation = constellation';

%     range = [-1,1];
%     constellation = range(TxBits+1);
    % Code for QPSK will be added soon
elseif mod_type == '4QAM'
    range = [1+1i*1 -1+1i*1 1-1i*1 -1-1i*1]/sqrt(2);
    constellation = range(TxBits+1);
elseif mod_type == '16QM'
    range = [1+1i*1 1+1i*3 3+1i*1 3+1i*3 -1+1i*1 -1+1i*3 -3+1i*1 -3+1i*3 1-1i*1 1-1i*3 3-1i*1 3-1i*3 -1-1i*1 -1-1i*3 -3-1i*1 -3-1i*3]/sqrt(4);
    constellation = range(TxBits(:)+1);
end
modSym = constellation;   

end