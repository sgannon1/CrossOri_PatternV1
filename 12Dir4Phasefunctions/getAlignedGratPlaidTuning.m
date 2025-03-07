% Input is avg_resp_dir, nCells x nDir x nMaskPhase x (1: grating, 2:
% plaid) x (1: mean resp, 2: std)

% This function aligns all grating and plaid responses to preferred grating
% direction (computed simply as max avg response across nDirs)

function [gratAligned, plaidAligned] = getAlignedGratPlaidTuning(avg_resp_dir)
    
    nCells      = size(avg_resp_dir,1);
    nMaskPhas   = size(avg_resp_dir,3);
   
    int = 360/size(avg_resp_dir,2);   % Direction step size, in degrees

    respgrat = avg_resp_dir(:,:,1,1,1);     % Get grating responses only
    [prefresp, prefdir] = max(respgrat,[],2);   % Find preferred grating direction
    vecshift = zeros(size(respgrat,1),1)+6; 
    vecshift = vecshift - prefdir;
    respplaid = avg_resp_dir(:,:,:,2,1);
    
    gratAligned =[];
    plaidAligned = [];
    
    for iCell = 1:size(respgrat,1)
        gratAligned(iCell,:) = circshift(respgrat(iCell,:),vecshift(iCell),2);
        for i = 1:nMaskPhas
            plaidAligned(iCell,:,i) = circshift(respplaid(iCell,:,i),vecshift(iCell)+(60./int),2);
        end
    end

end