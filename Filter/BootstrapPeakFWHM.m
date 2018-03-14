clear all;
close all;

%%%%%%%%%%%%%%
%Try using bootstrap to estimate the uncertainty of resolution
Spec = textread('Spectrum_1P_ModuleAll.txt');
Spec = Spec(2:end, 2);
E_Bin = 0.25;
E_Range = [1550, 1650];

OriginResult = PeakAnalysis(Spec, E_Bin, [E_Range(1), E_Range(2)]);
disp(OriginResult(2));

BOOTSTRAP_NUM = 2E3;
Spectra_BT = zeros(size(Spec, 1), 1E4);
for i=E_Range(1)/E_Bin : (E_Range(2)+200)/E_Bin
    Spectra_BT(i, :) = poissrnd(Spec(i), 1, 1E4);
end
FWHM_Sim = zeros(BOOTSTRAP_NUM, 1);
for i=1:BOOTSTRAP_NUM
    Output = PeakAnalysis(Spectra_BT(:,i), E_Bin, [E_Range(1), E_Range(2)]);
    FWHM_Sim(i) = Output(2);
end

disp(std(FWHM_Sim));
figure; hist(FWHM_Sim);