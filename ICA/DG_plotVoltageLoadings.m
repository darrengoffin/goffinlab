function [lfpResult, csdResult] = DG_plotVoltageLoadings(voltageLoadings)

figure('units','normalized','outerposition',[0 0 1 0.4])
set(gcf, 'color', 'w');
  
[~, nComponents] = size(voltageLoadings);

for idx = 1 : nComponents

    % Normalise voltage loadings
    current = voltageLoadings(:,idx);
    current = smooth(current, 3);
	current = current ./ max(abs(current));

    lfpResult(:, idx) = current;

    % Plot voltage loadings
    subplot(2, nComponents, idx)
    plotLoadings(current)
    title(idx)
    
    % Normalise CSD loadings
    current = -diff(current, 2);
    current = smooth(current, 3);
    current = current ./ max(abs(current));


	csdResult(:, idx) = current;

	% Plot CSD loadings
    subplot(2, nComponents, idx + nComponents)
    plotLoadings(current)    
    title(idx)

end

function plotLoadings(data)
    
    plot(data, (1:length(data))', 'k', 'linewidth', 2)
    hold on
    plot([0 0], [1 length(data)], '--k')
    
    set(gca, 'YDir','reverse')
    box off
    set(gca,'ytick',[])
    set(gca,'YColor','w')
    
    xlim([-1.1 1.1])

end
  

end
