clc
clear
close all

syms x
tic
li6_mass = 6.015;
li7_mass = 7.016;

li_6_percent = zeros(170,1);
li_7_percent = zeros(170,1);

li_6_percent(1,1) = 0.0759;
li_7_percent(1,1) = 0.9241;

alpha = 1.03;

xf = zeros(170,1);
xp = zeros(169,1);
xw = zeros(169,1);


xf(1,1) = 0.06578;

for i = 2:170
    num = 1.03*(li_6_percent(i-1,1)/li_7_percent(i-1,1));
    eqn = (x/(1-x)) == num;
    S = solve(eqn,x);
    li_6_percent(i,1) = S;
    li_7_percent(i,1) = 1-S;

    xf(i,1) = (li_6_percent(i,1)*6.015)/((li_6_percent(i,1)*6.015)+(7.016*li_7_percent(i,1)));


end
xp = xf(2:170,1);
xw = 0.05*xf;

toc
%% 
tic

SWU_P = zeros(170,1);

SWU_P(1,1) = (1-2*xp(1,1))*log((1-xp(1,1))/xp(1,1)) + log((1-xw(1,1))/(xw(1,1)))*(1-2*xw(1,1))*((xp(1,1)-xf(1,1))/(xf(1,1)-xw(1,1))) - (log(((1-xf(1,1))/xf(1,1))))*(1-2*xf(1,1))*((xp(1,1)-xw(1,1))/(xf(1,1)-xw(1,1))) ;

for j = 2:169

    SWU_P(j,1) = (1-2*xp(j,1))*log((1-xp(j,1))/xp(j,1)) + log(((1-xw(j,1))/(xw(j,1))))*(1-2*xw(j,1))*((xp(j,1)-xf(j,1))/(xp(j,1)-xw(j,1))) - (log(((1-xf(j,1))/xf(j,1))))*(1-2*xf(j,1))*((xp(j,1)-xw(j,1))/(xf(j,1)-xw(j,1))) ;





end


toc
%% 
tic
total_kg = sum(SWU_P(1:124,1));

round(total_kg,2)


toc

%% 
tic
yaxis = zeros(170,1);
for k = 1:170

    yaxis(k,1) = sum(SWU_P(1:k,1));


end

plot(li_6_percent,yaxis);


ylabel("Total SWU/P")
xlabel("Li6 Percentage")








toc




