clc
clear all
matdir = uigetdir('','select data folder');
mat = dir([matdir,filesep,'*.txt']);
for i=1:length(mat);
        % 加载其中一个mat后缀文件
        data = load([matdir,filesep,mat(i).name]);
        % 判断z是不是无穷大，如果是则z值变成0，否则不变
        data(data == Inf) = 0;
        % 判断z是不是NaN（非数值），如果是则z变成0，否则不变    
        data(isnan(data)) = 0;
        data(data < 2) = 0;
        data(data == 2)=0;
        %将矩阵中大于0的值赋值为1
        data(data > 2) = 1;
        fN_matrix(:,:,i) = data;
end
    %计算所有被试矩阵均值,保存100%的人都有的边
    mean_fN_matrix=mean(fN_matrix,3);
    mean_fN_matrix(mean_fN_matrix<1)=0;
    save 'HC_MD_OCD_FN_thr2_mask_100.txt' mean_fN_matrix -ascii;
    %计算所有被试矩阵均值,保存60%的人都有的边
    mean_fN_matrix=mean(fN_matrix,3);
    mean_fN_matrix(mean_fN_matrix<0.6)=0;
    mean_fN_matrix(mean_fN_matrix>=0.6)=1;
    save 'HC_MD_OCD_FN_thr2_mask_60.txt' mean_fN_matrix -ascii;