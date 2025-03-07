% Input is avg_resp_dir, nCells x nDir x nMaskPhase x (1: grating, 2:
% plaid) x (1: mean resp, 2: std)

function [DSIstruct] = getDSIstruct(avg_resp_dir)
    nCells  = size(avg_resp_dir,1);
    nDir    = size(avg_resp_dir,2);
    for iCell = 1:nCells
        [max_val max_ind]   = max(avg_resp_dir(iCell,:,1,1,1));
        null_ind            = max_ind+(nDir./2);
        null_ind(find(null_ind>nDir)) = null_ind(find(null_ind>nDir))-nDir;
        min_val     = avg_resp_dir(iCell,null_ind,1,1,1);
        if min_val < 0; min_val = 0; end
        DSI(iCell)          = (max_val-min_val)./(max_val+min_val);
        DSI_maxInd(iCell)   = max_ind; 
    end

    % Add global DSI

    DSIstruct.DSI       = DSI;  % DSI value, ranging 0 to 1
    DSIstruct.DS_ind    = find(DSI>0.5);    % index of cells meeting criteria DSI>0.5
    DSIstruct.prefDir   = DSI_maxInd;   % index of preferred direction, ranging 1 through nDir
end