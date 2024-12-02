%% Test cases for the gaussquadrature1d
% f_int = @(x) cos(x);
% nogp = 1;
% pred = gaussquadrature1d(nogp, f_int);
% fprintf("Gauss point is %d, Predicted value: %.4f, True value: %.4f\n", nogp,pred, sin(1)-sin(-1)); 

%% Test mesh1d
% [P,T] = mesh1d(1,2,5);
% disp(P); 
% disp(T);


% % Test basisfunction
% y=@(x) 1;
% y(2)
% 
% [a,b] = basisfunction(1,5,1,1);
% z={a,b};
% m=z{1};
% disp(m());

% f=@(x) -exp(x)*(cos(x)-2*sin(x)-x*cos(x)-x*sin(x));
% nogp = 1;
% f(0.5)


