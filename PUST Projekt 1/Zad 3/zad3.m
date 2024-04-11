D=300;

Ypp = 2;
Upp = 1.2;

U = zeros(D,1);
Y_inf = [];
U_skoki = [0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5];

for U_skok = U_skoki
    for k = 1:D
        if (k<=100)
            U(k) = Upp;
        else
            U(k) = U_skok;
        end
    end
    Y = ones(D,1)*Ypp;
    
    for k = 12:D
        Y(k) = symulacja_obiektu15y_p1(U(k-10), U(k-11), ...
            Y(k-1), Y(k-2));
    end
    Y_inf = [Y_inf Y(D)];
end

u_diff = U_skoki(7) - Upp;
S = (Y(102:D)-ones(D-101, 1)*Ypp )*1/u_diff;
S(200)=S(end);
figure;
hold on;
stairs(S);
title('Odpowiedz na skok jednostkowy');
xlabel('k')
ylabel('Y')
set(gcf, 'position', [10, 10, 800, 600])
print('zad3.png','-dpng','-r400')