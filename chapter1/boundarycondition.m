function[A,b]= boundarycondition(nbn, A, b, nodes, BC, ga, gb)
% nbn: number of boundary nodes
    boundary_nodes = zeros(2,nbn);
    if BC == "Dirichlet"
        boundary_nodes(2,1) = nodes(1);
        boundary_nodes(2,2) = nodes(2);
        for k = 1:nbn
            i = boundary_nodes(2,k);
            A(i,:) = 0;
            A(i,i) = 1;
        end
        b(boundary_nodes(2,1)) = ga;
        b(boundary_nodes(2,2)) = gb;
    end
end