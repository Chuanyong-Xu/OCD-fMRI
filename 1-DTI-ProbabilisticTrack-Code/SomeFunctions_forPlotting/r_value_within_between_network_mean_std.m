clc
clear all
matdir = uigetdir('','select data folder');
mat = dir([matdir,filesep,'*.txt']);
for m=1:length(mat)
    % 加载其中一个mat后缀文件
    fc = load([matdir,filesep,mat(m).name]);
    % 判断z是不是无穷大，如果是则z值变成0，否则不变
    data = fc;
    data(data == Inf) = 0;
    % 判断z是不是NaN（非数值），如果是则z变成0，否则不变    
    data(isnan(data)) = 0;
    %计算矩阵元素的绝对值,将正、负连接均纳入
    data = abs(data);
    %提取矩阵特定区域(上三角)内的数值
    t=0
    for i=1:17;
    for j=(i+1):18;
        t=t+1
    result(t,1)=data(i,j);
    end
    end
    %计算所有人连接矩阵该区域内的均值并保存在一个矩阵里
    goal_directed_mean=mean(result);
    Goal_directed_mean_matrix(m,:) = goal_directed_mean;
     %计算所有人连接矩阵该区域内的方差并保存在一个矩阵里(此处取标准差还是方差用于后续统计分析更好？)
    goal_directed_var=var(result);
    Goal_directed_var_matrix(m,:) = goal_directed_var;
end
%保存为txt文件
save 'All_sub_Goal_directed_within_matrix_mean.txt' Goal_directed_mean_matrix -ascii;
save 'All_sub_Goal_directed_within_matrix_var.txt' Goal_directed_var_matrix -ascii;