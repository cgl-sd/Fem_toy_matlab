function[P,T] = mesh1d(region, N)
% create  1d mesh with the number of N, between low_limit and up_limit
% N: number of elements
% result: P,position of all nodes; T, global nodes index within one mesh
    low_limit = region(1); up_limit = region(2);
    h=(up_limit-low_limit)/N;
    T = zeros(2,N);
    P = low_limit:h:up_limit; %（1, N+1）
    for i = 1:N
        T(1,i) = i;
        T(2,i) = i+1;
    end

end