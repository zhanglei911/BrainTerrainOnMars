function PeakWidths = ExtractionWidth(signal,PeakLoc,Limit,PointDistance)
    %输入 切线数据 峰值位置 Limit值
    HeightLimit = Limit; % 设置高度阈值
    PeakWidths = zeros(size(PeakLoc)); 

    for m = 1:length(PeakLoc)
        Ploc = PeakLoc(m);
        left = signal(1:Ploc);
        right = signal(Ploc:end);
        leftCrossings = find(diff(left <= HeightLimit) == -1);
        rightCrossings = find(diff(right <= HeightLimit) == 1);
        if ~isempty(leftCrossings)
            leftIdx = leftCrossings(end); % 取最后一个左侧交点
        else
            % leftIdx = 1; % 没找到则用起点
            PeakWidths(m) = NaN;
            continue;
        end
        if ~isempty(rightCrossings)
            rightIdx = Ploc + rightCrossings(1); % 取第一个右侧交点
        else
            % rightIdx = length(signal); % 没找到则用终点
            PeakWidths(m) = NaN;
            continue;
        end
        WIDTH = (rightIdx - leftIdx).*PointDistance;
        if WIDTH < 20
            PeakWidths(m) = WIDTH;
        else
            PeakWidths(m) = NaN;
        end
    end

end
