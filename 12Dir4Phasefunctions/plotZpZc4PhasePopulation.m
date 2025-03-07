% Input argument resp_ind is the index of cells that you want plotted

function plotZpZc4PhasePopulation(ZpZcStruct,resp_ind)

    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    PDSind  = ZpZcStruct.PDSind_byphase;
    CDSind  = ZpZcStruct.CDSind_byphase;
    
    phases  = [0, 90, 180, 270];

    figure; 
    movegui('center')
    for phaseIdx = 1:4
        for i = 1:4
            subplot(4,4,i + (phaseIdx-1)*4) % Compute correct subplot index
            scatter(Zc(i,resp_ind), Zp(i,resp_ind),'.')
            hold on
            scatter(Zc(i,PDSind{phaseIdx}), Zp(i,PDSind{phaseIdx}),'.');
            scatter(Zc(i,CDSind{phaseIdx}), Zp(i,CDSind{phaseIdx}),'.');
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

