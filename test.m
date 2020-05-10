clear all;
%audio1 duration is less than audio2
[x1, fs1] = audioread("audio1.wav");
number_of_samples1 = length(x1);
duration_in_seconds1 = floor(number_of_samples1 / fs1);
% sound(x1, fs1);
% pause(duration_in_seconds1);

[x2, fs2] = audioread("audio2.wav");
number_of_samples2 = length(x2);
duration_in_seconds2 = floor(number_of_samples2 / fs2);
% sound(x2, fs2);
% pause(duration_in_seconds2);

[~,peaks1] = findpeaks(x1);
N1 = mean(diff(peaks1));
[~,peaks2] = findpeaks(x2);
N2 = mean(diff(peaks2));
omega = 2*pi/N1;  %omega = 2pi/period
A = 0.1;

X = x2;
for n = 1 : number_of_samples1
    X(n) = x2(n)+A*x1(n)*cos(omega*n);
end
sound(X, fs2);
pause(duration_in_seconds2);

audiowrite("result.wav",X,fs2);
% figure('Name', 'the magnitude spectrum for the result'); plot(log10(abs(fft(X))));
figure('Name', 'the magnitude spectrum for audio1'); plot((abs(fft(x1))));
% figure('Name', 'the magnitude spectrum for audio2'); plot(log10(abs(fft(x2))));


Y = linspace(0, duration_in_seconds1, number_of_samples1);
for n = 1 : number_of_samples1
    Y(n) = X(n)*cos(omega*n);
end
% frequency domain; fourier transform
Yfft = fft(Y);
% multiply the range of Y[k] by zeros.
range = 8;
for k = floor(length(Yfft)/range) : (range)*floor(length(Yfft)/range)
    Yfft(k) = 0;
end
% delete the effect of the attenuation factor by dividing by it.
for n = 1 : length(Yfft)
    Yfft(n) = Yfft(n) / A;
end
% inverse fourier transform
Yifft = abs(ifft(Yfft));
audiowrite("restored.wav",Yifft,fs1);
sound(Yifft, fs1);
pause(duration_in_seconds1);
figure('Name', 'the magnitude spectrum for restored audio'); plot((abs(fft(Y))));