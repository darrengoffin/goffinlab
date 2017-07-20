% This function takes raw CSC data and extracts LFP
% Recordings are made wide‐band (0.1 – 6000 Hz; 20 kHz sampling rate)
% For LFP analysis, recordings are subsequently filtered (800 Hz low‐pass filter) and down‐sampled (to 1250 Hz) digitally
% LFP data, lfp sample rate, and time stamps are then saved into a struct named LFP

function [LFP] = DG_getLFP(baseName, data, time, sampleRate, lfpSampleRate)

% INPUTS
% data - contains a matrix of CSC data. Rows must represent individual electrodes. Columns must represent individual time points
% time - time stamps for data
% sampleRate – acquisition rate. Default = 20,000 Hz.
% lfpSampleRate - downSampledRate. Default = 1250 Hz.
    
% OUTPUTS
% Creates file: baseName.lfp.mat

% LFP = DG_getLFP(baseName, data, time, sampleRate, lfpSampleRate);
% LFP = DG_getLFP(baseName, data, time, sampleRate); Assumes lfpSampleRate = default
% LFP = DG_getLFP(baseName, data, time); Assumes lfpSampleRate = default and sampleRate = default
    
if nargin < 5
    lfpSampleRate = 1250;
end

if nargin < 4
    sampleRate = 20000;
end

% Data properties
numberOfElectrodes = size(data, 1);

% Down-sampling factor 
factor = fix(sampleRate / lfpSampleRate);
    
% Perform filtering and downsampling
for electrodeIndex = 1 : numberOfElectrodes
    buffer = FilterLFP(data(electrodeIndex, :), sampleRate, 0, 800);
    LFP.data(electrodeIndex,:) = decimate(buffer, factor);
end
    
LFP.timeSamples = decimate(time, factor);
LFP.sampleRate = lfpSampleRate;
    
save([baseName '.lfp.mat'], 'LFP')
    
disp('LFP file created!')

end
