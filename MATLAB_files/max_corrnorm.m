function l_max = max_corrnorm(x,y)
    r_norm = [];
    l = 1;
    while l <= length(x)-length(y)+1
        num = 0;
        den2 = 0;
        n = 1;
        m = min([length(y)-1 length(x)-1]);
        
        while n <= m
            num = num + x(n+l)*y(n);
            den2 = den2 + x(n+l)^2;
            n = n+1;
        end
        r_norm(end+1) = num/(den2)^0.5;
        l = l+1;
    end
    
    [r_max,l_max] = max(r_norm);
    
end