function [] = tcheby_gMatrix_values(varargin)

%
% tcheby_gMatrix_values.m
%

%%
if nargin==2
    passband_ripple=varargin{1};
    num_sec=varargin{2};
elseif nargin==1
    passband_ripple=varargin{1};
    num_sec=20;
else
    passband_ripple=input('Please enter the passband ripple of the filter [dB]: ');
    num_sec=20;
end

%%
beta=log(coth(passband_ripple/17.37));

for n=1:num_sec

    gamma=sinh(beta/(2*n));
    
    for k=1:n
        
        eval(['a',num2str(k),'=sin((((2*k)-1)*pi)/(2*n));']);
        eval(['b',num2str(k),'=gamma^2+(sin((k*pi)/n))^2;']);
 
        %
        if k==1
            g1=(2*a1)/gamma;
            g_matrix(n,1)=g1;
        else   
            eval(['g',num2str(k),'=(4*a',num2str(k-1),'*a',num2str(k),')/(b',num2str(k-1),'*g',num2str(k-1),');']);
            eval(['g_matrix(',num2str(n),',',num2str(k),')=g',num2str(k),';']);
        end
            
        if k==n
            test_even_odd=mod(n,2);
            if test_even_odd==1
                eval(['g',num2str(k+1),'=1;']);
            elseif test_even_odd==0
                eval(['g',num2str(k+1),'=(coth(beta/4))^2;']);
            end
            eval(['g_matrix(',num2str(n),',',num2str(k+1),')=g',num2str(k+1),';']);
        end
        
    end
    
    % Clear re-used variables
    for ii=1:k
        eval(['clear a',num2str(ii),' b',num2str(ii),' g',num2str(ii)])
    end
    eval(['clear g',num2str(ii+1)])
    
end

% Display the element values
disp(g_matrix)
