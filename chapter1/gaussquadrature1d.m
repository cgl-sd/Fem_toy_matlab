% gauss quadrature
% \int_{-1}^{1} f ( \xi) \mathrm{d} \xi=
% \sum_{j=1}^{n} f ( \xi_{j} ) w_{j}+O \left( \frac{\mathrm{d}^{2 n} f} {\mathrm{d} \xi_{2 n}} \right) 

function [intg_result]=gaussquadrature1d(nogp, f_int)
% number of gauss points upto 5
gp1=[0]; w1=[2];
gp2=[1/sqrt(3), -1/sqrt(3)]; w2=[1, 1];
gp3=[sqrt(3/5), 0, -sqrt(3/5)]; w3=[5/9, 8/9, 5/9];

gp4_a = sqrt(4.8); 
gp4=[sqrt((3+gp4_a)/7),sqrt((3-gp4_a)/7),-sqrt((3-gp4_a)/7),-sqrt((3+gp4_a)/7)];
w4=[1/2-1/(3*gp4_a),1/2+1/(3*gp4_a),1/2+1/(3*gp4_a),1/2-1/(3*gp4_a)];

gp5_a = sqrt(1120); gp5_b=(70+gp5_a)/126; gp5_c=(70-gp5_a)/126; gp5_d = 1/(15*(gp5_c-gp5_b));
gp5=[sqrt(gp5_b),sqrt(gp5_c),0,-sqrt(gp5_c),-sqrt(gp5_b)];
w5_1 = ((5*gp5_c-3)*gp5_d/gp5_b); w5_2 = ((3-5*gp5_b)*gp5_d/gp5_c); w5_3 = 2-2*(w5_1+w5_2);
w5_4 = ((3-5*gp5_b)*gp5_d/gp5_c); w5_5 = ((5*gp5_c-3)*gp5_d/gp5_b);
w5 = [w5_1,w5_2,w5_3,w5_4,w5_5];

gps = {gp1,gp2,gp3,gp4,gp5};
ws = {w1,w2,w3,w4,w5};
xi = gps{nogp};
w = ws{nogp};


x = zeros(1,nogp);
for i=1:nogp
    x(i) = f_int(xi(i));
    % fprintf('Guass point %d: location, %.4f\t; value,%.2f\t; weight: %.4f\n', i, xi(i), x(i), w(i));
end

intg_result = sum(x.*w);
end     

