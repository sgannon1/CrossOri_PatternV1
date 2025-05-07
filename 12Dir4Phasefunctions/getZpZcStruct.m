% Input is avg_resp_dir, nCells x nDir x nMaskPhase x (1: grating, 2:
% plaid) x (1: mean resp, 2: std)

function [ZpZcStruct] = getZpZcStruct(avg_resp_dir, data_type)  

    if nargin < 2 || isempty(data_type)
        data_type = 'whole_cell';
    end

    nCells      = size(avg_resp_dir,1);
    nStimDir    = size(avg_resp_dir,2);
    nMaskPhas   = size(avg_resp_dir,3);
    
    int = 360/size(avg_resp_dir,2);   % Direction step size, in degrees
    if size(avg_resp_dir,2) ~= 12   % Throw error if avg_resp_dir has more or less than 12 directions, next step is hard coded for 120deg plaids
        error('Error in *getZpZcStruct.m* - Hard coded for plaids comprised of gratings at 120 degrees')
    end

% Create pattern and component predictions  
    if strcmp(data_type, 'alignedTestDir')
        component   = avg_resp_dir(:,:,1,1,1)+circshift(avg_resp_dir(:,:,1,1,1),-120./int,2); % component prediction, shift grating resp 120deg and add
        pattern     = circshift(avg_resp_dir(:,:,1,1,1),-60./int,2);    % pattern prediction, shift grating resp 60deg
    elseif strcmp(data_type, 'whole_cell')
        component = circshift(avg_resp_dir(:,:,1,1,1),+60./int,2)+circshift(avg_resp_dir(:,:,1,1,1),-60./int,2);
        pattern = avg_resp_dir(:,:,1,1,1);
    end

% Compute partial correlations   
    comp_corr       = zeros(nMaskPhas,nCells);
    patt_corr       = zeros(nMaskPhas,nCells);
    comp_patt_corr  = zeros(nMaskPhas,nCells);

    for iCell = 1:nCells
        for ip = 1:nMaskPhas
            comp_corr(ip,iCell)         = triu2vec(corrcoef(avg_resp_dir(iCell,:,ip,2,1),component(iCell,:)));
            patt_corr(ip,iCell)         = triu2vec(corrcoef(avg_resp_dir(iCell,:,ip,2,1),pattern(iCell,:)));
            comp_patt_corr(ip,iCell)    = triu2vec(corrcoef(component(iCell,:),pattern(iCell,:)));
        end
    end
    Rp = ((patt_corr)-(comp_corr.*comp_patt_corr))./sqrt((1-comp_corr.^2).*(1-comp_patt_corr.^2));
    Rc = ((comp_corr)-(patt_corr.*comp_patt_corr))./sqrt((1-patt_corr.^2).*(1-comp_patt_corr.^2));
    Zp = (0.5.*log((1+Rp)./(1-Rp)))./sqrt(1./(nStimDir-3));
    Zc = (0.5.*log((1+Rc)./(1-Rc)))./sqrt(1./(nStimDir-3));

% Find PDS and CDS cells
    threshold = 1.28;   % Set threshold, constant
    PDSind_byphase = cell(1, 4);   % Initialize cell array for lists of PDS cell indices
    CDSind_byphase = cell(1, 4);   

    for ip = 1:nMaskPhas
        PDScells            = (Zp(ip, :) > threshold) & (Zp(ip, :) - Zc(ip, :) > threshold);
        PDSind_byphase{ip}  = find(PDScells);
        CDScells            = (Zc(ip, :) > threshold) & (Zc(ip, :) - Zp(ip, :) > threshold);
        CDSind_byphase{ip}  = find(CDScells);
    end
    ind_arrPDS = [PDSind_byphase{:}]; % Combine the individual phase indices into a single array
    PDSind_all = unique(ind_arrPDS);
    ind_arrCDS = [CDSind_byphase{:}]; % Combine the individual phase indices into a single array
    CDSind_all = unique(ind_arrCDS);

    ZpZcStruct.Zp               = Zp;
    ZpZcStruct.Zc               = Zc;
    ZpZcStruct.Rp               = Rp;
    ZpZcStruct.Rc               = Rc;
    ZpZcStruct.PDSind_byphase   = PDSind_byphase;
    ZpZcStruct.CDSind_byphase   = CDSind_byphase;
    ZpZcStruct.PDSind_all       = PDSind_all;
    ZpZcStruct.CDSind_all       = CDSind_all;
    ZpZcStruct.component_pred   = component; %predictions, for plotting on tuning curves
    ZpZcStruct.pattern_pred     = pattern; %predictions, for plotting on tuning curves

end





