D=300;

Ypp = 2;
Upp = 1.2;

U = zeros(D,1);
Y_inf = [];
U_skoki = [0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5];

figure;
hold on;

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
        Y(k) = symulacja_obiektu15y_p1(U(k-10), ...
            U(k-11), Y(k-1), Y(k-2));
    end
    stairs(Y);
    Y_inf = [Y_inf Y(D)];
end
title ( ' Odpowiedź na skok ') ;
xlabel ( 'k ')
ylabel ( 'Y ')
legend ( 'u =0.9 ' , 'u =1 ' , 'u =1.1 ' , 'u =1.2 ' , 'u =1.3 ' , ...
    'u =1.4 ' , 'u =1.5 ') ;
set(gcf, 'position',[10,10,800,600])
Kstat = (Y_inf(7)-Y_inf(2))/(U_skoki(7)-U_skoki(2));
%print('zad2_1.png','-dpng','-r400')

figure ;
hold on ;
plot ( U_skoki , Y_inf )
title (  "Charakterystyka statyczna Kstat=" + num2str(Kstat)) ;
xlabel ( 'u ( k ) ')
ylabel ( ' Y_ { stat } ')
set(gcf, 'position',[10,10,800,600])
%print('zad2_2.png','-dpng','-r400')










