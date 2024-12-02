function[Pb,Tb] = basisinformation(intgrate_region, basis_type, Nb)
% create  1d mesh with the number of N, between vertices
% Nb: number of elements
% result: Pb,position of all nodes; Tb, global nodes index within one element 
%         suit for trial and test while 1D
    low_limit = intgrate_region(1); up_limit = intgrate_region(2); 
    if basis_type == 101
        h=(up_limit-low_limit)/Nb;
        Tb = zeros(2,Nb);
        Pb = low_limit:h:up_limit; % length: N+1
        for i = 1:Nb
            Tb(1,i) = i;
            Tb(2,i) = i+1;
        end
    end

end