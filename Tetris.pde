int[][] mapa =  {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                  {10, 10, 10, 10, 10, 10, 10, 10, 10, 10}};
int r = int(random(7));
//Cordenadas de cada cuadro que forma la ficha, color, numero de pieza
int [][][] pieza = {{{-1, 0}, {0, 1}, {1, 1}, {255, 0, 0}, {1}}, //z
                    {{1, 0}, {0, 1}, {-1, 1}, {0, 255, 0}, {2}}, //s
                    {{-1, 0}, {2, 0}, {1, 0}, {0, 255, 255}, {3}}, //I
                    {{1, 0}, {1, 1}, {-1, 0}, {0, 0, 255}, {4}}, //j
                    {{-1, 1}, {1, 0}, {-1, 0}, {255, 128, 0}, {5}}, //l
                    {{0, 1}, {1, 0}, {1, 1}, {255, 255, 0}, {6}}, //o
                    {{0, 1}, {-1, 0}, {1, 0}, {87, 35, 100}, {7}}};//t
int x = 4;
int y = 0;
int[][] pieza_actual;
int[][] pieza_siguiente;        
int gravedad = 60;
int gravedad_actual = 60;
int puntaje = 0;
int puntaje_lin = 0;
int nivel=0;
void setup() {
  background(240, 48, 200);
  size(1000, 700);
  pieza_actual=crear_pieza(pieza);
  pieza_siguiente=crear_pieza(pieza);
}
void draw() {
  principal();
  texto();
  actualizar_mapa(mapa);
  dibujarMapa(mapa);
  dibujar_pieza(pieza_siguiente, 15, 6);
  dibujar_pieza(pieza_actual, x, y);
  if (quieto(pieza_actual, mapa, x, y)==true) {
    guarda( mapa, pieza_actual, x, y);
    pieza_actual=pieza_siguiente;
    pieza_siguiente=crear_pieza(pieza);
    y=1;
    x=4;
  }
 gravedad=gravedad_actual;
  if (frameCount %gravedad==0 && quieto(pieza_actual, mapa, x, y) == false) {
    y++;
  }
  perder();
  ganar();
  gravedad=gravedad_actual;
}
void principal() {
   fill(0);
  rect(width/2+250, height/2-300, 200, 350);
  rect(width/2-450, height/2-300, 200, 250);
  rect(width/2-450, height/2, 200, 300);
}
void texto(){
strokeWeight(1);
  textSize(30);
  fill(240, 48, 200);
  text(25000-puntaje,100,210);
  text(nivel,130,430);
  text(puntaje_lin,130,520);
  text(puntaje,130,610);
  fill(255);
  text("PUNTOS ", 90, 100);
  text("PARA GANAR ", 55, 140);
  text("PIEZA", 810, 100);
  text("SIGUIENTE", 770, 140);
  textSize(25);
  text("NIVEL", 110, 390);
  text("LÍNEAS", 100, 480);
  text("SCORE", 100, 570);
  text("OBJETIVO",15,720);
}
//Cuadrado central de la pieza
void cuadrado(int x, int y) {
  rect(32 * x + width/2-150, 32 * y + height/2-320, 32, 32);
}
//Dibuja cuadricula de la matriz
void dibujarMapa(int [][] mapa) {
  for (int fila = 0; fila < mapa.length; fila++) {
    for (int columna = 0; columna < mapa[0].length; columna++) {
      stroke(250); 
      if (mapa[fila][columna] == 0) {        
        fill(0, 0, 0);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 1) {        
        fill(255, 0, 0);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 2) {        
        fill(0, 255, 0);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 3) {        
        fill(0, 255, 255);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 4) {        
        fill(0, 0, 255);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 5) {        
        fill(255, 128, 0);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 6) {        
        fill(255, 255, 0);
        cuadrado(columna, fila);
      }
      if (mapa[fila][columna] == 7) {        
        fill(87, 35, 100);
        cuadrado(columna, fila);
      }
    }
  }
}
//Guarda el numero de cada cuadro, con respecto a la pieza en la matriz
void guarda(int[][] mapa, int [][] pieza, int x, int y ) {
  int a;
  int b;
  for (int i=0; i<=2; i++) {
    a = pieza[i][0]+x;
    b = pieza[i][1]+y;
    mapa [y][x]= pieza[4][0];
    mapa[b][a] = pieza[4][0];
  }
}
void dibujar_pieza(int [][] pieza, int x, int y) {
  fill(pieza[3][0], pieza[3][1], pieza[3][2]);
  cuadrado(x, y); 
  for (int i = 0; i<4; i++) {
    cuadrado(x+pieza[i][0], y+pieza[i][1]);
  }
}
int[][] crear_pieza(int [][][] pieza) {
  int r = int(random(7));  
  return pieza[r];
}
//Verifica que no haya nada abajo para todo la pieza
boolean quieto(int [][] pieza, int[][] mapa, int x, int y ) {
  if (mapa[y+1][x] != 0) {
    return true;
  }
  if (mapa[pieza[0][1]+1+y][pieza[0][0]+x] != 0) {
    return true;
  }
  if (mapa[pieza[1][1]+1+y][pieza[1][0]+x] != 0) {
    return true;
  }
  if (mapa[pieza[2][1]+1+y][pieza[2][0]+x] != 0) {
    return true;
  }
  return false;
}
int niveles(int puntaje){
  if (puntaje <= 5000){
    gravedad_actual=60;
    nivel=1;
    }
  if (puntaje >= 5000){
    gravedad_actual=40;
    nivel=2;
    }
  if (puntaje >= 10000){
    gravedad_actual=30;
    nivel=3;
    }
  if (puntaje >= 15000){
    gravedad_actual=20;
    nivel=4;
    }
  if (puntaje >= 20000){
    gravedad_actual=15;
    nivel=5;
    }
    if (puntaje >= 23000){
    gravedad_actual=10;
    nivel=(6);
    }
    return gravedad_actual;
}
//rota cada cuadro de la pieza dependiendo de las cordenadas en que se encuentre
void rotar(int [][] pieza) {
  if (pieza[4][0] !=6) {
    for (int i=0; i<=2; i++) {
      if (pieza[i][0]==1 && pieza[i][1]==0) {
        pieza[i][0]=0;
        pieza[i][1]=-1;
      } else if (pieza[i][0]==1 && pieza[i][1]==-1) {
        pieza[i][0]=-1;
      } else if (pieza[i][0]==0 && pieza[i][1]==-1) {
        pieza[i][0]=-1;
        pieza[i][1]=0;
      } else if (pieza[i][0]==-1 && pieza[i][1]==-1) {
        pieza[i][1]=1;
      } else if (pieza[i][0]==-1 && pieza[i][1]==0) {
        pieza[i][0]=0;
        pieza[i][1]=1;
      } else if (pieza[i][0]==-1 && pieza[i][1]==1) {
        pieza[i][0]=1;
        pieza[i][1]=1;
      } else if (pieza[i][0]==0 && pieza[i][1]==1) {
        pieza[i][0]=1;
        pieza[i][1]=0;
      } else if (pieza[i][0]==1 && pieza[i][1]==1) {
        pieza[i][0]=1;
        pieza[i][1]=-1;
      } else if ((pieza[i][0]==0 && pieza[i][1]==2)||(pieza[i][0]==2 && pieza[i][1]==0)) {
        int aux=pieza[i][0];
        pieza[i][0]=pieza[i][1];
        pieza[i][1]=aux;
      }
    }
  }
}
// actualiza el mapa
void actualizar_mapa(int[][] mapa ) {
  for (int i = 0; i<=18; i++) {
    if (fila_compl( mapa[i])) {
      borrar_fila(mapa, i);
      puntaje=puntaje+1000;
      puntaje_lin=puntaje_lin+1;
    }
  }
}
// Verifica si la fila esta llena
boolean fila_compl(int [] mapa) {
  for (int i = 0; i<10; i++) {
    if (mapa[i]==0) {
      return false;
    }
  }
  return true;
}
//borra ala fila y baja los cuadros de arriba
void borrar_fila(int[][] mapa, int fila) {
  for (int i = fila; i>0; i--) {
    for (int j = 0; j<10; j++) {
      mapa[i][j] = mapa[i-1][j];
    }
  }
  for (int k = 0; k<10; k++) {
    mapa[0][k] = 0;
  }
}
boolean limrota(int [][] pieza, int[][] mapa, int x, int y ) {
  boolean f = false;
  int z=9;
  if (pieza[4][0]==3) {
    z=8;
  }

  for (int i = 0; i<=2; i++) {
    if ( mapa[y+pieza[i][0]][x+limiteder(pieza)] != 0|| (x+limiteder(pieza)!= 9 && x+limiteder(pieza)!= z && x+limiteizq(pieza)!=0)) {

      f= true;
    }
  }
  return f;
}

