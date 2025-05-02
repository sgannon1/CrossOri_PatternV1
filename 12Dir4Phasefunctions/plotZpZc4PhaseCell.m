% ZpZc plots for a given cell, each scatter point is 1 plaid phase (4
% total)
% sz input is size of marker points
%iCell is a nx1 vector specifying the cells you would like to plot
%plot_type spceifies whether you would like separate figures or a single figure with subplots for each cell

function plotZpZc4PhaseCell(ZpZcStruct, iCell, sz, plot_type)
    Zp      = ZpZcStruct.Zp;
    Zc      = ZpZcStruct.Zc;
    nPhas   = size(Zp,1);
    
    colors  = getColors;
    ncells = length(iCell);
    plot_type = lower(plot_type);

    if nargin < 4
        plot_type = '';
    end

    if strcmp(plot_type, 'separate')
        for j = 1:ncells
            figure(655 + j); clf
            for im = 1:nPhas
                scatter(Zc(im,iCell(j)), Zp(im,iCell(j)),sz,colors(im,:),'filled')
                hold on
            end
            ylabel('Zp'); ylim([-4 8]);
            xlabel('Zc'); xlim([-4 8]);
            plotZcZpBorders; set(gca,'TickDir','out'); axis square
        end
    else
        figure
        for j = 1:ncells
            subplot(ncells, 1, j)
        
            for im = 1:nPhas
                scatter(Zc(im,iCell(j)), Zp(im,iCell(j)),sz,colors(im,:),'filled')
                hold on
            end
            ylabel('Zp'); ylim([-4 8]);
            xlabel('Zc'); xlim([-4 8]);
            plotZcZpBorders; set(gca,'TickDir','out'); axis square
        end
    end
end