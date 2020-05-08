clc;
close all;
clear all;

f=0.8;
n=6;
a=fir1(n, f, 'high');
b=fir1(n, f, 'low');
[x, fs] = audioread('audio2.wav');
o = filter(a, 1, x);
p = filter(b, 1, o);
fvtool(p, 1);
subplot(2, 1, 1);
plot(x);
subplot(2, 1, 2);
plot(p);