function [basis_sym,basis_der_sym] = basisfunction(vertices, basis_type, basis_index, derivative)
% basis function for 1d linear element, r, s are the differential variable
% 101: 1D linear, trial and test are the same
% 102: 1D quadratic
if basis_type == 101
    syms x;
    up_limit = vertices(2); low_limit = vertices(1);
    % basis_index = [1,2], number of local basis functions; 
    psi_n1_sym = (up_limit - x)/ (up_limit - low_limit);
    psi_n2_sym = (x - low_limit)/ (up_limit - low_limit);
    dpsi_n1 = matlabFunction(diff(psi_n1_sym, derivative(1)));
    dpsi_n2 = matlabFunction(diff(psi_n2_sym, derivative(2))); 
    basis_sym = {matlabFunction(psi_n1_sym),matlabFunction(psi_n2_sym)}; 
    basis_der_sym = {dpsi_n1, dpsi_n2};
%elseif basis_type == 102
else 
    massage = "basis type is not supported! ";
    error(massage);
end

end

