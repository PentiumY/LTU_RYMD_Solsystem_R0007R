point1 = [0,0, 0,0, 1.989 * 10^30];
point2 = [149597870700,0, 0, 30000, 5.972 * 10^24];

G = 6.67*10^-11;

fakepoint = [0,0];

figure(1);

while true

    direction = (point1([1 2]) - point2([1 2])) / norm(point1([1 2]) - point2([1 2]));
    distance = norm(point1([1 2]) - point2([1 2]));

    force = G*((point1(5) * point2(5))/distance^2);

    acceleration1 = force / point1(5);
    accelerationVector1 = -direction * acceleration1;

    acceleration2 = force / point2(5);
    accelerationVector2 = direction * acceleration2;

    point1([3 4]) = point1([3 4]) + accelerationVector1;
    point2([3 4]) = point2([3 4]) + accelerationVector2;

    point1([1 2]) = point1([1 2]) + point1([3 4]);
    point2([1 2]) = point2([1 2]) + point2([3 4]);

    plot(point1(1), point1(2), "o");
    hold on;
    plot(point2(1), point2(2), "o");
    hold off;

    axis([(-0.1 * 10^10) (0.1 * 10^10) (-0.1 * 10^10)  (0.1 * 10^10)] * 1000)

    pause(0.000001);
end