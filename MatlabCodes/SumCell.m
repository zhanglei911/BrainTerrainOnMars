function Sum_Pieces = SumCell(Result,Pieces,judge)

if judge == 'P'

[l,~] = size(Result);
Sum_Pieces = cell(l,1);

for i = 1:l
    for j = 1:Pieces

          Sum_Pieces{i,1} = [Sum_Pieces{i,1},Result{i,j}];

    end
end

end


if judge == 'A'
Sum_Pieces = [];
l = length(Result);

    for i = 1:l
       
              Sum_Pieces = [Sum_Pieces,Result{i,1}];
    
    end

end