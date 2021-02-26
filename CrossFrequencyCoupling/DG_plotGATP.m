function DG_plotGATP(phaseBins, ampFreqs, meanAmplitude)
% DG_plotGATP - Create contour plot of results

figure
set(gcf,'color','w');

contourf(phaseBins,  ampFreqs, meanAmplitude, 40, 'LineColor', 'none');    
set(gca,'YDir', 'normal');
xlabel('Phase (degrees)')
ylabel('Amplitude frequency (Hz)')
axis on
box on
colorbar
    
end
