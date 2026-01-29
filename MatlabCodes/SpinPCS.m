function PCS_spined = SpinPCS(PCS,ang)

PCS_spined = cell(2,length(PCS));
l = length(PCS);

for i = 1:l
    PCS_spined{1,i} = PCS{1,i};
    PCS_spined{2,i} = PCS{2,i} - pi/180 * ang;
end
