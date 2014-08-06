function dr = mit6p5
    
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
% call   mit6p5                           
%   
      
subplot(2,1,1)
dfirtdfa(0,0,4,5,8);

h  = [0.1 0.2 0.4 0.2 0.1];
[H,W] = freqz(h,1,512);
subplot(2,2,3)
plot(W/(2*pi),20*log10(abs(H)))
title(['h[0]=' num2str(h(1)) '  h[1]=' num2str(h(2)) '  h[2]=' num2str(h(3))],'FontSize',8)
xlabel('Normalized frequency','FontSize',9);
ylabel('Magnitude (dB)','FontSize',9);
subplot(2,2,4)
plot(W/(2*pi),unwrap(angle(H)))
title(['h[3]=' num2str(h(4)) '  h[4]=' num2str(h(5))],'FontSize',8)
xlabel('Normalized frequency','FontSize',9);
ylabel('Phase (degrees)','FontSize',9);

