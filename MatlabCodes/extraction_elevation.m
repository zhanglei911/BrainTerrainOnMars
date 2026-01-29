%计算获取单个区域的凹陷间距-深度-宽度
function [spacing,width] = extraction_elevation(elevation,RegionWidth,PieceNumber,PointDistance,Ang_each,select)


    [X,Y,Z] = Translate(elevation,1);
   
    [Result_X,Result_Y,Result_Z] = Calculate_XYZ(RegionWidth,PieceNumber,PointDistance,Ang_each,X,Y,Z);

    [Result_S,Result_Width] =  Calculate_spacing(Result_X,Result_Y,Result_Z,Ang_each,PieceNumber,select,PointDistance);
    


    SUM_P = SumCell(Result_S,PieceNumber,'P');
    SUM_A = SumCell(SUM_P,PieceNumber,'A');
    his_data = SUM_A(SUM_A~=0);
    spacing = his_data;
    

    SUM_P = SumCell(Result_Width,PieceNumber,'P');
    SUM_A = SumCell(SUM_P,PieceNumber,'A');
    his_data = SUM_A(SUM_A~=0);
    width = his_data;
    width = width(~isnan(width));
    
end


    
