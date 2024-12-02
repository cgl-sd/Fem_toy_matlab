function [b]=b_assembly_1D(P, T, Tb_test, f, N, nogp)
% assmeble the load vector b
% b_{i}=\int_{a}^{b} f \phi_{i} d x=\sum_{n=1}^{N} \int_{x_{n}}^{x_{n+1}} f \phi_{i} d x

% N: number of elements
% Nb_test: number of test functions for all elements
% Nlb_test: number of test functions for one element
    Nb_test = size(Tb_test,2); Nlb_test = size(Tb_test, 1); 
    b = zeros(Nb_test+1,1); %load vector
    
    for n=1:N
        vertices = P(:, T(:,n));
        [basis, dbasis] = basisfunction(vertices, 101, [1,2],[1,1]);
        xn = P(:, T(1,n)); xn1 = P(:, T(2,n)); % nodes of the element
        x2t = @(x) (xn+xn1)/2+(xn1-xn)/2*x; % transformation function
        % d = zeros(Nlb_test,1); % local load vector
        for beta=1:Nlb_test 
            if nargin(basis{beta})==0
                f_int = @(x) f(x2t(x))*basis{beta}();
            else
                f_int = @(x) f(x2t(x))*basis{beta}(x2t(x));
            end
            value = (xn1-xn) / 2 * gaussquadrature1d(nogp, f_int);
            b(Tb_test(beta,n)) = b(Tb_test(beta,n)) + value;
        end   
    end
end




