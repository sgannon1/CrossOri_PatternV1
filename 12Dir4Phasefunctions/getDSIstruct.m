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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Global DSI
    angs = 0:30:330;
    
    for j = 1:nCells
        amps = avg_resp_dir(j,:,1,1,1); %our responses   
        g_dsi(j) = sqrt( sum(sin(1*angs*pi/180).*amps).^2 + sum(cos(1*angs*pi/180).*amps).^2)/sum(amps);
        
        xm = (sum(amps.*cos(deg2rad(1*angs)))/sum(amps)); %mean of the response, x
        ym = (sum(amps.*sin(deg2rad(1*angs)))/sum(amps)); %mean of the response, y
        
        ang(j) = rad2deg(atan(ym/xm)); %preferred direction, in degrees
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
    DSIstruct.DSI       = DSI;  % DSI value, ranging 0 to 1
    DSIstruct.DS_ind    = find(DSI>0.5);    % index of cells meeting criteria DSI>0.5
    DSIstruct.prefDir   = DSI_maxInd;   % index of preferred direction, ranging 1 through nDir
    DSIstruct.gDSI      = g_dsi; %global DSI value, from 0 to 1
    DSIstruct.gDSI_prefDir = ang; %preferred direction, calculated from gDSI
end