% Input argument resp_ind is the index of cells that you want plotted

function plotZpZc4PhasePopulation(ZpZcStruct, resp_ind, sz)

    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    PDSind  = ZpZcStruct.PDSind_byphase;
    CDSind  = ZpZcStruct.CDSind_byphase;
    
    phases  = [0, 90, 180, 270];

    colors = [
        194, 194, 194;  % light gray
        75, 0, 161;     % purple
        150, 150, 150;  % dark gray
        ] / 255; % Normalize to [0,1]

    figure; 
    movegui('center')
    for phaseIdx = 1:4
        for i = 1:4
            subplot(4,4,i + (phaseIdx-1)*4) % Compute correct subplot index
            scatter(Zc(i,resp_ind), Zp(i,resp_ind),sz, colors(1,:),"filled")
            hold on
            scatter(Zc(i,PDSind{phaseIdx}), Zp(i,PDSind{phaseIdx}),sz, colors(2,:),"filled");
            scatter(Zc(i,CDSind{phaseIdx}), Zp(i,CDSind{phaseIdx}),sz, colors(3,:),"filled");
            xlabel('Zc')
            ylabel('Zp')
            ylim([-4 8])
            xlim([-4 8])
            if i == 1
                title(['Pattern cells at ', num2str(phases(phaseIdx))]);
            end
            plotZcZpBorders
        end
    end

end

