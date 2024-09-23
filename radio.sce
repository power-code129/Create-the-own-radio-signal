// Load audio signal (or create one)
fs_audio = 44100;  // Sampling rate for audio (44.1 kHz)
duration = 5;      // 5 seconds duration
t_audio = 0:1/fs_audio:duration;  // Time vector for audio signal

// Generate a simple audio signal (sine wave)
f_audio = 500;  // Frequency of audio signal (500 Hz, simulate as tone)
audio_signal = sin(2 * %pi * f_audio * t_audio);

// FM Modulation Parameters
fs = 200000;  // Sampling frequency for modulated signal (200 kHz)
fc = 100000;  // Carrier frequency (100 kHz)
kf = 2 * %pi * 75000;  // Frequency deviation (modulation index)

t = 0:1/fs:duration;  // Time vector for FM modulated signal

// Resample audio signal to match the modulation sampling frequency
audio_resampled = interp1(t_audio, audio_signal, t, 'linear');  // Linear interpolation

// Perform FM modulation (frequency modulation)
integral_audio = cumsum(audio_resampled) / fs;  // Integrate the audio signal
fm_signal = cos(2 * %pi * fc * t + kf * integral_audio);  // FM modulated signal

// Plot Audio Signal
clf;
subplot(3,1,1);
plot(t_audio, audio_signal);
title("Audio Signal (Message)");
xlabel("Time (s)");
ylabel("Amplitude");

// Plot FM Modulated Signal
subplot(3,1,2);
plot(t, fm_signal);
title("FM Modulated Signal");
xlabel("Time (s)");
ylabel("Amplitude");

// Spectrum Analysis (FFT)
N = length(fm_signal);
f = linspace(-fs/2, fs/2, N);  // Frequency axis
FM_spectrum = abs(fftshift(fft(fm_signal)) / N);  // Compute FFT

subplot(3,1,3);
plot(f, FM_spectrum);
title("FM Signal Spectrum");
xlabel("Frequency (Hz)");
ylabel("Magnitude");

// Play the audio message (if you want to hear the original message)
sound(audio_signal, fs_audio);
