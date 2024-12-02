%% - \frac{d} {d x} \left( e^{x} \frac{d u ( x )} {d x} \right) =
%% -e^{x} \left[cos(x) -2 sin(x) -xcos(x) - xsin(x) \right] (x \in [0,1])
%% u(0) = 0, u(1) = cos(1)
%% analytic solution: u(x) = xcos(x)
clear;
c=@(x) exp(x);
f=@(x) -exp(x)*(cos(x)-2*sin(x)-x*cos(x)-x*sin(x));
low_limit = 0;
up_limit = 1;

N = 4;
Nb = N;
nogp = 3;
region = [low_limit, up_limit];
[P,T] = mesh1d(region, N);
[Pb_trail, Tb_trial] = basisinformation(region, 101,  Nb);
[Pb_test, Tb_test]   = basisinformation(region, 101,  Nb);

BC = "Dirichlet"; % boundary condition type
ga=0; gb=cos(1); % boundary condition
nbn = 2; % number of boundary nodes
nodes = [1, N+1]; % boundary nodes ID

A = A_assembly_1D(P, T, Tb_trial, Tb_test, c, N, nogp);
b = b_assembly_1D(P, T, Tb_test, f, N, nogp);
[A,b] = boundarycondition(nbn, A, b, nodes, BC, ga, gb);

solution = A\b;
% disp(solution);
%% true solution
u = @(x) x*cos(x);
test_points = low_limit:(up_limit-low_limit)/(N): up_limit;
true_values = arrayfun(u,test_points); 

%% plot 
% disp(Pb_trail)
figure('visible','off');
plot(Pb_trail, solution, 'ro', test_points, true_values, 'b', 'LineWidth', 1.5); 
xlabel('PDE X');
ylabel('PDE Value');
title('FEM VS True');
legend('FEM', 'True','Location','southeast');
saveas(gcf, 'Results.png'); 
