function Trajectory = PredictTrajectory(PlanetMatrix, PredictionDays, timestepConstant, frameRate, timeSpeed)
    % Simulates a trajectory from the set values
    steps = round(PredictionDays / frameRate);
    PredictionMatrix = PlanetMatrix;
    delta_t = frameRate * timeSpeed;

    Trajectory = zeros(steps, size(PlanetMatrix, 1), 2);
    
    for step = 1:steps
        InitialAccelerationMatrix = CalculateAcceleration(PredictionMatrix, timestepConstant);
        
        PredictionMatrix(:, 1:2) = PredictionMatrix(:, 1:2) + PredictionMatrix(:, [3 4]) * delta_t + 0.5 * InitialAccelerationMatrix * delta_t^2;
    
        NewAccelerationMatrix = CalculateAcceleration(PredictionMatrix, timestepConstant);
    
        PredictionMatrix(:, 3:4) = PredictionMatrix(:, 3:4) + 0.5 * (InitialAccelerationMatrix +  NewAccelerationMatrix) * delta_t;
        Trajectory(step,:,1) = PredictionMatrix(:,1);
        Trajectory(step,:,2) = PredictionMatrix(:,2);
    end
end