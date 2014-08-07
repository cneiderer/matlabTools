function [LLratio]= computeLogLikelihoodRatio (prop10sGroup,next10sGroup,prop6sGroup,next6sGroup,detection)

%[LLratio ] = computeLogLikelilhoodRatio(next10sGroup,next6sGroup,detection);
%ratio : boosting over exo

H=[eye(3) zeros(3)];
cons =sqrt(2*pi)^3;
R=diag(detection.ruv_var);
H(1,4)=detection.rdc_time;
PplusR6=H*prop6sGroup.cov_ruv(1:6,1:6)*H'+R;
e6=next6sGroup.residual;

likelihood6s=max(1e-32,(1.0 / (cons* sqrt(det(PplusR6 )))) * exp(-0.5*e6'*inv(PplusR6)*e6));

H=[eye(3) zeros(3,7)];
H(1,4)=detection.rdc_time;
PplusR10=H*prop10sGroup.cov_ruv * H' + R;
e10=next10sGroup.residual;
likelihood10s=max(1e-32,(1.0 / (cons * sqrt(det(PplusR10)) ) ) * exp(-0.5 * e10'*inv(PplusR10)*e10));
LLratio = log(likelihood10s /likelihood6s);

