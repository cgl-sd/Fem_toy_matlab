function [A]=A_assembly_1D(P, T, Tb_trial, Tb_test, c, N, nogp)
% assemble the stiffness matrix A
% a_{i j}=\sum_{n=1}^{N} \int_{x_{n}}^{x_{n+1}} c \phi_{j}^{\prime} \phi_{i}^{\prime} d x=0 
% N: number of elements
% Nb_trial: number of trial functions
% Nb_test: number of test functions  
    Nb_trial = size(Tb_trial,2);  Nb_test = size(Tb_test,2);
    Nlb_trial = size(Tb_trial,1); Nlb_test = size(Tb_test,1);
    A = sparse(Nb_test+1, Nb_trial+1); % sparse matrix Nb_trial*Nb_test

    for n=1:N
        vertices = P(:, T(:,n));
        [basis_trial, dbasis_trial] = basisfunction(vertices, 101, [1,2],[1,1]);
        [basis_test, dbasis_test] = basisfunction(vertices, 101, [1,2],[1,1]);
        x2t = @(x) (vertices(1)+vertices(2))/2+(vertices(2)-vertices(1))/2*x; % transformation function
        % S = zeros(Nlb_test,Nlb_trial); % local stiffness matrix
        
        for alpha=1:Nlb_trial
            for beta=1:Nlb_test
                if nargin(dbasis_trial{alpha})==0 % actually only equal 0 in this condition
                    f_int = @(x) c(x2t(x))*dbasis_trial{alpha}()*dbasis_test{beta}();
                else
                    f_int = @(x) c(x2t(x))*dbasis_trial{alpha}(x2t(x))*dbasis_test{beta}(x2t(x));
                end
                % S(beta,alpha) = (vertices(2)-vertices(1))/2 * gaussquadrature1d(nogp, f_int);
                value = (vertices(2)-vertices(1))/2 * gaussquadrature1d(nogp, f_int);
                %disp(Tb(alpha,n));disp(Tb(beta,n));
                A(Tb_test(alpha,n),Tb_trial(beta,n)) = A(Tb_test(alpha,n),Tb_trial(beta,n)) + value;
            end  
        end 
    end

end