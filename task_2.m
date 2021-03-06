%使用C均值算法
%使用最大距离选初始代表点
%准则函数为误差平方和
figure
%初始样本
N1=20;
mu = [3 3];  
sigma = [3 0; 0 3];
r1= mvnrnd(mu,sigma,N1);
plot(r1(:,1),r1(:,2),'r+');
hold on;
N2=2000;
mu = [10 10];
sigma = [ 3 0; 0 3];
r2 = mvnrnd(mu,sigma,N2);
plot(r2(:,1),r2(:,2),'bv');
hold on;
N3=20;
mu = [17 17];
sigma = [ 3 0; 0 3];
r3 = mvnrnd(mu,sigma,N3);
plot(r3(:,1),r3(:,2),'go')
grid on;
title('三组样本散点图');
set(gcf,'position',[0,0,1000,1000]);
saveas(gcf,'lab2_2_2.jpg');
N=N1+N2+N3;
%% 初始划分
%全部样本点
sample=[r1
    r2
    r3];
C=3;%目标聚类数目
Z=zeros(C,2);
%默认随机生成初始划分
flag_choose=3;
type_sample=zeros(1,length(sample));
% for i=1:C
%     if(flag_choose)
%         n=round(rand(1,1)*(length(sample(:,1))-1))+1;%生成一个范围在1~N的随机数
%         Z(i,:)=sample(n,:);%随机挑选聚类中心
%     else
%         Z(i,:)=sample(i,:);%顺序挑选聚类中心
%     end
% end
Z=re_point(sample,C,flag_choose,2);%自定义函数参数见re_point.m

%% 聚类循环
count=0;
Z_pre=zeros(C,2);
min_distance=-1;
count_type=zeros(1,C);
while(~isequal(Z,Z_pre))
%      bool=(Z~=Z_pre);
%      disp(bool);
    count=count+1;
    Z_pre=Z;
    disp(Z);
    Z_buffer=zeros(C,2);
    count_type=zeros(1,C);
    for i=1:length(sample)
        min_distance=-1;
        for j=1:C
            distance=distance_def(sample(i,:),Z(j,:));
%            disp(distance);
            if(min_distance==-1||distance<min_distance)
                min_distance=distance;
                type_sample(i)=j;
            end
        end
        count_type(type_sample(i))=count_type(type_sample(i))+1;
        Z_buffer(type_sample(i),:)=Z_buffer(type_sample(i),:)+sample(i,:);
    end
    for m=1:C
        if(count_type(m)~=0)
            Z_buffer(m,:)=Z_buffer(m,:)/count_type(m);
        else
            Z_buffer(m,:)=Z_pre(m,:);
        end
    end
    Z=Z_buffer;
%     disp(Z_pre);
%     disp(Z);
end
w1=zeros(count_type(1),2);
w1_count=1;
w2=zeros(count_type(2),2);
w2_count=1;
w3=zeros(count_type(3),2);
w3_count=1;
for i=1:length(sample)
    if(type_sample(i)==1)
        w1(w1_count,:)=sample(i,:);
        w1_count=w1_count+1;
    elseif(type_sample(i)==2)
        w2(w2_count,:)=sample(i,:);
        w2_count=w2_count+1; 
    else
        w3(w3_count,:)=sample(i,:);
        w3_count=w3_count+1;     
    end
end
figure
plot(w1(:,1),w1(:,2),'r+');
hold on
plot(w2(:,1),w2(:,2),'go');
hold on
plot(w3(:,1),w3(:,2),'bv');
grid on
title('分隔很开且类别数目差别很大');
set(gcf,'position',[0,0,1000,1000]);
saveas(gcf,'lab2_2_3.jpg');