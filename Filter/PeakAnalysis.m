function Outputs = PeakAnalysis(Spectrum, Bin, PeakRegions)

%This function uses simple pedestal subtraction and Gaussian fitting to
%estimate the FWHM and peak centroid of a peak.
%Inputs required: spectrum, bin width, peak reghions of interest
%Outpus: FWHM, relative FWHM, peak centroids of all peaks.

if size(PeakRegions, 2) ~= 2
    Outputs = zeros(1,1);
    return;
end
if size(Spectrum, 2) == 1
    Spectrum = Spectrum';
end

ERange = size(Spectrum, 2)*Bin;
Outputs = zeros(size(PeakRegions, 1), 3);


% figure(101)
% hold on
% stairs(Bin:Bin:ERange, Spectrum, 'b');
for i = 1:size(PeakRegions, 1)
    meanL = mean(Spectrum(PeakRegions(i,1)/Bin-10:1:PeakRegions(i,1)/Bin));
    meanU = mean(Spectrum(PeakRegions(i,2)/Bin:1:PeakRegions(i,2)/Bin+10));
    ClearSpec = Spectrum - (meanL+meanU)/2;
    maxIndex = 0;
    maxCount = 0;
    for j=PeakRegions(i,1)/Bin:PeakRegions(i,2)/Bin
        if maxCount<ClearSpec(j)
            maxCount = ClearSpec(j);
            maxIndex = j;
        end
    end
    PeakHigh = 0;
    PeakLow = 0;
    for j = maxIndex:PeakRegions(i,2)/Bin
        if ClearSpec(j)<=maxCount/2
            PeakHigh = j-(maxCount/2-ClearSpec(j))/(ClearSpec(j-1)-ClearSpec(j));
            break;
        end
    end
    for j = PeakRegions(i,1)/Bin:maxIndex
        if ClearSpec(j)>=maxCount/2
            PeakLow = j-(ClearSpec(j)-maxCount/2)/(ClearSpec(j)-ClearSpec(j-1));
            break;
        end
    end
    Outputs(i, 1) = (PeakHigh-PeakLow - Bin/2)*Bin;
    Outputs(i, 2) = Outputs(i, 1)/(maxIndex*Bin)*100;
    Outputs(i, 3) = maxIndex*Bin;
end


return;