int limiteder(int [][] pieza_actual) {
  int lon=0;
  for (int i=0; i<=2; i++) {
    if (pieza_actual[i][0]==2) {
      lon=2;
    } else if (pieza_actual[i][0]==1 && lon<1) {
      lon=1;
    }
  }
  return lon;
}
int limiteizq(int [][] pieza_actual) {
  int lon1=0;
  for (int i=0; i<=2; i++) {
    if (pieza_actual[i][0]==-2) {
      lon1=-2;
    } else if (pieza_actual[i][0]==-1 && lon1>-1) {
      lon1=-1;
    }
  }
  return lon1;
}
void perder(){
  if((quieto(pieza_actual,  mapa,  x, y )==true && y<=3 )) {
   
    fill(0);
    rect(0,0,1000,700);
    fill(255,0,0);
    textSize (100);
    text("GAME OVER",250,250);
    textSize (50);
    text("Perdiste, sigue intentando",150,500);
    text("Puntaje : ",150,600);
    text( puntaje ,500,600);
}}
void ganar(){
  if((puntaje>=25000 )) {
   
    fill(0);
    rect(0,0,1000,700);
    fill(240, 48, 200);
    textSize (150);
    text("GANASTE",150,250);
    textSize (50);
    text("COMPLETASTE EL RETO",220,400);
    text("LINEAS LOGRADAS : ",250,600);
    text( puntaje_lin ,750,600);
}}
void keyTyped() {

  if ((key == 'q' || key == 'Q') && limrota( pieza_actual, mapa, x, y)==true ) {
    rotar(pieza_actual);
  }
}
void keyPressed() {
  if (keyCode == LEFT && x +limiteizq(pieza_actual)>0  ) {
    x--;
  }
  if (keyCode == RIGHT && x + 1 +limiteder(pieza_actual)<mapa[0].length) {
    x++;
  } 
  if (keyCode == DOWN) {
    gravedad_actual = 2;
    puntaje= puntaje+10;
  }
}

void keyReleased() {
  if ((keyCode == DOWN) ) {
    gravedad_actual = niveles(puntaje);
  }
}
