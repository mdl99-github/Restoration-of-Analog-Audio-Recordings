%% Cargado de señales
clear

[y_corto,fs] = audioread('audio_corto.wav');
[y_con_clicks,fs] = audioread('audio_con_clicks.wav');

%% Filtro IIR

Fstop = 3100;        % Stopband Frequency
Fpass = 3300;        % Passband Frequency
Astop = 70;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, fs);
Hd_hp_iir = design(h, 'butter', 'MatchExactly', match);

y_iir = filter(Hd_hp_iir,y_corto);

%% Filtro FIR

Fstop = 3100;              % Stopband Frequency
Fpass = 3300;              % Passband Frequency
Dstop = 0.00031622776602;  % Stopband Attenuation
Dpass = 0.057501127785;    % Passband Ripple
flag  = 'scale';           % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fstop Fpass]/(fs/2), [0 1], [Dpass Dstop]);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd_hp_fir = dfilt.dffir(b);

y_fir = filter(Hd_hp_fir,y_corto);
%% Deteccion
y_con_clicks_fir = filter(Hd_hp_fir,y_con_clicks);
NP = 80; %Largo esperado de los cilcks.
umbral = 0.02;
retardo = 477; % Retardo (en muestras) por filtro FIR.
clicks = deteccion(y_con_clicks_fir,umbral,retardo);
ub = ubicacion(clicks);

%% Filtrado no lineal
y_filtrada = filtro_no_lineal(y_con_clicks,ub,NP);

%% Filtrado pasabajos de correccion
% All frequency values are in Hz.

Fpass = 13400;             % Passband Frequency
Fstop = 13800;             % Stopband Frequency
Dpass = 0.057501127785;    % Passband Ripple
Dstop = 0.00031622776602;  % Stopband Attenuation
flag  = 'scale';           % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd_correccion = dfilt.dffir(b);

y_filtrada_final = filter(Hd_correccion,y_filtrada);
audiowrite('audio_filtrado_no_lineal.wav',y_filtrada_final,fs);