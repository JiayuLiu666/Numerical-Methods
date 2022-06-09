function  [x,y] = Euler(f,a,b,ya,m)
% Input: f is the handle of anonymous function
%        a and b are the left and right end points
%        ya is the initial condition y(a)
%        m is the number of steps
% Output: E=[x,y], where x is the vector of abscissas and y is the vector of ordinates
             
h=(b-a)/m; % h is the step
y=zeros(m+1,1); % memory allocation, zero column vector
x=(a:h:b)';     % column vector of abscissas
y(1)=ya;
    for j=1:m
    y(j+1)=y(j)+h*f(x(j),y(j)); % Euler's formula
    end;
% E = [x,y];
