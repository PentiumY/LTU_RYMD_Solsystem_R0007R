function [ax, g, fig] = CreateUi()
    fig = uifigure;

    fig.UserData.paused = false;

    g = uigridlayout(fig,[2 3]);
    g.RowHeight = {'6x', '1x', '1x'};
    g.ColumnWidth = {'1x', '1x', '1x'};
    
    ax = uiaxes(g);
    ax.Layout.Row = 1;
    ax.Layout.Column = [1 3];

    hold(ax, "on");
    grid(ax, "on");
    axis(ax, "equal");
end