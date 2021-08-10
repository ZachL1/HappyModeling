%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 数学模型第五版 p328
% 非线性回归，酶促反应问题

%%%%%%%%%%%%%%%%%%%%%%%%%%%



% 9.3节； 酶促反应：输出表4-6；图7-10
clear all; clc;  % 酶促混合反应
x11=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1];
x12=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1 1.1];
y1=[67 51 84 86 98 115 131 124 144 158 160];
y2=[76 47 97 107 123 139 159 152 191 201 207 200];
xx1=[x11 x12];
xx2=[zeros(1,11) ones(1,12)];
x=[xx1' xx2'];
y=[y1 y2]';
beta0=[170 0.05 60 0.01]'; 
[beta,R,J]=nlinfit(x,y,@case0903b1,beta0);
betaci=nlparci(beta,R,J);
beta,betaci               % 非线性模型4的结果（表4）
r1=R;
%xx=0:0.01:1.1;
xx=xx1;
yhat=beta(1)*xx./(beta(2)+xx);
yhat1=((beta(1)+beta(3))*xx)./((beta(2)+beta(4))+xx);

figure(7); %画图7
plot(xx1,y,'o',xx,yhat,'+',xx,yhat1,'+')
%gtext('处理'),gtext('未处理')
axis([0 1.2 40 220]),

  
nlintool(x,y,@case0903b1,beta)   %画图8
[ypre1,delta1]=nlpredci(@case0903b1,x,beta,R,J);    %表部分数据  
beta0=[170,0.05,60]';
[beta,R,J]=nlinfit(x,y,@case0903b2,beta0);
betaci=nlparci(beta,R,J);
beta,betaci           % 非线性模型5的结果（表5）
r2=R;
yhat=beta(1)*xx./(beta(2)+xx);
yhat2=((beta(1)+beta(3))*xx)./(beta(2)+xx);

figure(9);
plot(xx1,y,'o',xx,yhat,'+',xx,yhat2,'+')
%gtext('处理'),gtext('未处理')
axis([0 1.2 40 220])         %画图9

nlintool(x,y,@case0903b2,beta)   %画图10
[ypre2,delta2]=nlpredci(@case0903b2,x,beta,R,J); 
[y1,y2;ypre1';delta1';ypre2';delta2']'  % 表6



function yhat1=case0903b1(beta,x)
xx1=x(:,1);
xx2=x(:,2);
yhat1=((beta(1)+beta(3).*xx2).*xx1)./((beta(2)+beta(4).*xx2)+xx1);
end

function yhat2=case0903b2(beta,x)
xx1=x(:,1);
xx2=x(:,2);
yhat2=((beta(1)+beta(3).*xx2).*xx1)./(beta(2)+xx1);
end

