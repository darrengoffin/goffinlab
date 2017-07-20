%% Enter animal metadata. You only need to do this once per animal

% Enter animal details using command line. This will save automatically.
% If you make an error, modify struct directly and re-save.

% Select folder to store metadata
cd(uigetdir);
AnimalMetadata = DG_AnimalMetadata();

%% Preprocessing workflow for recorded data

clear

% Select AnimalMetadata file
uiopen;

% Select data file for preprocessing
[file, path] = uigetfile('*.rhd', 'Select an RHD2000 Data File');
[~, basename , ~] = fileparts(file);

% Read the recorded file from disk
DG_read_Intan_RHD2000_file([path, file]);

% At the moment, SmartBox saves 32 channels even if probe is 16 channels. Let's fix this
if strcmp(AnimalMetadata.Probes.ProbeType, 'NRX_A1x16') == 1
   amplifier_data(17:32, :) = [];
end

% Map electrode channels for given probe
amplifier_data = DG_mapChannelsForProbeType(amplifier_data, AnimalMetadata.Probes.ProbeType); 

% Extract LFP. This automatically saves a .lfp.mat file. This file should not be altered. Analyses saved elsewhere.
LFP = DG_getLFP(basename, amplifier_data, time, sampleRate);




