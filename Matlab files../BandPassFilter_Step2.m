
% function displayModel(folder)
%
% displayModel plots the acceleration recorded in the modelling trials
% stored in the given folder. Acceleration data are decoded and filtered
% with median filtering.
%
% Input:
%   folder --> name of the folder containing the dataset to be displayed
%
% Output:
%   ---
%
% Example:
%   folder = 'Climb_stairs_MODEL/';
%   displayModel(folder);

% READ THE ACCELEROMETER DATA FILES
folder='Walk/'
files = dir([folder,'*.txt']);
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

    % CONVERT THE ACCELEROMETER DATA INTO REAL ACCELERATION VALUES
    % mapping from [0..63] to [-14.709..+14.709]
    noisy_x(i,1:size(data,2)) = -14.709 + (data(1,:)/63)*(2*14.709);
    noisy_y(i,1:size(data,2)) = -14.709 + (data(2,:)/63)*(2*14.709);
    noisy_z(i,1:size(data,2)) = -14.709 + (data(3,:)/63)*(2*14.709);
end
noisy_x = transpose(noisy_x);
noisy_y = transpose(noisy_y);
noisy_z = transpose(noisy_z);
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

hx=filter(Hd, noisy_x);
hy=filter(Hd, noisy_y);
hz=filter(Hd, noisy_z);


% REDUCE THE NOISE ON THE SIGNALS BY MEDIAN FILTERING
n = 3;      % order of the median filter
x_set = medfilt1(hx,n);
y_set = medfilt1(hy,n);
z_set = medfilt1(hz,n);
numSamples = length(x_set(:,1));

% DISPLAY THE RESULTS
time = 1:1:numSamples;

xwalk=x_set;
ywalk=y_set;
zwalk=z_set;

% DISPLAY THE RESULTS
time = 1:1:numSamples;

Fs = 32;  % Sampling Frequency

Fstop1 = 0;               % First Stopband Frequency
Fpass1 = 1.5;             % First Passband Frequency
Fpass2 = 6;               % Second Passband Frequency
Fstop2 = 8;               % Second Stopband Frequency
Dstop1 = 0.001;           % First Stopband Attenuation
Dpass  = 0.057501127785;  % Passband Ripple
Dstop2 = 0.0001;          % Second Stopband Attenuation
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);
% noisy signal

xwalk=filter(Hd,x_set)
ywalk=filter(Hd,y_set)
zwalk=filter(Hd,z_set)
