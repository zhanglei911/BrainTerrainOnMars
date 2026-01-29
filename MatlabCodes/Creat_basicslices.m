function [X,Y] =  Creat_basicslices(RegionWidth,PieceNumber,PointDistance)


X(PieceNumber) = 0;
Y = X;

for n = 1:PieceNumber
    X(n) = (-RegionWidth/2) + RegionWidth/(PieceNumber-1) * (n-1);
end

l = floor(RegionWidth/PointDistance);
for m = 1:l
    Y(m) = (-RegionWidth/2) + PointDistance * (m-1);
end

