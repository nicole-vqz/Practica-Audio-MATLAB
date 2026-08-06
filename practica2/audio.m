clear all
close all
clc

%Cargar archivo de audio
archivo = 'prueba_audio.wav'; 
[Xin, Fs] = audioread(archivo);

% Convertir a a un solo canal si es Estéreo
if size(Xin, 2) > 1
    Xin = Xin(:, 1);
end

% Vector de tiempo en segundos
tiempo = (0:length(Xin)-1) / Fs;

%Escalar el audio original al rango
max_val = max(abs(Xin));
Xin_positiva = (Xin / max_val + 1) / 2;
Xin_escalada = Xin_positiva * 65535;

%Llamar al Cuantificador
Y_4bit_indx = cuantificador_2(Xin_escalada, 4);
Y_2bit_indx = cuantificador_2(Xin_escalada, 2);
Y_1bit_indx = cuantificador_2(Xin_escalada, 1);

% Para 4 bits (16 niveles)(Decodificación)
cb_4bit = linspace(-max_val, max_val, 2^4);
Y_4bit = cb_4bit(Y_4bit_indx + 1);

% Para 2 bits (4 niveles)
cb_2bit = linspace(-max_val, max_val, 2^2);
Y_2bit = cb_2bit(Y_2bit_indx + 1);

% Para 1 bit (2 niveles)
cb_1bit = linspace(-max_val, max_val, 2^1);
Y_1bit = cb_1bit(Y_1bit_indx + 1);

%Gráficas
figure;

% Gráfica 1: Original
subplot(4, 1, 1);
plot(tiempo, Xin, 'b');
title('Señal Original');
ylabel('Amplitud');
grid on;

% Gráfica 2: 4 Bits
subplot(4, 1, 2);
plot(tiempo, Y_4bit, 'r');
title('Señal Cuantificada a 4 bits (16 niveles)');
ylabel('Amplitud');
grid on;

% Gráfica 3: 2 Bits
subplot(4, 1, 3);
plot(tiempo, Y_2bit, 'g');
title('Señal Cuantificada a 2 bits (4 niveles)');
ylabel('Amplitud');
grid on;

% Gráfica 4: 1 Bit
subplot(4, 1, 4);
plot(tiempo, Y_1bit, 'm');
title('Señal Cuantificada a 1 bit (2 niveles)');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');
grid on;

%sound(Xin, Fs)
%sound(Xin, 30000)
%sound(Xin, 120000)
%sound(Y_1bit, Fs)
%sound(Y_2bit, Fs)
%sound(Y_4bit, Fs)
