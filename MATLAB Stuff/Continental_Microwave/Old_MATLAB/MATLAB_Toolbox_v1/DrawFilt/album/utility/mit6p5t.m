function dr = mit6p5t
    
% mit6p5.m  
%   
%                                                               
% References:
% [1] Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%     Filter Design for Signal Processing Using MATLAB and Mathematica
%     Prentice Hall - ISBN 0-201-36130-2
%     http://www.prenhall.com/lutovac
% [2] Sanjit K. Mitra,
%     Digital Signal Processing Laboratory using MATLAB
%     p. 90, McGraw-Hill, 1999
%                                                                
% call   mit6p5t                           
%   
      
subplot(2,1,1)
dfirtdfa(0,0,4,5,8);

h  = [0.1 0.2 0.4 0.2 0.1];
N = 50;
f1 = 0.05;
f2 = 0.33;
%f1 = 0.05;
%f2 = 0.05;

disp(' ')
disp('------------------------------')
disp(['Length of input signal N = ' num2str(N)]);
disp(['Frequency of first input sinusoidal signal f1 = ' num2str(f1)]);
disp(['Frequency of second input sinusoidal signal f2 = ' num2str(f2)]);
disp(' ')

% Generate the input sinusoidal sequence
n = 0:N-1;
x = sin(2*pi*f1*n) + sin(2*pi*f2*n);
% Generate the output sequence
y = filter(h,1,x);

%Plot the input sequence
subplot(2,2,3)
stem(n,x);
title ('Input sequence x[n]');
xlabel('Index','FontName','Roman'); ylabel('Amplitude','FontName','Roman');
axisfigure1 = axis;
text(1.01*axisfigure1(2), 1.05*axisfigure1(3),'n','FontName','Roman','FontAngle','italic','HorizontalAlignment','left','VerticalAlignment','middle');
hold on
 plot([axisfigure1(1) axisfigure1(2)],[0 0],':');
hold off
axis([axisfigure1(1) axisfigure1(2) 1.1*axisfigure1(3) 1.1*axisfigure1(4)]);

%Plot the output sequence
subplot(2,2,4)
stem(n,y);
title ('Output sequence y[n]');
xlabel('Index','FontName','Roman'); ylabel('Amplitude','FontName','Roman');
text(1.01*axisfigure1(2), 1.05*axisfigure1(3),'n','FontName','Roman','FontAngle','italic','HorizontalAlignment','left','VerticalAlignment','middle');
axis([axisfigure1(1) axisfigure1(2) 1.1*axisfigure1(3) 1.1*axisfigure1(4)]);
hold on
 plot([axisfigure1(1) axisfigure1(2)],[0 0],':');
hold off
