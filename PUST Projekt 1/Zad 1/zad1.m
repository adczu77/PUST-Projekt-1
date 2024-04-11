kk = 100;

Upp = 1.2;
Ypp = 2;

U = zeros(kk,1);
for i = 1:kk
    U(i) = Upp;
end

Y = ones(kk,1)*Ypp;

for k=12:1:kk
    Y(k)=symulacja_obiektu15y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

plot(Y);
xlabel("k")
ylabel("y")
print('zad1.png','-dpng','-r400');