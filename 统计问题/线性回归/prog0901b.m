%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 数学模型第五版 p314
% 残差分析剔除异常点示例

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
M1=dlmread('data0901.txt');  % 读数据文件
for j=1:7
    M(:,j)=M1(:,j+1);  
end
k0=0;k1=0; 
for i=1:1236
    if M(i,7)==0; % 吸烟状况,0~不吸烟
        k0=k0+1;
        y0(k0)=M(i,1); % 不吸烟孕妇的新生儿体重
        x0(k0)=M(i,2); % 不吸烟孕妇的怀孕期
    else  if M(i,7)==1; % 吸烟状况,1~吸烟
        k1=k1+1;
        y1(k1)=M(i,1); % 吸烟孕妇的新生儿体重
        x1(k1)=M(i,2); % 吸烟孕妇的怀孕期
       end
    end
end
k0,k1
% 吸烟孕妇的新生儿体重和怀孕期的回归模型
n1=0; 
for i=1:k1
    if (y1(i)<999)&(x1(i)<999);% 吸烟孕妇的新生儿体重和怀孕期数据不缺失
        n1=n1+1;
        yn1(n1)=y1(i);
        xn1(n1)=x1(i); 
       end
    end
n1
X1=[ones(n1,1),xn1']; % 构造1与自变量组成的矩阵
[b1,bint1,r1,rint1,s1]=regress(yn1',X1); % 线性回归 
b1,bint1,s1
figure(1);
rcoplot(r1,rint1) % 残差及其置信区间图形

b=polyfit(xn1,yn1,1) % 用拟合计算系数，与b1比较
x=220:340;
y=polyval(b,x);
figure(2);
plot(xn1,yn1,'+',x,y,'b')

% 去除异常数据（残差置信区间不含零点）再做回归
r0=0;
for n=1:n1
    if rint1(n,1)*rint1(n,2)>0 % 判断异常数据
        r0=r0+1;
        rr(r0)=n; % 异常数据的编号
    end
end
k=1;
for i=1:n1
    if i==rr(k)
        xn1(i)=0; yn1(i)=0;% 异常数据置零
        k=k+1;
    end 
if k>r0
break     
end
end
nn1=0; 
for i=1:n1
    if xn1(i)>0;% 非异常数据
        nn1=nn1+1;
        ynn1(nn1)=yn1(i);
        xnn1(nn1)=xn1(i); 
       end
    end
nn1
XX1=[ones(nn1,1),xnn1']; % 构造1与自变量组成的矩阵
[bb1,bbint1,rr1,rrint1,ss1]=regress(ynn1',XX1); % 线性回归 
bb1,bbint1,ss1
