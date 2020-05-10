clear all;
%audio1 duration is less than audio2
[x1, fs1] = audioread("audio1.wav");
number_of_samples1 = length(x1);
duration_in_seconds1 = floor(number_of_samples1 / fs1);
% sound(x1, fs1);

[x2, fs2] = audioread("audio2.wav");
number_of_samples2 = length(x2);
duration_in_seconds2 = floor(number_of_samples2 / fs2);
% sound(x2, fs2);

X = x2;
[~,peaklocs] = findpeaks(x1);
N = mean(diff(peaklocs));
omega = (2*pi)/N;
for n = 1 : number_of_samples1
    disp(X(n));
    X(n) = X(n)+0.1*x1(n)*cos(omega*n);
    disp(X(n));
end
audiowrite("result.wav",X,fs2);
plot(log10(abs(fft(X))));
sound(X, fs2);

Y = linspace(0, duration_in_seconds1, number_of_samples1);
for n = 1 : number_of_samples1
    Y(n) = X(n)*cos(omega*n);
end
% sound(Y);
% title("audio1");
% X1 = linspace(0, duration_in_seconds1, number_of_samples1);
% plot(X1, x1);
% 
% title("audio2");
% X2 = linspace(0, duration_in_seconds2, number_of_samples2);
% plot(X2, x2);