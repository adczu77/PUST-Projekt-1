clear;
Tp=0.5;

kk=800;
Upp=1.2;
Ypp=2;

y(1:kk)=2;
u(1:kk)=1.2;
yzad(1:11)=Ypp;
yzad(12:kk)=2.4;
yzad(200:kk)=1.8;
yzad(400:kk)=2.2;
yzad(600:kk)=1.6;

Umax = 1.5;
Umin = 0.9;
dUmax = 0.1;
E = 0;


% Ustawienia (wykresy u i y po kolei tak jak podane poniżej parametry)
%N          20,50,75,90,110,125
%Nu         5,15,20,35,40,50
%lambda     0.1,0.3,0.5,0.7,1,2
D = 200; 
N = 121; 
Nu = 5; 
lambda = 0.0141;
u(1:11)=1.2;
u(12:kk) = 1.5;
y(1:2)=2;

for k=12:kk
    y(k)=symulacja_obiektu15y_p1(u(k-10),u(k-11),y(k-1),y(k-2));
end
S=(y(13:kk)-Ypp)/(1.5-Upp);

M=zeros(N,Nu);
for i=1:N
    for j=1:Nu
        if (i>=j)
            if(i-j+1<=D)
                M(i,j)=S(i-j+1);
            else
                M(i,j)=S(D);
            end
        end
    end
end

Mp = zeros(N, D-1);
for i=1:N
    for j=1:D-1
        if i + j <= D
            Mp(i, j) = S(i + j) - S(j);
        else
            Mp(i, j) = S(D) - S(j);
        end
    end
end

L = lambda * eye(Nu);
K = (M' * M + L)^(-1) * M';
dUpk(1:D-1)=0;
dUpk=dUpk';
u(1:kk) = Upp;
y(1:kk) = Ypp;

for k=12:kk
    y(k)=symulacja_obiektu15y_p1(u(k-10),u(k-11),y(k-1),y(k-2));

    Yzad = yzad(k) * ones(N, 1);
    Y = y(k) * ones(N,1);

    for i =1:D-1
        dUpk(i)=0;
        if k-1-i>0
            dUpk(i) = u(k-i) - u(k-1-i) ;
        end
    end

    dUk = K * (Yzad - Y - Mp * dUpk);

    if dUk(1)> dUmax
        dUk(1)=dUmax;
    elseif dUk(1) <-dUmax
        dUk(1)=-dUmax;
    end
    
    u(k) = u(k-1) + dUk(1);

    u(k) = min(u(k), Umax);
    u(k) = max(u(k), Umin);

    E = E + (yzad(k)- y(k))^2;
end
figure;
p=(0:0.5:kk/2);
stairs(p(1:kk),u);
title("u, E="+ num2str(E)); xlabel('k'); ylabel('u');
print('pust5dmc_u_ga.png','-dpng','-r400');
figure;
hold on
stairs(p(1:kk),y);
stairs(p(1:kk),yzad, ':');
title("yzad, y, E="+ num2str(E)); xlabel('k'); ylabel('y');
legend('y','yzad');
title("y, E="+ num2str(E))
print('pust5dmc_y_ga.png','-dpng','-r400');