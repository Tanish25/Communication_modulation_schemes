function deinter = myDeinterleaver(DILbits)
    
    l = length(DILbits);
    m=l/4;
    TxArray2 = zeros(4,m);
    deinter = zeros(1,l);
    for x=1:l
        if x<=m
            TxArray2(1,x)=DILbits(x);
        elseif x>m && x<=2*m
            TxArray2(2,x-m)=DILbits(x);
        elseif x>2*m && x<=3*m
            TxArray2(3,x-2*m)=DILbits(x);
        else
            TxArray2(4,x-3*m)=DILbits(x);
        end

        
    end
    for y=1:m
        deinter((4*(y-1)+1))=TxArray2(1,y) ;
        deinter((4*(y-1)+2))=TxArray2(2,y)  ;
        deinter((4*(y-1)+3))= TxArray2(3,y);
        deinter((4*(y-1)+4))=TxArray2(4,y) ;
    end
end
