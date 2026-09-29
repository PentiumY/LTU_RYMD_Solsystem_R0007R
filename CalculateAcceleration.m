function AccelerationMatrix = CalculateAcceleration(PlanetMatrix, timestepConstant)
    %Calculates the matrix of acceleration between planets
    G = 6.67*10^-11;
    AccelerationMatrix = zeros(size(PlanetMatrix,1), 2);

    for i = 1:size(PlanetMatrix,1)
        for j = 1:size(PlanetMatrix, 1)
            if i ~= j
                planet1 = PlanetMatrix(i, 1:5);
                planet2 = PlanetMatrix(j, 1:5);
    
                direction = (planet1([1 2]) - planet2([1 2])) / (norm(planet1([1 2]) - planet2([1 2])));
                distance = norm(planet1([1 2]) - planet2([1 2]));
    
                force = G*((planet1(5) * planet2(5))/distance^2);
                acceleration = (force / planet1(5)) * timestepConstant^2;
                accelerationVector = -direction * acceleration;
    
                AccelerationMatrix(i, :) = AccelerationMatrix(i, :) + accelerationVector;
            end
        end
    end
end