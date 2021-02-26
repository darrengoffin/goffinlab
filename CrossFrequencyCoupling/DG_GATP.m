function GATP = DG_GATP(amplitudeSignal, phaseSignal, varargin)

% Parse inputs or load default inputs
[ampFreqs, nAmplitudes, phaseFreqs, fs, nBins, willZScore, willPlot] = parseInputs(varargin);

% Calculate phase
phase = angle(hilbert(DG_FilterLFP(phaseSignal, fs, phaseFreqs(1), phaseFreqs(2))));

% Calculate wavelet amplitudes
waveletAmps = abs(DG_wavelet(amplitudeSignal, fs, ampFreqs, nAmplitudes));

% Z-score the wavelet amplitudes if required
if willZScore == true
	waveletAmps = zscore(waveletAmps, [], 2);
end

% Define bins
binSize = 2 * pi / nBins;
position = linspace(-pi, pi - binSize, nBins);

meanAmplitude = zeros(nAmplitudes, nBins); 

% Compute the mean amplitude in each phase bin    
for binIdx = 1 : nBins   
    meanAmplitude(:, binIdx) = mean(waveletAmps(:, phase <  position(binIdx)+binSize & phase >= position(binIdx)), 2); 
end
    
% Normalize if not using z-score wavelet amplitudes
if willZScore == false
    meanAmplitude = meanAmplitude ./ sum(meanAmplitude, 2);
end

% Output as struct
GATP.meanAmplitude = [meanAmplitude meanAmplitude];
GATP.ampFreqs = DG_logspace(ampFreqs(1), ampFreqs(2), nAmplitudes);
GATP.phaseFreqs = phaseFreqs;
GATP.phaseBins = DG_calculateBinCenters(0, 720, nBins*2);

% Plot if necessary
if willPlot
    DG_plotGATP(GATP)
end

end

% Parse input arguments
function [ampFreqs, nAmplitudes, phaseFreqs, fs, nBins, willZScore, willPlot] = parseInputs(input)
    
    p = inputParser;

	addOptional(p, 'ampFreqs', [16 256], @isnumerical)
	addOptional(p, 'nAmplitudes', 121, @isnumerical)
	addOptional(p, 'phaseFreqs', [5 10], @isnumerical)
    addOptional(p, 'fs', 1250, @isnumerical)
    addOptional(p, 'nBins', 40, @isnumerical)
    addOptional(p, 'willZScore', true, @islogical)
    addOptional(p, 'willPlot', true, @islogical)

    parse(p, input{:})
    
	ampFreqs = p.Results.ampFreqs;
    nAmplitudes = p.Results.nAmplitudes;
    phaseFreqs = p.Results.phaseFreqs;
    fs = p.Results.fs;
    nBins = p.Results.nBins;
    willZScore = p.Results.willZScore;
    willPlot = p.Results.willPlot;

end
