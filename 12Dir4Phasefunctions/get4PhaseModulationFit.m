

function [phaseModStruct] = get4PhaseModulationFit(ZpZcStruct)
  
    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    PCI     = Zp-Zc;    % Calculate pattern correlation index
    nCells  = size(Zp,2);

% Fit sinusoid
    phase       = [0 90 180 270];
    phase_range = 0:1:359;
    
    for iCell = 1:nCells
        [b_hat_all(iCell,1), amp_hat_all(iCell,1), per_hat_all(iCell,1),pha_hat_all(iCell,1),sse_all(iCell,1),R_square_all(iCell,1)] = sinefit_PCI(deg2rad(phase),PCI(:,iCell));
        yfit_all(iCell,:,1) = b_hat_all(iCell,1)+amp_hat_all(iCell,1).*(sin(2*pi*deg2rad(phase_range)./per_hat_all(iCell,1) + 2.*pi/pha_hat_all(iCell,1)));
    end

% Add code for FFT


% Make struct
    phaseModStruct.b    = b_hat_all;    % baseline
    phaseModStruct.amp  = amp_hat_all;  % amplitude of fit
    phaseModStruct.per  = per_hat_all;
    phaseModStruct.pha  = pha_hat_all;
    phaseModStruct.sse  = sse_all;
    phaseModStruct.rsq  = R_square_all;
    phaseModStruct.yfit = yfit_all;     % full sinusoid fit for plotting
    phaseModStruct.PCI  = PCI;  % Zp-Zc values at all 4 phases per cell for plotting


end