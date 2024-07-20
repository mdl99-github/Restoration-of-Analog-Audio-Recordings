function fragmento = seleccion(y,posicion,largo)
    fragmento = [];
    n = posicion - floor(largo/2)+1;
    while n <= (posicion + floor(largo/2))
        fragmento(end+1) = y(n);
        n = n+1;
    end
end
