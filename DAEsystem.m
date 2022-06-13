clear 
clc
close all

%Matlab solve 单摆运动

syms x(t) y(t) T(t) m r g %定义变量

eqn1 = m*diff(x(t),2) == T(t)/r*x(t); %力矩
eqn2 = m*diff(y(t), 2) == T(t)/r*y(t) - m*g;
eqn3 = x(t)^2 + y(t)^2 == r^2;
eqns = [eqn1 eqn2 eqn3];


vars = [x(t); y(t); T(t)];
origVars = length(vars);
%%check incidnece 查看变量

%M = incidenceMatrix(eqns,vars);

%isLowIndexDAE(eqns,vars) check if the order is 1 or higher. 1 order =1

%Reduce the differential equation order
%maximum is 1
[eqns,vars] = reduceDifferentialOrder(eqns,vars);

%continue reduce the order
[DAEs,DAEvars] = reduceDAEIndex(eqns,vars);

[DAEs,DAEvars] = reduceRedundancies(DAEs,DAEvars);

%isLowIndexDAE(DAEs,DAEvars)


%Solving Use mass matrix solvers
% [M,f] = massMatrixForm(DAEs,DAEvars);


%Step 4
pDAEs = symvar(DAEs);
pDAEvars = symvar(DAEvars);
extraParams = setdiff(pDAEs,pDAEvars) %setdiff


%M = odeFunction(M, DAEvars);  %M矩阵里没有变量 直接转换

f = daeFunction(DAEs,DAEvars,g,m,r);

g = 9.81;
m = 1;
r = 1;
F = @(t,Y,YP) f(t,Y,YP,g,m,r);
%%finding initial condition

%check variables
%DAEvars


y0est = [r*sin(pi/6); -r*cos(pi/6); 0; 0; 0; 0; 0];
yp0est = zeros(7,1);


%set 精度
opt = odeset('RelTol', 10.0^(-7),'AbsTol',10.0^(-7));


% implicitDAE = @(t,y,yp) M(t,y)*yp - F(t,y);
[y0,yp0] = decic(F,0,y0est,[],yp0est,[],opt)

%[y0_new,yp0_new] = decic(odefun,t0,y0,fixed_y0,yp0,fixed_yp0,options)

opt = odeset(opt, 'InitialSlope', yp0);
%Now create an option set that contains the mass matrix M 
% of the system and the vector yp0 of consistent initial values 
% for the derivatives. 
% You will use this option set when solving the system.

[tSol,ySol] = ode15i(F,[0 0.5],y0,yp0,opt);
plot(tSol,ySol(:,1:origVars),'LineWidth',2)

for k = 1:origVars
  S{k} = char(DAEvars(k));
end

legend(S,'Location','Best')
grid on
% set r =2 
% r = 2;
% 
% F = @(t, Y) f(t, Y, g, m, r);
% y0est = [r*sin(pi/6); -r*cos(pi/6); 0; 0; 0; 0; 0];
% implicitDAE = @(t,y,yp) M(t,y)*yp - F(t,y);
% [y0, yp0] = decic(implicitDAE, 0, y0est, [], yp0est, [], opt);
% 
% opt = odeset(opt, 'InitialSlope', yp0);

% [tSol,ySol] = ode15s(F, [0, 0.5], y0, opt);
% plot(tSol,ySol(:,1:origVars),'-o')
% 
% for k = 1:origVars
%   S{k} = char(DAEvars(k));
% end
% 
% legend(S, 'Location', 'Best')
% grid on
