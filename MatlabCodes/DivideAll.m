function R = DivideAll (Result,Piece)

R = cell(1,Piece);

l = length(Result);

for i = 1:Piece
    
    r_in = Result(1+(l/Piece)*(i-1):l/Piece*i);
    R{1,i} = r_in;

end

