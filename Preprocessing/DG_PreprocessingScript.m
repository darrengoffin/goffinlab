%% Preprocessing workflow for recorded data

clear
close all

% Enter animal details here from command line
animalID = input('Enter animal ID: ', 's');
genotype = input('Enter animal genotype: ', 's');
date = input('Enter recording data (YYYYMMDD format): ', 's');
probeType = 'NRX_A1x16';

% Select data file for preprocessing
[file, path] = uigetfile('*.rhd', 'Select an RHD2000 Data File');
[~, basename , ~] = fileparts(file);
cd(path);

% Read the recorded file from disk
DG_Read_Intan_RHD2000_file([path, file]);

% At the moment, SmartBox saves 32 channels even if probe is 16 channels. Let's fix this
if strcmp(probeType, 'NRX_A1x16') == 1
   amplifier_data(17:32, :) = [];
end

numberOfElectrodes = min(size(amplifier_data));
numberOfDataPoints = max(size(amplifier_data));

% Map electrode channels for given probe. Electrodes are ordered superficial -> deep
amplifier_data = DG_MapChannelsForProbeType(amplifier_data, probeType); 

% Set LFP sample rate. Default is 1250 Hz
lfpSampleRate = 1250;

% Down-sampling factor 
factor = fix(sampleRate / lfpSampleRate);

% Resample data to 1250 Hz after lowpass filtering with an 8th order
% Chebyshev Type I lowpass filter with cutoff frequency
% .8*(samplingRate/2)/factor i.e. 500 Hz
downSampledData = zeros(numberOfElectrodes, ceil(numberOfDataPoints / factor));

for electrodeIndex = 1 : numberOfElectrodes
    downSampledData(electrodeIndex, :) = decimate(amplifier_data(electrodeIndex, :), factor);
end
    
% Add information to LFP struct
LFP.animalID = animalID;
LFP.genotype = genotype;
LFP.date = date;
LFP.probeType = probeType;
LFP.timeSamples = linspace(0, length(downSampledData) / lfpSampleRate, length(downSampledData));
LFP.sampleRate = lfpSampleRate;
LFP.data = downSampledData;
LFP.numberOfElectrodes = numberOfElectrodes;
    
% Save LFP struct a as a .lfp.mat file
save([basename '.lfp.mat'], 'LFP')

% Clear workspace except LFP
clearvars -except LFP
    
disp('LFP file created!')




