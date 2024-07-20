clear

[y_con_clicks,fs] = audioread('audio_con_clicks.wav');

% Codigo generado por Matlab mediante la herramienta de diseño de filtros:

%--------------------------------------------------------------------------
% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 44100;  % Sampling Frequency

Fpass = 3100;        % Passband Frequency
Fstop = 3300;        % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 70;          % Stopband Attenuation (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
%--------------------------------------------------------------------------

%Orden = 135

%Filtro y genero el archivo de audio
y_filtrada = filter(Hd,y_con_clicks);
audiowrite('audio_filtrado_lineal.wav',y_filtrada,fs);


