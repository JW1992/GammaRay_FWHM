clear all;
close all;

set(0,'defaultAxesFontSize', 20);
set(0,'defaultTextFontSize', 20);

Energy = [81, 303, 356, 384, 662, 1173, 1198, 1275, 1332, 1592, 2614];

% 2018 Jan data for Co60, Na22, PuBe-Hydrogen
Res_1P_All = [3.51,1.09,0.89,0.83,0.53,0.42,0.39,0.39,0.39,0.31,0.27];

% 2018 Feb data for Co60, Na22, PuBe-Hydrogen
% Res_1P_All = [3.51,1.09,0.89,0.83,0.53,0.46,0.44,0.43,0.41,0.31,0.27];

% Res_PerfectTheory = @(E) 100*sqrt((2.3./E).^2+2.35^2*0.1*0.005./E);
Res_PerfectTheory = @(E) 100*sqrt((2.8./E).^2+2.35^2*0.1*0.005./E);

figure; hold on;
errorbar(Energy, Res_1P_All, 0.25./Energy*100, 'b*-');
plot(Energy, Res_PerfectTheory(Energy), 'r');
xlabel('Energy (keV)');
ylabel('Resolution FWHM (%)');
