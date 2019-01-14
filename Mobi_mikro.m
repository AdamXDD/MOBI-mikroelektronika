clear all; 
clc;
close all;
format long;

sample = 100; %ilosc probek
Newton_i = 100;
%sta?e fizyczne i dane
N_A = 8e17; %koncentracja domieszki akceptorowej [m-3]
N_D = 3e18; %koncentracja domieszki donorowej [m-3]
%W_g = 1.11;  %[eV]
q = 1.602177335e-19; %ladunek elementarny [C]
ni = 1e10; %koncentracja samoistna krzemu
Epsilon_0 = 8.854187817e-12; % [F/m]
Epsilon_ox = Epsilon_0*3.9; %przenikalno?? elektryczna dwutlenku krzemu
Epsilon_Si = Epsilon_0*11.7; %przenikalno?? elektryczna krzemu 
%Ec_max = 0;
%Ev_max = Ec_max - W_g ;
T = 300; % Temperatura [K]
%kB = 8.6173303e-5; % sta?a Boltzmanna [eV/K]
kB = 1.380658e-23; % sta?a Boltzmanna [J/K]
%Fite_eV = kB_J*T/q; %potencjal termiczny [V]
Fite = kB*T/q;%potencjal termiczny [eV]
%Fite = 0.026;
Fi_p = -Fite*log(N_A/ni); %potencjal anody poza obszarem zubozonym (pot fermiego)
Fi_n = Fite*log(N_D/ni); %potencjal anody poza obszarem zubozonym

V_bi = Fi_n-Fi_p;

W_n = sqrt((2*Epsilon_Si*V_bi)/(q*(N_D+(N_D^2)/N_A))); %szerokowsc warstwy zaporowej w anodzie
W_p = sqrt ((2*Epsilon_Si*V_bi)/(q*(N_A+(N_A^2)/N_D))); %szerokowsc warstwy zaporowej w katodzie
W = W_n+W_p; 

h = 4*W/sample;                 %krok z jakim dokonuje sie kolejnych iteracji
Wp_wyk = 2*W;
Wn_wyk = 2*W;

A = zeros (sample,sample);
A(1,1) = 1;
A(1,2) = 0;
A(sample,sample) = 1;
A(sample,sample-1) = 0;
for i=2:sample-1
    A(i,i-1) = 1;
    A(i,i) = -2;
    A(i,i+1) = 1;
end
b = zeros(sample,1); %reszty
b(1,1) = Fi_n;            
b(sample,1) = Fi_p;

Psi = zeros(sample,1);%potencjaly
P = zeros(sample,1); %prawa strona
P_prim = zeros(sample,1); %pochodna prawej strony
tab_psi = zeros(Newton_i,sample);


for i=(sample/2+1):sample
 Psi(i) = Fi_p;
end 

for i=1:sample/2 % obszar n
        Psi(i) = Fi_n;
end
 


 for i = 1:sample
     x(i) = -Wn_wyk+(i-1)*h;             % ustalenie deltax
 end
 

for j=1:Newton_i %iteracje newtona
   j;
   Psi_Nminus=Psi;
    %katoda N
     for i=2:sample/2
            fi_n = 0;
            n = ni*exp((Psi(i)-fi_n)/Fite);
            p = (ni^2/n);
            P(i) = -q/Epsilon_Si*(p-n+N_D);
            P_prim(i) = q/Epsilon_Si*(p/Fite+n/Fite);
            A(i,i) = - 2 - P_prim(i)*(h^2);
            b(i) = P(i)*(h^2) - Psi(i)*P_prim(i)*(h^2);
     end
      %anoda P
       for i=(sample/2+1):sample-1
            fi_p = 0;
            p = ni * exp((fi_p - Psi(i))/Fite);
            n = (ni^2/p);
            P(i) = -q/Epsilon_Si*(p-n-N_A);
            P_prim(i) = q/Epsilon_Si*(p/Fite+n/Fite);
            A(i,i) = -2 - P_prim(i)*(h^2);
            b(i) = P(i)*(h^2) - Psi(i)*P_prim(i)*(h^2);
       end 

  Psi = A\b ;  %rownanie Poissona
  tab_Psi(j,:) = Psi;
%  Err_tab(j) = abs((Psi(i)-Psi(i+1))/abs(Psi(i+1)));    %blad bezwzgledny
  
 Err_c = double((Psi_Nminus - Psi)./Psi);
 Err(j) = double(sum(Err_c)/numel(Err_c));
 
 
 %warunek zakonczenia
   if abs(Err(j)) < eps
      break;
 end
 
end
  Err;
j
  figure(1)
       plot(x,tab_Psi(1,:),x,tab_Psi(2,:),x,tab_Psi(3,:),x,tab_Psi(4,:),x,tab_Psi(j,:),'Linewidth',2)
        xlabel('Szeroko?? struktury [m]','FontSize',12);
        ylabel('Potencja? elektrostatyczny   \Psi(x) [V]','FontSize',12);
        legend('Iteracja 1','Iteracja 2','Iteracja 3','Iteracja 4','Iteracja 9');
        title( 'Potencja? elektrostatyczny   \Psi(x) [V] po kolejnych iteracjach');
        grid on;
     
%end
%}

y=linspace(-0.2,0.5,1000);
figure(2)
plot(x, -P*Epsilon_Si,'b','Linewidth',2);
hold on;
plot(-W_n*ones(1,1000),y,'-r');
hold on;
plot(W_p*ones(1,1000),y,'-r');
%plot(W_p, y,'-b','LineWidth',2);
xlabel('Szeroko?? struktury (x) [m]','FontSize',12);
ylabel('G?sto?? ?adunku [C/cm^3]','FontSize',12);
grid on;



 figure(3)
        plot(x,tab_Psi(j,:),'Linewidth',2);
        xlabel('Szeroko?? struktury [m]','FontSize',12);
        ylabel('Potencja? elektrostatyczny   \Psi(x) [V]','FontSize',12);
        title( 'Potencja? elektrostatyczny   \Psi(x) [V]');
        grid on;
        
figure(4)
    semilogy(1:j,Err,'r','LineWidth',2);
    xlabel('numer iteracji','FontSize',12);
    ylabel('?redni b??d wzgl?dny','FontSize',12);
    grid on;      

%wykreslenie dodatkowych iteracji, widac oscylacje 
% figure(5)
%plot(10:100,Err(10:100),'r')    
%xlabel('numer iteracji','FontSize',12);
%ylabel('?redni b??d wzgl?dny','FontSize',12);
%grid on;      

        
     