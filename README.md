# MOBI-mikroelektronika
## Zadanie 3
Dana jest dioda krzemowa jak na Rys. 3a ze złączem skokowym o następujących parametrach:
* koncentracja domieszki akceptorowej w obszarze typu p (anodzie) N<sub>A</sub> = 8 x 10 17 cm<sup>–3</sup>,
* koncentracja domieszki donorowej w obszarze typu n (katodzie) N<sub>D</sub> = 3 x 10 18 cm<sup>–3</sup>,
* długość obszarów n i p – kilkakrotnie dłuższa od głębokości obszarów zubożonych dla
braku polaryzacji,
* brak polaryzacji zewnętrznej (anoda zwarta z katodą).
Proszę stworzyć jednowymiarowy opis tej struktury w kierunku x prostopadłym do płaszczyzny
złącza (Rys. 3b). Korzystając z metody różnic skończonych wyznaczyć w tym przekroju rozkład
potencjału elektrostatycznego ψ(x) i wypadkowej gęstości nieskompensowanego ładunku
domieszek: w katodzie ρ(x) = q[N<sub>D</sub> (x) – n(x)+p(x)] i w anodzie ρ(x) = –q[N<sub>A</sub> (x) + n(x) – p(x)].

W sprawozdaniu podać przyjęte przybliżenie początkowe wektora ψ(x) – można eksperymentować
z kilkoma. Następnie:
* Wykreślić na wspólnym rysunku rozkład ψ(x) dla kilku – niekoniecznie kolejnych – iteracji
algorytmu Newtona. Jeśli po uzyskaniu zbieżności przy którymś kontakcie występuje
znaczący gradient potencjału, to znaczy, że należy zwiększyć grubość odpowiedniego
obszaru i powtórzyć dotychczasowe eksperymenty.
* Zaproponować miarę pozwalającą szacować na bieżąco odległość rozwiązania w danej
iteracji od rozwiązania „dokładnego”. Wykreślić wartość tej miary w funkcji liczby iteracji.
Na tej podstawie zaproponować kryterium zatrzymania algorytmu Newtona. Mile widziane
jest porównanie wpływu przybliżenia początkowego ψ(x) na kształt uzyskanej krzywej.
* Wykreślić ostateczny profil potencjału ψ(x) oraz lokalnej gęstości nieskompensowanego
ładunku domieszek ρ(x). Na wykresie ρ(x) zaznaczyć granice warstwy zaporowej obliczone
analitycznie przy założeniu zupełnego zubożenia. Obliczenia zamieścić w sprawozdaniu.
