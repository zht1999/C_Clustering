function Z=re_point(sample,C,flag_choose,N)%�����������У�����������Ŀ��ѡ�����ķ���,�����ռ�ά��
Z=zeros(C,N);
if(flag_choose==0)%ѡǰC����
    Z=sample(1:C,:);
elseif(flag_choose==1)%���ѡȡC����
    for i=1:C
        n=round(rand(1,1)*(length(sample(:,1))-1))+1;%����һ����Χ��1~N�������
        Z(i,:)=sample(n,:);%�����ѡ��������
    end
elseif(flag_choose==2)%���ܶȷ�ѡȡ
    d=2;
    sample_desity=zeros(length(sample),2);
    for i=1:length(sample)
        sample_desity(i,1)=i;
        for j=i:length(sample)
            if(distance_def(sample(i,:),sample(j,:))<d)
                sample_desity(i,2)=sample_desity(i,2)+1;
                sample_desity(j,2)=sample_desity(j,2)+1;
            end
        end
    end
    sample_desity=sortrows(sample_desity,2,'descend');
    %�ҵ�C����
    Z(1,:)=sample(sample_desity(1,1),:);
    k=2;
    flag=1;
%    disp(flag);
    for i=2:C
        %disp(flag);
        for j=k:length(sample_desity)
            %disp(flag)
             flag=1;
             index=sample_desity(j,1);
            for m=1:i-1
                if(distance_def(sample(index,:),Z(m,:))<2*d)
                    %disp(j);
                    flag=0;
                end
            end
%            disp(flag);
            if(flag)
                Z(i,:)=sample(index,:);
                k=j+1;
                %disp(k);
                break;
            end
        end
    end
elseif(flag_choose==3)%�ý��ڷ��İ취ѡ��ۺ�����
    n=round(rand(1,1)*(length(sample(:,1))-1))+1;
    Z(1,:)=sample(n,:);
    min_distance=zeros(length(sample),2);
    for i=1:length(sample)
        min_distance(i,1)=i;
        min_distance(i,2)=distance_def(Z(1,:),sample(i,:));
    end
    sortdistance=sortrows(min_distance,2,'descend');
    Z(2,:)=sample(sortdistance(1,1),:);
    if(C>2)
        for i=3:C
            for j=1:length(sample)
                distance=distance_def(Z(i-1,:),sample(j,:));
                if(distance<min_distance(j,2))
                    min_distance(j,2)=distance;
                end
            end
            
            sortdistance=sortrows(min_distance,2,'descend');
            Z(i,:)=sample(sortdistance(1,1),:);
        end 
    end
else%�������
    Z=-1;
end
end
    
    
    
    
            
        
    