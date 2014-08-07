nruns=100;
save_dir='D:\Documents and Settings\clarkss\My Documents\Raytheon\MATLAB\TrackSim\MMsim_output\newtraj3\';
for ii=1:nruns
    [constants radar truthdelete Tlower Tupper kf amm imm detection]=simulate_trackers(constants, radar, truth2);
    save(fullfile(save_dir,strcat('run_',num2str(ii),'_out')), 'amm' , 'imm', 'kf' , 'detection' , 'Tlower' , 'Tupper');
end

