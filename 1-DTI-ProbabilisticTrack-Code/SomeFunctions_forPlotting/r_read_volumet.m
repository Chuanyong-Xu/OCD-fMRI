clc
clear all
matdir = uigetdir('','select data folder');
mat = dir([matdir,filesep,'sub*']);
t=0;
for i=1:length(mat);
    t=t+1;
    SubName = mat(i).name;
    cd (SubName);
    v=spm_vol([SubName,'_4DVolume.nii']);
    result{t,1}=length(v);
    cd ..
end
volume_number=cell2mat(result);
bar(volume_number);