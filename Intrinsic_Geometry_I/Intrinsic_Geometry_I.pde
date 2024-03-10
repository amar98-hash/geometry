/**
 * 2-D distorted geometry
 *
 * 
*/

int N =10, M=1, step=20;

float P[][] = new float[N][N];

float dt=0.0, maxPot=0.0, lim=1000.0;

class vec {
  float x = 0.0;
  float y = 0.0;
  float z = 0.0;


  vec(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

//------------------------------------------------//
class basis {
  float x1 = 0.0;
  float y1 = 0.0;
  float x2 = 0.0;
  float y2 = 0.0;
 

  basis(float x1, float y1, float x2, float y2) {
    
    //X- and Y-
    this.x1 = x1;
    this.y1 = y1;
    
    this.x2 = x2;
    this.y2 = y2;
    
  }
}
//------------------------------------------------//

basis [][] g = new basis[N][N];





vec [][] F = new vec[N][N];
vec [] pos_vec = new vec[M];
vec [] vel_vec = new vec[M];
vec [] acc_vec = new vec[M];

vec [][] color_vec  = new vec[N][N];


void setup() {
  size(600, 600);
  loadPixels();

  for (int i = 0; i<M; i++) {
    
  }
  
  for (int i = 0; i<N; i++) {
    for (int j = 0; j<N; j++) {
      g[i][j]= new basis(1,0,0,1);            //cartesian basis
      color_vec[i][j]= new vec(0.0, 0.0, 0.0);
    }
  }
  
  
}


void draw() {
  background(0);
  //fill(255, 204);

  dt=0.1;
  grid(50.0);
 
}


//------------------------------------------------//
void grid(float scale){
 stroke(200);
 
 float i_=0.0,j_=0.0;
 for (int i = 0; i<N; i++) {
    for (int j = 0; j<N; j++) {
      i_=scale*i;
      j_=scale*j;
      
      
      
      
      line(i_,j_, i_+scale,j_);
      line(i_,j_, i_,j_+scale);
      
    }
  }
  
  noStroke();

}
//------------------------------------------------//


void Potential(float x0, float y0) {
  float N_ = N, p, rho=0.1;

  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      P[i][j]=255*exp(-1/(rho)*(pow(float(i)/N_-x0/N_, 2) + pow(float(j)/N_-y0/N_, 2)));
      //println(P[i][j]);
    }
  }
}

void Force() {
  float N_ = N, p, theta=0.0, FMag=0.0;
  for (int j=1; j<N-1; j++) {
    for (int i=1; i<N-1; i++) {
      F[i][j].x=-(P[i+1][j]-P[i][j]);
      F[i][j].y=-(P[i][j+1]-P[i][j]);
      
      FMag=sqrt(pow(F[i][j].x, 2)+pow(F[i][j].y, 2));
      
      F[i][j].x= F[i][j].x/FMag;
      F[i][j].y= F[i][j].y/FMag;
     
    }
  }
}

void colorMap(boolean render) {
  // Loop through every pixel
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      // Create a color gradient.
      color_vec[i][j].x = P[i][j];       //red
      color_vec[i][j].y = 0.0;           //green
      color_vec[i][j].z = 255-P[i][j];   //blue
      if(render==true){
          color c = color(color_vec[i][j].x, color_vec[i][j].y, color_vec[i][j].z);
          //fill in the pixel array.
          pixels[j+i*N] = c;
      }
    }
  }
  if(render==true){    
     updatePixels();
  }
}

void drawArrow(float x1, float y1, float x2, float y2) {
  float a = dist(x1, y1, x2, y2) / 10;
  pushMatrix();
  translate(x2, y2);
  rotate(atan2(y2 - y1, x2 - x1));
  triangle(- a * 2, - a, 0, 0, - a * 2, a);
  popMatrix();
  line(x1, y1, x2, y2);
}
