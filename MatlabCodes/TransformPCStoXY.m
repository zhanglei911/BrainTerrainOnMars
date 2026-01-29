function Cartesian = TransformPCStoXY(PCS,ResgionWidth)


Cartesian = cell(2,length(PCS));

for i = 1:length(PCS)

    for j = 1: length(PCS{1,1})
        Cartesian{1,i}(j) = PCS{1,i}(j) * cos(PCS{2,i}(j))+ResgionWidth/2;
        Cartesian{2,i}(j) = PCS{1,i}(j) * sin(PCS{2,i}(j))+ResgionWidth/2;
    end

end

