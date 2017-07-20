function mappedData = DG_mapChannelsForProbeType(data, probeType)

% The arrangement of electrodes on Neuronexus probes vary according to the
% probe. We need to arrange the saved data to map correctly to the spatial
% distribution of electrodes

%data = A data matrix. Each electrode must be on a new row

% Example:
% >> orderedData(data, 'InVitro');

if strcmp(probeType, 'InVitro')
    electrodeMap = [13 10 8 9 12 11 14 15 0 1 4 3 6 7 5 2];
    electrodeMap = electrodeMap + 1;
elseif strcmp(probeType, 'NRX_A1x16')
    electrodeMap = [1 16 2 15 5 12 4 13 7 10 8 9 6 11 3 14];
else
    error('There is no such electrode map by that name')
end

mappedData = data(electrodeMap, :);

end

