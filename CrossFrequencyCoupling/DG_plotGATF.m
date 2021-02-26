function DG_plotGATF(phaseFreqs, ampFreqs, MI)

% Create contour plot
figure
set(gcf, 'color', 'w');

contourf(phaseFreqs, ampFreqs, MI, 40, 'LineColor', 'none');    
set(gca,'YDir', 'normal');
xlabel('Phase frequency (Hz)')
ylabel('Amplitude frequency (Hz)')
axis on
box on
colorbar
    
end
