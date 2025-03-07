% Input arguments from function *getAlignedGratPlaidTuning.m*
% where both grating and plaid tuning curves are aligned to "preferred"
% grating

function plotPolarTuning4Phase(gratAligned, plaidAligned, iCell)
    x       = [-150:30:180];
    x_rad   = deg2rad(x);

    for im = 1:4
        polarplot([x_rad x_rad(1)], [plaidAligned(iCell,:,im) plaidAligned(iCell,1,im)])
        hold on
    end
    polarplot([x_rad x_rad(1)], [gratAligned(iCell,:) gratAligned(iCell,1)],'k', 'LineWidth',2) 
end