function y_filtrada = filtro_no_lineal(y,ub,NP)
    iteraciones = 1;
    y_filtrada = y;
    NV = 10*NP; %Ancho de fragmento de señal en el que se buscara uno de largo NP para reemplazar en la señal.
    
    win = kaiser(NP,2);
    
    while iteraciones <= length(ub)
        yf = seleccion(y,ub(iteraciones),NP);
        
        if ub(iteraciones) -NP/2 <= NV
            x_izq = seleccion(y,floor((ub(iteraciones)-floor(NP/2))/2),ub(iteraciones)-floor(NP/2));
            l_1 = max_corrnorm(x_izq,yf);
            x1(1:NP) = y(l_1:l_1 + NP-1);
        else
            x_izq = seleccion(y,ub(iteraciones)- (NP+NV)/2,NV);
            l_1 = max_corrnorm(x_izq,yf);
            x1(1:NP) = y(ub(iteraciones)-floor(NP/2)- NV + l_1:ub(iteraciones)-floor(NP/2)- NV + l_1 + NP-1);
        end
        
        if length(y)-ub(iteraciones) + NP/2 <= NV
            x_der = seleccion(y,floor((length(y)+ub(iteraciones)+ NP/2)/2),(length(y)-ub(iteraciones)-floor(NP/2)));
            l_2 = max_corrnorm(x_der,yf);
            x2(1:NP) = y(ub(iteraciones)+floor(NP/2)+l_2:ub(iteraciones)+floor(NP/2)+l_2 + NP-1);
        else
            x_der = seleccion(y,(ub(iteraciones)+floor(NP/2)+NV/2),NV);
            l_2 = max_corrnorm(x_der,yf);
            x2(1:NP) = y(ub(iteraciones)+floor(NP/2)+l_2:ub(iteraciones)+floor(NP/2)+l_2+NP-1);
        end
        
        x_final(1:NP) = (x1(1:NP) + x2(1:NP)).*0.5;
        x_final = transpose(x_final);
        
        n = 1;
        while n<=NP
            y_filtrada(ub(iteraciones)-NP/2 + n - 1) = y_filtrada(ub(iteraciones)-NP/2 + n - 1)*(1-win(n)) + x_final(n)*win(n);
            n = n+1;
        end
        
        iteraciones = iteraciones + 1;
    end
end   