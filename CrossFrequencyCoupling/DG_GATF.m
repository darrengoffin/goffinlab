function GATF = DG_GATF(amplitudeSignal, phaseSignal, varargin)

% Parse inputs or load default inputs
[ampFreqs, nAmps, phaseFreqs, nPhases, fs, nBins, willPlot] = parseInputs(varargin);

% Calculate wavelet phases
phases = angle(DG_wavelet(phaseSignal, fs, [phaseFreqs(1) phaseFreqs(2)],  nPhases));

% Calculate wavelet amplitudes
waveletAmps = abs(DG_wavelet(amplitudeSignal, fs, [ampFreqs(1) ampFreqs(2)], nAmps));

% Define bins
binSize = 2 * pi / nBins;
position = linspace(-pi, pi - binSize, nBins);

MI = zeros(nAmps, nPhases);
meanAmplitude = zeros(nBins, nAmps); 

for phaseIdx = 1 : nPhases
       
    for binIdx = 1 : nBins
        meanAmplitude(binIdx, :) = mean(waveletAmps(:, phases(phaseIdx, :) >= position(binIdx) & phases(phaseIdx, :) <  position(binIdx)+binSize), 2);
    end
    
	MI(:, phaseIdx) = (log(nBins)-(-sum((meanAmplitude./sum(meanAmplitude)).*log((meanAmplitude./sum(meanAmplitude))))))/log(nBins);
end

GATF.phaseFreqs = DG_logspace(phaseFreqs(1), phaseFreqs(2), nPhases);
GATF.ampFreqs = DG_logspace(ampFreqs(1), ampFreqs(2), nAmps);
GATF.MI = MI;

% Plot if necessary
if willPlot
    DG_plotGATF(GATF.phaseFreqs, GATF.ampFreqs, GATF.MI);
end

end

% Parse input arguments
function [ampFreqs, nAmps, phaseFreqs, nPhases, fs, nBins, willPlot] = parseInputs(input)
    
    p = inputParser;

    addOptional(p, 'ampFreqs', [25 200], @isnumerical)
    addOptional(p, 'nAmps', 200, @isnumerical)
    addOptional(p, 'phaseFreqs', [4 16], @isnumerical)
    addOptional(p, 'nPhases', 73, @isnumerical)
    addOptional(p, 'fs', 1250, @isnumerical)
    addOptional(p, 'nBins', 40, @isnumerical)
    addOptional(p, 'willPlot', true, @islogical)

    parse(p, input{:})
    
    ampFreqs = p.Results.ampFreqs;
    nAmps = p.Results.nAmps;
    phaseFreqs = p.Results.phaseFreqs;
    nPhases = p.Results.nPhases;
    fs = p.Results.fs;
    nBins = p.Results.nBins;
    willPlot = p.Results.willPlot;

end
