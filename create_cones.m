lambdas = [400:10:720]';

lambdaMax = 500;
lamb = LambNomogram(lambdas,lambdaMax);

self_screen = @(lamb) 1-10.^(-0.5.*lamb);
macTrans = MacularTransmittance(lambdas, 'Human', 'CIE');
lensTrans = LensTransmittance(lambdas, 'Human', 'CIE');

S_cone = self_screen(LambNomogram(lambdas,430)) .* macTrans .* lensTrans;
M_cone = self_screen(LambNomogram(lambdas,535)) .* macTrans .* lensTrans;
L_cone = self_screen(LambNomogram(lambdas,570)) .* macTrans .* lensTrans;

save('S_cone.mat', 'S_cone');
save('M_cone.mat', 'M_cone');
save('L_cone.mat', 'L_cone');

for i = 400:30:700
Q_cone = self_screen(LambNomogram(lambdas,i)) .* macTrans .* lensTrans;
name = strcat("Q_cone_", int2str(i), ".mat");
save(name, 'Q_cone');

x = 400:10:720;
fig1 = figure;
plot(x, S_cone, 'blue', x, M_cone, 'green', x, L_cone, 'red', x, Q_cone, 'black');
figname = strcat("LMSQ_", int2str(i), ".png");
saveas(fig1,figname);
ylim([0.0 1.0]);
xlim([380 720]);

end

% 
% fig2 = figure;
% plot(x, S_cone, 'blue', x, M_cone, 'green', x, L_cone, 'red', x, Q_cone2, 'black');
% saveas(fig2,'LMSQ2.png');
% ylim([0.0 1.0]);
% xlim([380 720]);
% 
% fig3 = figure;
% plot(x, S_cone, 'blue', x, M_cone, 'green', x, L_cone, 'red', x, Q_cone3, 'black');
% saveas(fig3,'LMSQ3.png');
% ylim([0.0 1.0]);
% xlim([380 720]);


