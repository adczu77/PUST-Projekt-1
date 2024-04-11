function E = pidmin(vector)
Tp=0.5;

Umax = 1.5;
Umin = 0.9;
dUmax = 0.1;
E = 0;

Kr = vector(1);
Ti = vector(2);
Td = vector(3);

r2=(Kr*Td)/Tp;
r1=Kr*(Tp/(2*Ti)-2*(Td/Tp)-1);
r0=Kr*(Tp/(2*Ti)+Td/Tp+1);

kk=800;
u(1:kk)=1.2;
y(1:kk)=2;
yzad(1:kk)=2;
yzad(12:kk)=2.4;
yzad(200:kk)=1.8;
yzad(400:kk)=2.2;
yzad(600:kk)=1.6;
e(1:12)=0;

for k=12:kk
    y(k)=symulacja_obiektu15y_p1(u(k-10),u(k-11),y(k-1),y(k-2));
    e(k)=yzad(k)-y(k); 
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    if u(k)-u(k-1) > dUmax
        u(k)=u(k-1)+dUmax;
    elseif u(k)-u(k-1) <-dUmax
        u(k)=u(k-1)-dUmax;
    end
    u(k) = min(u(k), Umax);
    u(k) = max(u(k), Umin);
    E = E + (yzad(k)- y(k))^2;
end