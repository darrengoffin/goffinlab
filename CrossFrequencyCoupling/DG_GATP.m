function GATP = DG_GATP(amplitudeSignal, phaseSignal, samplingRate)

% Define inputs
ampFreqs = [16 256];
nAmplitudes = 121;
phaseFreqs = [5 10];

willZScore = false;

% Calculate phase
phase = angle(hilbert(DG_FilterLFP(phaseSignal, samplingRate, phaseFreqs(1), phaseFreqs(2))));

% Calculate wavelet amplitudes
waveletAmps = abs(DG_wavelet(amplitudeSignal, samplingRate, ampFreqs, nAmplitudes, 'space', 'log'));

% Z-score the wavelet amplitudes if required
if willZScore == true
	waveletAmps = zscore(waveletAmps, [], 2);
end

% Define bins
nBins = 40;
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
willPlot = true;
if willPlot
    DG_plotGATP(GATP)
end

end
