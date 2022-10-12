function inter = myInterleaver(ILbits)
    
    l = length(ILbits);
    m=round(l/4);
    TxArray1 = zeros(m,4);
    inter = zeros(1,l);
    for x=1:m
        TxArray1(x,1) = ILbits((4*(x-1)+1));
        TxArray1(x,2) = ILbits((4*(x-1)+2));
        TxArray1(x,3) = ILbits((4*(x-1)+3));
        TxArray1(x,4) = ILbits((4*(x-1)+4));
    end
    for y=1:l
        if y<=m
            inter(y)=TxArray1(y,1);
        elseif y>m && y<=2*m
          
          
            inter(y)=TxArray1((y-m),2);
        elseif y>2*m && y<=3*m
            inter(y)=TxArray1((y-2*m),3);
        else
            
            
            inter(y)=TxArray1((y-3*m),4);
        end

        
    end
end
