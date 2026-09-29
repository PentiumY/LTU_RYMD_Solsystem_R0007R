function CreateUiControls(g, PlanetNames)
    sld = uislider(g, ...
        "ValueChangedFcn",@(src,event)updateSpeed(src,event));
    sld.Layout.Row = 2;
    sld.Layout.Column = 2; 
    
    b = uibutton(g, ...
        "Text","Toggle Sim", ...
        "ButtonPushedFcn", @toggleSim);
    b.Layout.Row = 2;
    b.Layout.Column = 1;

    rDrop = uidropdown(g, "Items", PlanetNames)
end

function updateSpeed(src,event)
        
end

function toggleSim(src, event)
    disp("toggleSim called")

    fig = ancestor(src, "figure");
    fig.UserData.paused = ~fig.UserData.paused;
end