% The main function 

clc;
clear 
close all

% setting the type of MODULATION
mod_type = '16QM';

% Number of bits
inp_bits = 10000;
if mod_type == 'BPSK'
    M=1;
elseif mod_type == '4QAM'
    M=2;
elseif mod_type == '16QM'
    M=4;
end

% Creating the bit stream to transmit
for reps = 1:2:5  
TxBits = randi([0, 2^M-1],inp_bits,1);
    
    %reps = 3;
    % new = zeros(inp_bits,1)
    % for n=1:inp_bits
    %     if TxBits(n) == 0
    %             new(n) = 1+j*1;
    %         elseif TxBits(n) == 1;
    %             new(n) = -1+j*1;
    %         elseif TxBits(n) == 2;
    %             new(n) = 1-j*1;
    %         elseif TxBits(n) == 3;
    %             new(n) = -1-j*1;
    %     end
    % end
    
    
    % Calling the modulator function taking the inputs as the bit stream and
    % type of modulation to perform

   TxBits_IL = myInterleaver(TxBits);


    TxBits_reps = myRepeater(TxBits_IL,reps);
    
    modSym = myModulator(TxBits_reps,mod_type);
    num_sym = length(modSym);
    
    % Gaussian noise creation for the system
    noise=zeros(num_sym,1);
    
    snr = 0:1:20; 
    %snr=2
    lenghth_snrs = length(snr);
    
    %creating vector to store errord
    error_estimate_1 = zeros(lenghth_snrs,1);
    bit_error = zeros(lenghth_snrs,1);
    for k=1:lenghth_snrs 
        snr_now = snr(k);
    
        % Convertingthe db to decimal
        ebno=10^(snr_now/10);
    
        % generalising the noise for the BPSK type
        % For QPSK the noise will be coded soon
        % defining the std deviation/variance for the system    
        if mod_type == 'BPSK'
            sigma=sqrt(1/(1*ebno)); 
        elseif mod_type == '4QAM'
            sigma=sqrt(1/(2*ebno)); 
        elseif mod_type == '16QM'
            sigma=sqrt(1/(4*ebno)); 
        end
          
        % Defining Noise
        noise = sigma*(randn(num_sym,1)+1i.*randn(num_sym,1));
    
        % Adding Gaussian noise to created symbols.
        received_signal = modSym + noise';
    
        % Calling the demodulator function to demodulated the signal with noise
        rxBits = myDemodulator(received_signal,num_sym,mod_type);
    
        rxBits_reps = myDerepeater(rxBits,reps,inp_bits);


        rxBits_IL = myDeinterleaver(rxBits_reps);

        % To estimate error for each SNR value and add it to estimate
        errors = (rxBits_IL' ~= TxBits); 
        
        % Getting the Bit Error Rate for every symbol and then summing it
        error_estimate_1(k) = sum(errors)/num_sym;
        bit_error(k) = error_estimate_1(k)/M;
    end   
    
    % Plotting the error obtained from demodulation and the theoretical
    % error value obtauined from the qfunction
    
    semilogy(snr,bit_error);
    %hold on used to get two plots in the same graph
    hold on;
    grid on;
    %disp(bit_error);
    
end

xlabel("SNR");
ylabel("Bit Error Rate");



% 
% % Plotting the BER using the q-function
% if mod_type == '16QM'
%     semilogy(snr,3*qfunc(sqrt(0.2*10.^(snr/10)))); 
% elseif mod_type == '4QAM'
%  semilogy(snr,2*qfunc(sqrt(10.^(snr/10))));
% elseif mod_type == 'BPSK'
% semilogy(snr,qfunc(sqrt(10.^(snr/10)))); 
% end
% 
% legend("SER from noise(experimental) ","SER using q-function(theoretical)"); 
% xlabel("SNR");
% ylabel("Symbol Error Rate");    


% 
% % For BER
% semilogy(snr,bit_error);
% %hold on used to get two plots in the same graph
% hold on;
% disp(bit_error);
% 
% if mod_type == '16QM'
%     semilogy(snr,3/4*qfunc(sqrt(10.^(snr/10)))); 
% elseif mod_type == '4QAM'
%      semilogy(snr,qfunc(sqrt(10.^(snr/10))));
% elseif mod_type == 'BPSK'
%      semilogy(snr,qfunc(sqrt(10.^(snr/10))));
% end
% legend("BER from noise(experimental) ","BER using q-function(theoretical)"); 
% xlabel("SNR");
% ylabel("Bit Error Rate");    
%semilogy(snr,3/2*erfc(sqrt(0.1*(10.^(snr/10)))));
%semilogy(snr,qfunc(sqrt(10.^(snr/10)))); 

