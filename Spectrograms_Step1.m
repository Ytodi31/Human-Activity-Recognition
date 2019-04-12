% 
folder = 'Climb_stairs/';
files = dir([folder,'Accelerometer-2011-04-11-11-58-30-climb_stairs-f1.txt']);
numFiles = length(files);
dataFiles = zeros(1,numFiles);
noisy_x = [];
noisy_y = [];
noisy_z = [];
for i=1:1:numFiles
    dataFiles(i) = fopen([folder files(i).name],'r');
    data = fscanf(dataFiles(i),'%d\t%d\t%d\n',[3,inf]);

    % Fix the array sizes for data vectors of differing lengths
    noisy_x = padarray(noisy_x, [0,max(size(data,2)-size(noisy_x,2),0)],0,'post');
    noisy_y = padarray(noisy_y, [0,max(size(data,2)-size(noisy_y,2),0)],0,'post');
    noisy_z = padarray(noisy_z, [0,max(size(data,2)-size(noisy_z,2),0)],0,'post');
    
    % Convert the accelerometer data into real acceleration values
    % mapping from [0..63] to [-14.709..+14.709]
    noisy_x(i,1:size(data,2)) = -14.709 + (data(1,:)/63)*(2*14.709);
    noisy_y(i,1:size(data,2)) = -14.709 + (data(2,:)/63)*(2*14.709);
    noisy_z(i,1:size(data,2)) = -14.709 + (data(3,:)/63)*(2*14.709);
end
noisy_x = transpose(noisy_x);
noisy_y = transpose(noisy_y);
noisy_z = transpose(noisy_z);

% Creating a High pass filter to filter out the low frequency data which is
% essentially noise
Fs = 32;  % Sampling Frequency

Fstop = 0;               % Stopband Frequency
Fpass = 2;               % Passband Frequency
Dstop = 0.0001;          % Stopband Attenuation
Dpass = 0.057501127785;  % Passband Ripple
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop, Fpass]/(Fs/2), [0 1], [Dstop, Dpass]);
% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

filtered_x=filter(Hd,noisy_x);

filtered_y=filter(Hd,noisy_y);

filtered_z=filter(Hd,noisy_z);

%------------------------------------
n1=134;
b1=1;
b2=50;
b3=100;

%Code to plot spectrographs using kaiser window keeping number of frequency points same
%and varying beta 
figure(1),
spectrogram(filtered_x,kaiser(n1,b1),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 1, zero overlap and n=134')
figure(2),
spectrogram(filtered_x,kaiser(n1,b2),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 50, zero overlap and n=134')
figure(3),
spectrogram(filtered_x,kaiser(n1,b3),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 100, zero overlap and n=134')

%%
n1=134;
b1=1;

%Code to plot spectrographs using kaiser window varying number of frequency points same
%and keeping beta constant 
figure(1),
spectrogram(filtered_x,kaiser(n1,b1),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 1,f=64,zero overlap and n=134')
figure(2),
spectrogram(filtered_x,kaiser(n1,b1),0,128,32,'yaxis')
title('Filtered x Kaiser with beta value 1,f=128,zero overlap and n=134')
figure(3),
spectrogram(filtered_x,kaiser(n1,b1),0,256,32,'yaxis')
title('Filtered x Kaiser with beta value 1,f =256, zero overlap and n=134')

n1=33;
n2=132;
n3=264;

%%
%Code to plot spectrographs using kaiser window varying number of frequency points same
%and keeping beta constant 
figure(1),
spectrogram(filtered_x,kaiser(n1,b1),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 1,zero overlap and n=33')
figure(2),
spectrogram(filtered_x,kaiser(n2,b1),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 1,zero overlap and n=132')
figure(3),
spectrogram(filtered_x,kaiser(n3,b1),0,64,32,'yaxis')
title('Filtered x Kaiser with beta value 1, zero overlap and n=264')



