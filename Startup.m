PlanetName = ["Sun", "Earth", "Moon", "Mars"];

frameRate = 1 / 60;
timestepConstant = 3600 * 24;

timeSpeed = 100;

predictionDays = 30;
referenceBody = 2;

% X Y Vx Vy Mass
PlanetMatrix = [
    0,0, 0,0, 1.989 * 10^30;
    149597870700,0, 0, 2592000000, 5.972 * 10^24;
    149597870700 + 384400000, 0, 0, 2592000000 + 1022 * timestepConstant, 7.34767309*10^22;
    227936637242, 0, 0, 24080 * timestepConstant, 6.41693*10^23;
];

[axis, g, fig] = CreateUi()
CreateUiControls(g, PlanetName)

planetPlot = plot(axis, PlanetMatrix(:,1), PlanetMatrix(:,2), "o");

planetLabels = gobjects(size(PlanetMatrix, 1), 1);

for i = 1:size(PlanetMatrix,1)
    planetLabels(i) = text(axis, PlanetMatrix(i,1), PlanetMatrix(i,2), PlanetName(i), "VerticalAlignment", "bottom", "HorizontalAlignment", "left");
end

Trajectory = PredictTrajectory(PlanetMatrix, predictionDays, timestepConstant, frameRate, timeSpeed);
trajectoryPlots = gobjects(size(PlanetMatrix,1),1);

for i = 1:size(PlanetMatrix, 1)
    relativeX = Trajectory(:,i,1) - Trajectory(:,referenceBody,1);
    relativeY = Trajectory(:,i,2) - Trajectory(:,referenceBody,2);

    trajectoryPlots(i) = plot(axis, relativeX, relativeY, "--");
end

while true
    if fig.UserData.paused == false
        delta_t = frameRate * timeSpeed;
    
        InitialAccelerationMatrix = CalculateAcceleration(PlanetMatrix, timestepConstant);
        
        PlanetMatrix(:, 1:2) = PlanetMatrix(:, 1:2) + PlanetMatrix(:, [3 4]) * delta_t + 0.5 * InitialAccelerationMatrix * delta_t^2;
    
        NewAccelerationMatrix = CalculateAcceleration(PlanetMatrix, timestepConstant);
    
        PlanetMatrix(:, 3:4) = PlanetMatrix(:, 3:4) + 0.5 * (InitialAccelerationMatrix +  NewAccelerationMatrix) * delta_t;
        
        referencePosition = PlanetMatrix(referenceBody, 1:2);
        relativePosition = PlanetMatrix(:, 1:2) - referencePosition;
        
        planetPlot.XData = relativePosition(:,1);
        planetPlot.YData = relativePosition(:,2);
    
        for i = 1:size(PlanetMatrix,1)
            planetLabels(i).Position(1:2) = relativePosition(i,:);
        end
    end
    pause(frameRate);
end