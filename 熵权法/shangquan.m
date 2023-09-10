%%熵权法求指标权重和企业综合得分
%%data为原始数据矩阵, 每行代表一家企业, 每列对应一个指标
%%score返回各企业得分, weight返回各指标权重
clc;clear;close all;
data=xlsread('train.xlsx');
data=data(:,3:end); %只取指标数据
[n,m]=size(data); % n家企业, m个评价指标

%指标正向化，视具体情况而定
for j=[4,6,7]
    for i=1:n%指标正向化，视具体情况而定
for j=[4,6,7]
    for i=1:n
      data(i,j)=max(data(:,j))-data(i,j);
    end
end
a=100;
for i=1:n
    data(i,5)=1-abs(data(i,5)-a)/max(abs(data(:,5)-a));
end
      data(i,j)=max(data(:,j))-data(i,j);
    end
end
a=100;
for i=1:n
    data(i,5)=1-abs(data(i,5)-a)/max(abs(data(:,5)-a));
end

%标准化处理
X=mapminmax(data,0,1);%数据归一化到(0,1)之间
X=X+eps;%避免归一化后的数据出现0

% 计算第j个指标下，第i个记录占该指标的比重p(i,j)
p=zeros(n,m);
for i=1:n
    for j=1:m
        p(i,j)=X(i,j)/sum(X(:,j));
    end
end

% 计算第j个指标的熵值e(j)
e=zeros(1,m);
k=1/log(n);
for j=1:m
    e(j)=-k*sum(p(:,j).*log(p(:,j)));
end

d=ones(1,m)-e;  % 计算信息熵冗余度
weight=d./sum(d);    % 求权值w
score=weight*p';         % 求综合得分 
score=score';
