%% 分析产业对GDP的影响程度
%%第一行是不同年份GDP值，剩下行是影响指标
clear,clc;
data=[1.14 1.49 1.69 2.12 2.43 4.32 5.92 6.07 7.85;
    3.30 3.47 3.61 3.80 4.00 4.19 4.42 4.61 4.80;
    6.00 6.00 6.00 7.50 7.50 7.50 9.00 9.00 9.00;
    1.20 1.20 1.80 1.80 1.80 2.40 2.70 3.60 4.00;
    4.87 5.89 6.76 7.97 8.84 10.05 11.31 12.25 11.64];%原始数据5行9列
data=data';
r = size(data,1);
c = size(data,2);
%第一步，对变量进行预处理，消除量纲的影响
avg = repmat(mean(data),r,1);
data = data./avg;
%定义母序列和子序列
Y = data(:,1); %母序列
X = data(:,2:c); %子序列
Y2 = repmat(Y,1,c-1); %把母序列向右复制到c-1列
absXi_Y = abs(X-Y2);
a = min(min(absXi_Y)); %全局最小值
b = max(max(absXi_Y)); %全局最大值
ro = 0.5; %分辨系数取0.5
gamma = (a+ro*b)./(absXi_Y+ro*b); %计算子序列中各个指标与母序列的关联系数
disp("子序列中各个指标的灰色关联度分别为：");
guanliandu = mean(gamma)
[rs,rind]=sort(guanliandu,'descend'); %对关联度进行排序
