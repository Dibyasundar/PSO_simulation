clear;clc;close all;
c1=2;
c2=2;
w=0.4;
max_iter=50;

l_x=-1;
u_x=2;
l_y=-1;
u_y=2;
x_r=l_x:0.1:u_x;
y_r=l_y:0.1:u_y;
figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:size(x_r,2)
    for j=1:size(y_r,2)
        su(i,j)=obj(x_r(i),y_r(j));
    end
end
ha1=subplot(1,2,1);surf(x_r,y_r,su);hold on;
ha2=subplot(1,2,2);surf(x_r,y_r,su);hold on;
l=1;
for i=0:0.4:1
    for j=0:0.4:1
        pop(l,1)=i;
        pop(l,2)=j;
        l=l+1;
    end
end
for i=1:size(pop,1)
    obj_val(i)=obj(pop(i,1),pop(i,2));
    subplot(1,2,1);plot3(pop(i,2),pop(i,1),obj_val(i),'or','MarkerFaceColor','red');hold on;xlim([l_x,u_x]);ylim([l_y,u_y]);
    subplot(1,2,2);plot3(pop(i,2),pop(i,1),obj_val(i),'or','MarkerFaceColor','red');hold on;
end
view(ha1,[0,-90])
pause(1);
pop_l=pop;
pop_l_obj=obj_val;
v=rand(size(pop));
iter=1;
    [~,best_pos]=min(obj_val);
    best_pop=pop(best_pos,:);
    best_obj=obj_val(best_pos);
    prev=pop;
    subplot(1,2,1);plot3(best_pop(1,2),best_pop(1,1),best_obj,'or','MarkerFaceColor','green');pause(0.00001);
    subplot(1,2,2);plot3(best_pop(1,2),best_pop(1,1),best_obj,'or','MarkerFaceColor','green');pause(0.00001);
    path=[];
    path=[path;best_pop];
    
while iter<max_iter
    %ha1=subplot(1,2,1);hold off;surf(x_r,y_r,su);hold on;
        
        %view(ha1,[0,-90])
    for i=1:size(pop,1)
        v(i,:)=(w*v(i,:))+ c1.*rand().*(pop_l(i,:)-pop(i,:)) + c2.*rand().*(best_pop-pop(i,:));
        pop(i,:)=pop(i,:)+v(i,:);
        if pop(i,1)<l_x
            pop(i,1)=l_x;
        elseif pop(i,1)>u_x
            pop(i,1)=u_x;
        end
        if pop(i,2)<l_y
            pop(i,2)=l_y;
        elseif pop(i,2)>u_y
            pop(i,2)=u_y;
        end
        obj_val(i)=obj(pop(i,1),pop(i,2));
        
        if obj_val(i)<pop_l_obj(i)
            pop_l(i,:)=pop(i,:);
            pop_l_obj(i)=obj_val(i);
        end
        if obj_val(i)<best_obj
            best_pop=pop(i,:);
            best_obj=obj_val(i);
            path=[path;best_pop];
        end
        ha1=subplot(1,2,1);hold off;
        surf(x_r,y_r,su);hold on;
        for j=1:size(pop,1)
            plot3(pop(j,2),pop(j,1),obj_val(j),'or','MarkerFaceColor','red');hold on;xlim([l_x,u_x]);ylim([l_y,u_y]);
        end
        plot3(best_pop(1,2),best_pop(1,1),best_obj,'or','MarkerFaceColor','green');hold on;
        
        if size(path,1)>1
            for j=1:size(path,1)-1
                z=[];
                pt1=path(j,:);
                pt2=path(j+1,:);
                a=(pt2(1)-pt1(1))/100;
                b=(pt2(2)-pt1(2))/100;
                for kk=1:100
                    x1=pt1(1)+(kk*a);
                    y1=pt1(2)+(kk*b);
                    z1=obj(x1,y1);
                    plot3(y1,x1,z1,'.k');hold on;
                end
            end
        end
        view(ha1,[0,-90]);
        ha2=subplot(1,2,2);hold off;surf(x_r,y_r,su);hold on;
        for j=1:size(pop,1)
            plot3(pop(j,2),pop(j,1),obj_val(j),'or','MarkerFaceColor','red');hold on;xlim([l_x,u_x]);ylim([l_y,u_y]);
        end
        plot3(best_pop(1,2),best_pop(1,1),best_obj,'or','MarkerFaceColor','green');hold on;
        if size(path,1)>1
            for j=1:size(path,1)-1
                z=[];
                pt1=path(j,:);
                pt2=path(j+1,:);
                a=(pt2(1)-pt1(1))/100;
                b=(pt2(2)-pt1(2))/100;
                for kk=1:100
                    x1=pt1(1)+(kk*a);
                    y1=pt1(2)+(kk*b);
                    z1=obj(x1,y1);
                    plot3(y1,x1,z1,'.k','MarkerFaceColor','black');hold on;
                end
            end
        end
        pause(0.00001)
    end
    w=w-(0.9-0.1)/max_iter;
    iter=iter+1;
end