clc
clear
close all

% Define basepath
basepath = pwd;

% Define filter bandpass
bandpass = [30 200];

% Load LFP file
load('LFP.mat')

% Run ICA
ICA = DG_ICA(LFP, bandpass);

% Save file
save([basepath filesep 'Analyses' filesep 'ICA' filesep 'ICA.mat'], 'ICA', '-v7.3');

% Plot voltage loadings
DG_plotVoltageLoadings(ICA.M);


% Convience function
function ICA = DG_ICA(LFP, bandpass)

disp('Performing ICA')

% Apply notch filter

LFP.data = LFP.data - mean(LFP.data);

% Pre-whiten data
LFP.data = WhitenSignalIn(LFP.data);

% Apply notch filter to remove electrical noise
Fnyq  = LFP.samplingRate/2;
F_notch = 50; % Notch at 50 Hz
[b,a] = iirnotch(F_notch/Fnyq, F_notch/Fnyq/20);
LFP.data = filtfilt(b,a, LFP.data);

% Filter low-frequency information to prevent contamination from theta
LFP.data = DG_FilterLFP(LFP.data, LFP.samplingRate, bandpass(1), bandpass(2));

% PCA reduction
[~, ~, D] = pca(LFP.data');
N = find(cumsum(D)/sum(D)>0.98,1);

% ICA calculation
[weights, sphere, ~, ~, ~, ~, ICA.v] = runica(LFP.data', 'verbose', 'off', 'pca', N);

% Calculate voltage weights
ICA.weights = weights;
ICA.sphere = sphere;
ICA.M = pinv(weights * sphere);
ICA.bandpass = bandpass;

end
