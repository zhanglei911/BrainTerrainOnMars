function [Result_X,Result_Y,Result_Z] = Calculate_XYZ(RegionWidth,PieceNumber,PointDistance,Ang_each,X,Y,Z)
%计算插值函数
F = scatteredInterpolant(X,Y,Z,"natural");

Result_Z = cell(1,180/Ang_each);
Result_X = cell(1,180/Ang_each);
Result_Y = cell(1,180/Ang_each);

ZoomWidth = RegionWidth/2*sqrt(2);

[X_BASIC,Y_BASIC] = Creat_basicslices(ZoomWidth,PieceNumber,PointDistance);

PCS = CreatPCS(X_BASIC,Y_BASIC);    %将基准剖面族转至极坐标系下

for Ang = Ang_each:Ang_each:180
    

    PCS_s = SpinPCS(PCS,Ang);       %旋转极坐标系下的剖面族              

    Car = TransformPCStoXY(PCS_s,RegionWidth);  %将旋转后的剖面族再转换为笛卡尔坐标系

    %流程：笛卡尔坐标系→极坐标系→旋转→笛卡尔坐标系→griddata插值→旋转→插值

    interp_X = [];
    interp_Y = [];

    for i = 1 : PieceNumber

        interp_X = [interp_X,Car{1,i}];
        interp_Y = [interp_Y,Car{2,i}];
        
    end
   
    % interp_Z = interp2(X,Y,Z,interp_X,interp_Y);
    interp_Z = F(interp_X,interp_Y);
    Result_Z{1,Ang/Ang_each} = interp_Z;
    Result_X{1,Ang/Ang_each} = interp_X;
    Result_Y{1,Ang/Ang_each} = interp_Y;

end


