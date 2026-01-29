function [Concentration,Height] = Calculate_StoneHeight(angle,ratio)

    stone_density = 2e3;                            %石块密度:kg/m3
    R = 0:0.01:0.5;                                 %圆锥地面半径
    S_button = pi.*R.*R;                            %圆锥底面积
    H = R.*tan(pi/180*angle);                       %圆锥高度
    T = S_button/3.*H;                              %圆锥体积
    T_stone = T.*ratio;                             %对应的石块体积：圆锥体积*空间利用率
    Concentration= T_stone.*stone_density;          %圆锥对应的石块质量，由于限定了空间尺度为一平米，数值上等于质量浓度。
    Height = H;

end




