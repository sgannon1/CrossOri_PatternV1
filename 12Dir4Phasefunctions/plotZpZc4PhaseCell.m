% ZpZc plots for a given cell, each scatter point is 1 plaid phase (4
% total)
% sz input is size of marker points

function plotZpZc4PhaseCell(ZpZcStruct, iCell, sz)
    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    nPhas   = size(Zp,1);
    
    colors  = getColors;

    figure(655 + iCell)
    for im = 1:nPhas
        scatter(Zc(im,iCell), Zp(im,iCell),sz,colors(im,:),'filled')
        hold on
    end
    ylabel('Zp'); ylim([-4 8]);
    xlabel('Zc'); xlim([-4 8]);
    plotZcZpBorders; set(gca,'TickDir','out'); axis square

end