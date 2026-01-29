function dis = points_distance(tloc)


l = length(tloc);
dis = zeros(1,length(l)-1);


for n = 1:(l-1)
        x1 = tloc(n);
        x2 = tloc(n+1);
        dis(n) = x2-x1;
end

end
