clear all
close all
clc

fe = 1e4;
te = 1/fe;
N = 10000; 

t = (0:N-1)*te; 
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
% plot(t,x);
f =(0:N-1)*(fe/N); 
y = fft(x); 
% plot(f,abs(y));
 
fshift = (-N/2:N/2-1)*(fe/N)
% plot(fshift,fftshift(2*abs(y)/N))

bruit = 60*randn(size(x));
xnoise = x+bruit;
% plot(xnoise);
 
%signal
%  sound(x)
%signal avec bruit
%  sound(xnoise)

ybruit = fft(xnoise);
% plot(fshift,fftshift(abs(ybruit)));
[x,fs]=audioread("bluewhale.au")
chant=x(2.45e4:3.10e4);

%Ecouter le 
sound(x,fs)

%visualisation
N = length(chant);
ts = 1/fs;
t = (0:N-1)*(10*ts);
% plot(t,chant,'r');
dsp_chant=(abs(fft(chant)).^2)/N;
f=(0:floor(N/2))*(fs/N)/10;
% plot(f,dsp_chant(1:floor(N/2)+1))