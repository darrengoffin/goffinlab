function DG_plotGATP(GATP)
% DG_plotGATP - Create contour plot of results

figure
set(gcf,'color','w');

contourf(GATP.phaseBins,  GATP.ampFreqs, GATP.meanAmplitude, 40, 'LineColor', 'none');    
set(gca,'YDir', 'normal');
xlabel('Phase (degrees)')
ylabel('Amplitude frequency (Hz)')
axis on
box on
colorbar
    
end
