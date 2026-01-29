%计算凹陷占比
function Ratio = Analysis_ratio_single(Elevation,Limit)
    E_in = Elevation(:);
    Lowland = E_in(E_in<Limit);
    Sum = length(E_in);
    Ratio = length(Lowland)/Sum;
end