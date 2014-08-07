function [t_f,y_f]=runge_kutta_4v2(fun,t0,y0,t_f,num_steps,radar,constants)
%
% Runge-Kutta 4th order integration.
%
c1=(-0.5+1/sqrt(2));
c2=(1-1/sqrt(2));
c3=(1+1/sqrt(2));
c4=2*(1-1/sqrt(2));

dt=(t_f-t0)/num_steps;

y_m=y0;
t_m=t0;

if(strcmp(fun,'propagate_6'))
    for index=1:num_steps
        f1=propagate_6(t_m,y_m,radar,constants);%f1(1:6)
        f2=propagate_6(t_m+0.5*dt,y_m+0.5*dt*f1,radar,constants);%f2(1:6)
        f3=propagate_6(t_m+0.5*dt,y_m+c1*dt*f1+c2*dt*f2,radar,constants);%f3(1:6)
        f4=propagate_6(t_m+dt,y_m-(sqrt(2)/2)*dt*f2+c3*dt*f3,radar,constants);%f4(1:6)
        y_m=y_m+(1/6)*dt*(f1+c4*f2+2*c3*f3+f4);
        t_m=t_m+dt;
    end
elseif(strcmp(fun,'propagate_8b'))
    for index=1:num_steps
        f1=propagate_8b(t_m,y_m,radar,constants);%f1(1:6)
        f2=propagate_8b(t_m+0.5*dt,y_m+0.5*dt*f1,radar,constants);%f2(1:6)
        f3=propagate_8b(t_m+0.5*dt,y_m+c1*dt*f1+c2*dt*f2,radar,constants);%f3(1:6)
        f4=propagate_8b(t_m+dt,y_m-(sqrt(2)/2)*dt*f2+c3*dt*f3,radar,constants);%f4(1:6)
        y_m=y_m+(1/6)*dt*(f1+c4*f2+2*c3*f3+f4);
        t_m=t_m+dt;
    end
elseif(strcmp(fun,'propagate_10b'))
    for index=1:num_steps
        f1=propagate_10b(t_m,y_m,radar,constants);%f1(1:6)
        f2=propagate_10b(t_m+0.5*dt,y_m+0.5*dt*f1,radar,constants);%f2(1:6)
        f3=propagate_10b(t_m+0.5*dt,y_m+c1*dt*f1+c2*dt*f2,radar,constants);%f3(1:6)
        f4=propagate_10b(t_m+dt,y_m-(sqrt(2)/2)*dt*f2+c3*dt*f3,radar,constants);%f4(1:6)
        y_m=y_m+(1/6)*dt*(f1+c4*f2+2*c3*f3+f4);
        t_m=t_m+dt;
    end
else
    error('bad');
end

t_f=t_m;
y_f=y_m;