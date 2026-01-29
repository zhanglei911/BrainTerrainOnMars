function [X,Y,Z] = Translate(elevation,resolution)


[rows,colums] = size(elevation);
X = [];
Y = [];
Z = [];
n = 1;


for i = 1:rows
    for j = 1:colums
        if isnan(elevation(i,j)) 
            continue;
        else
        X(n) = j*resolution;
        Y(n) = i*resolution;
        Z(n) = elevation(i,j);
        n = n+1;
        end
    end
end

Z = Z';
X = X';
Y = Y';

X = X(~isnan(Z)) ;
Y = Y(~isnan(Z)) ;
Z = Z(~isnan(Z)) ;
end

