%% anfis v1.2
clear all;
clc;

% duty 0.08 - 0.92
%error 15 -2
%errord 0.01 -0.1
e = zeros(200,1);
for i =1:70 
    e(i)=-11.95442+(15.00213+11.95442)/(1+((i/(2e3))/0.02643693)^(0.87903));
end



x1=[0.035 0.036 0.0367 0.037 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.05]';
y1=[0 -0.5 -1 -1.25 -1.5 -1.45 -1.4 -1.39 -1.3 -1.2 -1.19 -1.18 -1.17   -1.15]';
u1 = fit(x1,y1,'smoothingspline');

for i =71:100
    e(i)= u1(i/2e3);
end


x2=[0.05:0.0025:0.1 ]';
y2=[-1.1 -1.1 -1.15 -1.16 -1.14 -1.15 -1.15 -1.04 -1.05 -1.09 -1.08 -1.09 -1.05 -1.04 -1.03 -1.02 -1 -0.9 -0.8 -0.8 -0.8]';
u2 = fit(x2,y2,'smoothingspline');

for i =101:200
    e(i)= u2(i/2e3);
end



de = zeros(200,1);

x3=[0:0.0025:0.1 ]';
y3=[0 -0.04 -0.055 -0.045 -0.037 -0.025 -0.02 -0.015 -0.0125 -0.01...
     -0.008 -0.007 -0.009 -0.037 -0.02 0 0.005 0.0025 0.002 0 ...
     0 0 0 0 0 0 0 0 0 0 ...
     0 0 0 0 0 0 0 0 0 0 0]';
u3 = fit(x3,y3,'smoothingspline');
% plot(u3,x3,y3);
for i =1:200
   de(i)= u3(i/2e3)+8e-3 * sin(2*pi* (1230)*(i/2e3));
end
 
%  figure()
%  hold on
% plot(0:0.0005:0.1-0.0005,de,'r')
%  plot(0:0.0005:0.1-0.0005,e,'b')
% hold off

yout(:,1)=e;
yout(:,2)=de;
for i=1:size(de)
X1(i,:) = de';
Y1(i,:) = e';
end

%% rules %%
s=0.0135;
for i= 1:1:200
    
    
    if (-0.0606<=de(i) && de(i)<-0.0606+s)
        us1 = (fit((min(e):0.6861:max(e))' ,(0.08:0.0191:0.5+0.0191)' ,'smoothingspline'));
        Z1(:,i)= us1(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
    end
    if (-0.0606+s<=de(i) && de(i)<-0.0606+2*s)
        us2 = fit((min(e):0.6861:max(e)-0.6861)' ,(0.0938: 0.0240:0.621)' ,'smoothingspline');
        Z1(:,i)= us2(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
    end
    if  (-0.0606+2*s<=de(i) && de(i)<-0.0606+3*s)
        us3 = fit((min(e):0.6861:max(e))' ,(0.0804:0.0296:0.732)' ,'smoothingspline');
        Z1(:,i)= us3(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
    end
    
    
    if  (-0.0606+3*s<=de(i) && de(i)<-0.0606+4*s)
        us4 = fit((min(e):0.6861:max(e))' ,(0.0934:(0.779-0.0934)/22:0.779)' ,'smoothingspline');
        Z1(:,i)= us4(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
    end
    if  (-0.0606+4*s<=de(i) && de(i)<-0.0606+5*s)
        us5 = fit((min(e):0.6861:max(e))' ,(0.0802:(0.904-0.0802)/22:0.904)' ,'smoothingspline');
        Z1(:,i)= us5(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
    end
     if  (-0.0606+5*s<=de(i) && de(i)<-0.0606+6*s)
        us6 = fit((min(e):0.6861:max(e))' ,(0.221:(0.907-0.221)/22:0.907)' ,'smoothingspline');
        Z1(:,i)= us6(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
     end
    
     
      if  (-0.0606+6*s<=de(i) && de(i)<-0.0606+7*s)
        us7 = fit((min(e):0.6861:max(e))' ,(0.25:(0.92-0.25)/22:0.92)' ,'smoothingspline');
        Z1(:,i)= us7(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
      end
     if  (-0.0606+7*s<=de(i) && de(i)<-0.0606+8*s)
        us8 = fit((min(e):0.6861:max(e))' ,(0.367:(0.907-0.367)/22:0.907)' ,'smoothingspline');
        Z1(:,i)= us8(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
     end
      if  (-0.0606+8*s<=de(i) && de(i)<-0.0606+9*s)
        us9 = fit((min(e):0.6861:max(e))' ,(0.5:(0.92-0.5)/22:0.92)' ,'smoothingspline');
        Z1(:,i)= us9(min(e):(max(e)-min(e))/200:max(e)-(max(e)-min(e))/200);
        continue
     end
end    
for j=1:200
x1(1+200*(j-1):200*j)=X1(:,j);
y1(1+200*(j-1):200*j)=Y1(:,j);
z1(1+200*(j-1):200*j)=Z1(:,j);
end
 
data(:,1)=x1;
data(:,2)=y1;
data(:,3)=z1;