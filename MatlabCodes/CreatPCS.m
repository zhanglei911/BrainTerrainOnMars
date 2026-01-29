function PolarCoordinateSystem = CreatPCS(X,Y)

PolarCoordinateSystem = cell(2,length(X));
r_in(length(Y)) = 0;
Angle(length(Y)) = 0;


for i = 1:length(X)
    for j = 1: length(Y)
        r_in(j) = sqrt(X(i)^2+Y(j)^2);
        Angle(j) = atan(Y(j)/X(i));
        if (X(i)<0 && Y(i)<0)
            Angle(j) = Angle(j) + pi;
        end
    end
    PolarCoordinateSystem{1,i} = r_in;
    PolarCoordinateSystem{2,i} = Angle;
    r_in = 0;
    Angle = 0;
end