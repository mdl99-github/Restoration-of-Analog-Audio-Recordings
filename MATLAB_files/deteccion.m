function impulsos = deteccion(y_filtrada,u,retardo)
    %u representa el umbral de amplitud.
    n = 1;
    impulsos = [];

    while n <= length(y_filtrada)
        if abs(y_filtrada(n)) < u
            impulsos(end+1) = 0;
        end
    
        if abs(y_filtrada(n)) >= u
            impulsos(end+1) = y_filtrada(n);
        end
    
        n = n + 1;
    end
    
    %Aplico el retardo
    
    n=1;
    while n<= (length(impulsos) - retardo)
        impulsos(n) = impulsos(n+retardo);
        n = n+1;
    end
    while n <= length(impulsos)
        impulsos(n) = 0;
        n = n+1;
    end
    impulsos = transpose(impulsos);
end