clear;

Tp=0.5;
Umax = 1.5;
Umin = 0.9;
dUmax = 0.1;
E = 0;
% ymin = 1.047
% ymax = 2.953

% Ziegler-Nichols
% Kr = 0.6 * 1.05; % Kkrytyczne=1.05 Tkrytyczne=25
% Ti = 0.5 * 25;
% Td = 0.12 * 25;

% Parametry zznalezione za pomocą fmincon:
% Kr = 1.1452
% Ti = 6.3605
% Td = 4.0609                   

% Eksperymentalnie
Kr = 1.1;  % 0.6; 0.5; 0.7; 0.8; 0.75;
Ti = 5.7430;   % 12; 10; 8; 11; 10;             
Td = 4.2751;  % 2.5; 2; 5; 3; 4;                   

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

disp(E)
p=(0:0.5:kk/2);
figure; stairs(p(1:kk),u); 
title("u, E="+ num2str(E)); xlabel('k'); ylabel('u');
figure; stairs(p(1:kk),y); hold on; stairs(p(1:kk),yzad,':'); 
title("yzad, y, E="+ num2str(E)); xlabel('k'); ylabel('y');
legend('y','yzad');
hold off;