function Hwk6Prob5(X_samples,Y_samples)

%% Generate X and Y sequences
n=X_samples;
X_sequences=[];
Y_sequences=[];
for jj=1:Y_samples
    X=randi((0:1),n,1);
    X_sequences=[X_sequences,X];
    Yn=2^n;
    for ii=1:n
        Yn=Yn*X(ii);
    end
    Y_sequences=[Y_sequences;Yn];
end

%% Make plots
% Plot last X Sequence
figure(1);
subplot(2,1,1);
stem((1:length(X)),X(:),'-b','LineWidth',2);
title(['Sample plot of ',num2str(n),' iid equiprobable Bernoulli RVs']);
xlabel('n');
ylabel('Xn');

% Plot Sequence Yn=2^n*X1*X2*...*Xn
subplot(2,1,2);
stem((1:length(Y_sequences)),Y_sequences,'--r','LineWidth',2);
title(['Plot of ',num2str(Y_samples),' sequences of ',...
    num2str(n),' iid Bernoulli RVs']);
xlabel('Y sequence #');
ylabel('Yn')
