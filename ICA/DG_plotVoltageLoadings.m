function DG_plotVoltageLoadings(voltageLoadings)

figure('units','normalized','outerposition',[0 0 1 0.4])
set(gcf, 'color', 'w');
  
[nElectrodes, nComponents] = size(voltageLoadings);

% Calculate CSD loadings
csdLoadings = -diff(voltageLoadings, 2);
csdSize = size(csdLoadings, 1);

% Normalise voltage loadings
voltageLoadings = voltageLoadings ./ (max(max(voltageLoadings)) - min(min(voltageLoadings)));


% Normalise CSD loadings
csdLoadings = csdLoadings ./ (max(max(csdLoadings)) - min(min(csdLoadings)));

% Calculate min and max voltage loadings
minLoading = min(min(voltageLoadings));
maxLoading = max(max(voltageLoadings));

% Calculate min and max CSD loadings
minCSDLoading = min(min(csdLoadings));
maxCSDLoading = max(max(csdLoadings));

for idx = 1 : nComponents

    % Plot voltage loadings
    subplot(2, nComponents, idx)
    plotLoadings(voltageLoadings(:,idx), minLoading, maxLoading, 1, nElectrodes)
    title(idx)

	% Plot CSD loadings
    subplot(2, nComponents, idx + nComponents)
    plotLoadings(csdLoadings(:,idx), minCSDLoading, maxCSDLoading, 1, csdSize)    
    title(idx)

end

function plotLoadings(data, xMin, xMax, yMin, yMax)
    
    plot(data, (1:length(data))', 'k', 'linewidth', 2)
    hold on
    plot([0 0], [1 length(data)], '--k')
    
    set(gca, 'YDir','reverse')
    box off
    set(gca,'ytick',[])
    set(gca,'YColor','w')
    
    xlim([xMin xMax])
    ylim([yMin yMax])

end
  

end
