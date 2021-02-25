function ICA = DG_performICA(basepath)

disp('Performing ICA')

% Bandpass for filtering signal
bandpass = [30 300];

% Open LFP file
load([basepath filesep 'LFP' '.mat'], 'LFP')

% Suppress 50Hz noise
LFP.data = applyNotchFilter(LFP.data, LFP.samplingRate);

% Filter low-frequency information to prevent contamination from theta
LFP.data = DG_FilterLFP(LFP.data, LFP.samplingRate, bandpass(1), bandpass(2));

% PCA reduction
[~, ~, D] = pca(LFP.data');
N = find(cumsum(D)/sum(D)>0.98,1);

% ICA calculation
[weights, sphere, ~, ~, ~, ~, ICA.v] = runica(LFP.data', 'verbose', 'off', 'pca', N);

% Calculate voltage weights
ICA.weights = weights * sphere;
ICA.M  = pinv(ICA.weights);

plotVoltageLoadings(ICA.M)

ICA.bandpass = bandpass;

% Save ICA
saveICA(ICA, basepath);

end

function data = applyNotchFilter(data, samplingRate)

    Fnyq  = samplingRate/2;
    F_notch = 50;
    [b, a] = iirnotch(F_notch/Fnyq, F_notch/Fnyq/20);
    data = WhitenSignalIn(data);
    data  = filtfilt(b, a, data);

end

function saveICA(ICA, basepath)

    analysisFolder = [basepath filesep 'Analyses'];
    if ~exist(analysisFolder, 'dir')
       mkdir(analysisFolder)
    end
    
    icaFolder = [basepath filesep 'Analyses' filesep 'ICA'];
    if ~exist(icaFolder, 'dir')
       mkdir(icaFolder)
    end
    
    filename = 'ICA_voltageLoadings';
    
    save([icaFolder filesep filename '.mat'], 'ICA', '-v7.3');
end
