function mc_amm_tt(num_runs,radar,truth)


save_dir='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output\newtraj3\';

e2b=[];
b2e=[];
e2m=[];
m2e=[];

for ii=1:100
    load(fullfile(save_dir,strcat('run_',num2str(ii),'_out.mat')));
    e2b=[e2b; amm.e2b];
    b2e=[b2e; amm.b2e];
    e2m=[e2m; amm.e2m];
    m2e=[m2e; amm.m2e];
end
