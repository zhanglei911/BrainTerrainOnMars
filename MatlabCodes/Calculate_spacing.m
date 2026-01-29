function [Result_S,Result_Width] = Calculate_spacing(Result_X,Result_Y,Result_Z,Ang_each,PieceNumber,SelectOrNot,PointDistance)

Result_S = cell(180/Ang_each,PieceNumber);
Result_Width = cell(180/Ang_each,PieceNumber);

for i = 1:180/Ang_each

    interp_z = DivideAll(Result_Z{1,i},PieceNumber);
    interp_x = DivideAll(Result_X{1,i},PieceNumber);
    interp_y = DivideAll(Result_Y{1,i},PieceNumber);

    for j = 1:PieceNumber
        %对每一个切片得到的曲线进行操作:
        % 预处理：去趋势 去均值
        % z_d = detrend(interp_z{1,j});       %进行去趋势处理
        % z_d = z_d - mean(z_d);              %进行去均值
        % 
        %预处理：获得正负峰值的位置，在直线的坐标系下；
        % PL中的值表示interp_z中的第几个值是峰值(代表谷值)
        z_d = interp_z{1,j};

        [ntop,npl,npw,npp] = findpeaks(-z_d,'Annotate','extents','WidthReference','halfheight'); 
        %预处理：筛选去除过小的峰或谷，获取筛选后的TOP与PL
        if SelectOrNot ~= 0
            [~,PL,~,~] = SelectPeaks(ntop,npl,npw,npp,SelectOrNot);
            %进行筛选 去除微小的扰动 峰日珥小于slect的峰
        end
        
        if length(PL) <=1
            T = [];
        else
        %计算：槽间距
            peak_tloc = PL;                  %换算峰的真实坐标,在全局坐标系下
            T = points_distance(peak_tloc).*PointDistance;                               %  计算出槽间距(周期)
        end
        Result_S{i,j} = T;
        Result_Width{i,j} = ExtractionWidth(-z_d,PL,SelectOrNot,PointDistance);
       
    end

end





