% ZpZc plots for a given cell, each scatter point is 1 plaid phase (4
% total)

function plotZpZc4PhaseCell(ZpZcStruct, iCell)

    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    nPhas   = size(Zp,1);
    
    for im = 1:nPhas
        scatter(Zc(im,iCell), Zp(im,iCell))
        hold on
    end
    ylabel('Zp'); ylim([-4 8]);
    xlabel('Zc'); xlim([-4 8]);
    plotZcZpBorders; set(gca,'TickDir','out'); axis square

end