% Recordings are made wide?band (0.1 ? 6000 Hz; 20 kHz sampling rate)
% For LFP analysis, recordings are subsequently filtered (800 Hz low?pass filter) and down?sampled (to 1250 Hz) digitally
% LFP data and lfp sample rate are then saved into a struct named LFP

function [LFP] = DG_getLFP(baseName, data, time, sampleRate, lfpSampleRate)

    % OUTPUT
    % Creates file: basePath/baseName.lfp

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
    
    baseName = [baseName '.lfp.mat']; 
    save(baseName, 'LFP')
    
    disp('LFP file created!')

end