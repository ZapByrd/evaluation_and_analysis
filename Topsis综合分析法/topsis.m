clc;clear;close all;
data=xlsread('train.xlsx');
data=data(:,3:end); %只取指标数据
[n, m] =size(data) ;
w=[0.1672,0.0371,	0.1667,0.1224,	0.1578,0.0898,0.2588];%各个指标权重

%指标正向化，视具体情况而定
for j=[4,6,7]
    for i=1:n
      data(i,j)=max(data(:,j))-data(i,j);
    end
end
a=100;
for i=1:n
    data(i,5)=1-abs(data(i,5)-a)/max(abs(data(:,5)-a));
end

%归一化
data=mapminmax(data,0,1);%数据归一化到(0,1)之间

%计算距离
d1=zeros(n, 1) ; %最小值矩阵
d2=zeros(n, 1)  ; %最大值矩阵
score=zeros(n, 1) ; %接近程度
xx=min(data) ;
dd=max(data) ;
for i=1: n
for j =1: m
d1(i) =d1(i) +((data(i, j ) -xx(j ) ) ^2)*w(j);
end
d1(i) =sqrt(d1(i) ) ;
end
for i=1: n
for j =1: m
d2(i) =d2(i) +((data(i, j ) -dd(j ) ) ^2)*w(j);
end
d2(i) =sqrt(d2(i) ) ;
end
%计算接近程度（最终得分）
for i=1: n
score(i) =d1(i) /(d2(i) +d1(i) ) ;
end