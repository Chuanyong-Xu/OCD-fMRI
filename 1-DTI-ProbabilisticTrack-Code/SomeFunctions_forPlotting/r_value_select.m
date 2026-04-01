clc
clear all
matdir = uigetdir('','select data folder');
mat = dir([matdir,filesep,'*.txt']);
network_within_mask=load('E:\data\KN\3_HC73_MD62_OCD50\4_FC_VBM_Fiber_hc45_md49_ocd41_ROI_wise\4_Results-FC_network_FunARCWSFB\NBS_HC_OCD\HC_MD_OCD_positive_mask_60.txt');
for i=1:length(mat);
    SubName = mat(i).name;
    % 加载其中一个mat后缀文件
    fc = load([matdir,filesep,mat(i).name]);
    % 判断z是不是无穷大，如果是则z值变成0，否则不变
    data = fc;
    data(data == Inf) = 0;
    % 判断z是不是NaN（非数值），如果是则z变成0，否则不变    
    data(isnan(data)) = 0;
    %data(data < 0) =0;
    %点乘矩阵mask文件
    data=data.*network_within_mask;
    %存储文件
    save(SubName,'data', '-ascii');
    %批量画图并保存
    %%data=imagesc(fc);
    %%saveas(data,[num2str(i),'.jpg']);
end