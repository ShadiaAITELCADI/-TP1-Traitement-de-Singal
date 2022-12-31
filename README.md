# TP1- Analyse spectrale d’un signal Transformée de Fourier discrète


<summary>Table of Contents</summary>
  <ol>      
      <li><a href="#Objectifs">Objectifs</a></li>
      <li><a href="#Représentation-temporelle-et-fréquentielle">Représentation temporelle et fréquentielle</a></li> 
      <li><a href="#Analyse-fréquentielle-du-chant-du-rorqual-bleu">Analyse fréquentielle du chant du rorqual bleu</a></li> 
  </ol>
  
  
  
# Objectifs 
- Représentation de signaux et applications de la transformée de Fourier discrète (TFD) sous Matlab. 
- Evaluation de l’intérêt du passage du domaine temporel au domaine fréquentiel  dans l’analyse et l’interprétation des signaux physiques réels.

 >**Commentaires** : Il est à remarquer que ce TP traite en principe des signaux continus. 
Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc être 
vigilant par rapport aux différences de traitement entre le temps continu et le temps 
discret.

> **Tracé des figures**: toutes les figures devront être tracées avec les axes et les 
légendes des axes appropriés.

> **Travail demandé** : un script Matlab commenté contenant le travail réalisé et des
commentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a 
semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

# Représentation temporelle et fréquentielle 
Considérons un signal périodique x(t) constitué d’une somme de trois sinusoïdes de 
fréquences 440Hz, 550Hz, 2500Hz.

**𝐱(𝐭) = 𝟏. 𝟐𝐜𝐨𝐬(𝟐𝐩𝐢𝟒𝟒𝟎𝐭 + 𝟏. 𝟐) + 𝟑𝐜𝐨𝐬(𝟐𝐩𝐢𝟓𝟓𝟎𝐭) + 𝟎. 𝟔𝐜𝐨𝐬(𝟐𝐩𝐢𝟐𝟓𝟎𝟎𝐭)**

1- Tracer le signal x(t). Fréquence d’échantillonnage : fe = 10000Hz, Intervalle :Nombre d’échantillons : N = 5000.
>Pour approximer la TF continue d’un signal x(t), représenté suivant un pas Te, on utilise les deux commandes : fft et fftshif.
```matlab
%-Q1
fe = 1e4;
te = 1/fe;
N = 10000; 

t = (0:N-1)*te; 
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
plot(t,x);
```
<img width="999" alt="1" src="https://user-images.githubusercontent.com/89936910/210148313-89f13287-f771-4dc1-a0bb-5d3caca90276.png">

2- Calculer la TFD du signal x(t) en utilisant la commande fft, puis tracer son spectre en amplitude après avoir créé le vecteur f qui correspond à l'échantillonnage du signal dans l'espace fréquentiel. Utiliser la commande abs pour afficher le spectre  d’amplitude.

```matlab
%-Q2
 f =(0:N-1)*(fe/N); 
 y = fft(x); 
 plot(f,abs(y));

```
<img width="999" alt="2" src="https://user-images.githubusercontent.com/89936910/210148708-0bb2c6b3-cd07-429b-97ae-ed91ac35fb58.png">)

3. Pour mieux visualiser le contenu fréquentiel du signal, utiliser la fonction fftshift, qui effectue un décalage circulaire centré sur zéro du spectre en amplitude obtenu par la commande fft.
```matlab
%-Q3
 fshift = (-N/2:N/2-1)*(fe/N)
 plot(fshift,fftshift(2*abs(y)/N))

```
<img width="999" alt="3" src="https://user-images.githubusercontent.com/89936910/210148774-7a0423ef-fd4d-48dc-b222-7ad489e0f5ad.png">

>Un bruit correspond à tout phénomène perturbateur gênant la transmission ou l'interprétation d'un signal. Dans les applications scientifiques, les signaux sont souvent >corrompus par du bruit aléatoire, modifiant ainsi leurs composantes fréquentielles. La TFD peut traiter le bruit aléatoire et révéler les fréquences qui y correspond

4- Créer un nouveau signal xnoise, en introduisant un bruit blanc gaussien dans le signal d’origine x(t), puis visualisez-le. Utiliser la commande randn pour générer ce bruit. Il est à noter qu’un bruit blanc est une réalisation d'un processus aléatoire dans lequel la densité spectrale de puissance est la même pour toutes les fréquences de la bande passante. Ce bruit suit une loi normale de moyenne 0 et d’écart type 1.
```matlab
%-Q4
 bruit = 50*randn(size(x));
 plot(bruit,'r')
```
<img width="999" alt="4" src="https://user-images.githubusercontent.com/89936910/210148865-bbb529e5-c262-494d-a308-d75ece2d8ea2.png">
 ```matlab
 bruit = 50*randn(size(x));
 xnoise = x+bruit;
 plot(xnoise);
```
<img width="999" alt="4,1" src="https://user-images.githubusercontent.com/89936910/210149039-10e8cb20-3f3f-4b16-ad15-41cff4988b65.png">

5 – Utiliser la commande sound pour écouter le signal et puis le signal bruité.
 ```matlab
 %-Q5
 %signal
 sound(x)
 %signal avec bruit
 sound(xnoise)
 ```
> La puissance du signal en fonction de la fréquence (densité spectrale de puissance)est une métrique couramment utilisée en traitement du signal. Elle est définie comme 
>étant le carré du module de la TFD, divisée par le nombre d'échantillons de fréquence. 


6- Calculez puis tracer le spectre de puissance du signal bruité centré à la fréquence zéro. 
```matlab
 %-Q6
 ybruit = fft(xnoise);
 plot(fshift,fftshift(abs(ybruit)));
 ```
 <img width="999" alt="6" src="https://user-images.githubusercontent.com/89936910/210149268-0967ca7b-cd77-48eb-a321-9638c11b8539.png">
 
 7- Augmenter l’intensité de bruit puis afficher le spectre. Interpréter le résultat obtenu.
 ```matlab
 %-Q7
  bruit = 60*randn(size(x));
 xnoise = x+bruit;
 ybruit = fft(xnoise);
 plot(fshift,fftshift(abs(ybruit)));
 ```
 <img width="999" alt="7" src="https://user-images.githubusercontent.com/89936910/210149333-37d7d8ba-e8ba-4a8c-937c-eb63636e3a6f.png">
