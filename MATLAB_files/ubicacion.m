function ub = ubicacion(clicks)
    ub = [];
    aux = [];
    n = 1;
    m = 0;
    while n <= length(clicks)
        if clicks(n) ~= 0
            m = n+1;
            aux(end+1) = n;
            while clicks(m) ~= 0
                aux(end+1) = m;
                m = m+1;
            end
        end
        if (m-n) > 0
            ub(end+1) = floor(sum(aux)/(m-n));
        end
        aux = [];
        n = n+1;
    end
    ub = ub(ub~=0);
    aux = [];
    
    
    
    
end
            
            