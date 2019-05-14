class Terrain{
  float[][]points;
  int w;
  int h;
  int scl;
  int cols,rows;
  float flying;
  float rot;
  float xoffset;
  float yoffset;
  color col;
  float tSpeed;
  float intensity;
  float rowOffset;
  
  Terrain(float rot_, float xoffset_, float yoffset_, int w_, int h_, color col_, int scl_, float tSpeed_, float i_, float r_){
    tSpeed = tSpeed_;
    scl = scl_;
    w = w_; // water: 400
    h = h_; // water: 5000
    cols = w / scl;
    rows = h / scl;
    points = new float[cols][rows];
    flying = 0;
    rot = rot_; // water: 0, 
    xoffset = xoffset_; // water: width/2
    yoffset = yoffset_;
    col = col_;
    intensity = i_;
    rowOffset = r_;
  }
  void update(){  
    flying -= tSpeed;     
    float yoff = flying;
    for(int y = 0; y < rows; y++){
      float xoff = 0;
      for(int x = 0; x < cols; x++){
        points[x][y] = map(noise(xoff,yoff),0,1,-intensity,intensity);
        xoff += rowOffset;
      }
      yoff += 0.2;
    }
  }
  //void getPoint(float x_, float y_, float z_){
  //  float closest = 0;
  //  float min = 10000;
  //  float x = 0;
  //  float y = 0;
  //  for(int y = 0; y < rows - 1; y++){
  //    for(int x = 0; x < cols; x++){
  //      if(points[x][y] < min){
  //        min = points[x][y];
  //        x = x
               
  //    }
  //  }
    
  //}
  void display(){
    pushMatrix();
    translate(xoffset,height - yoffset, -2000);
    lights();
    rotateX(PI/2);
    rotateY(PI/rot);
    translate(-w/2,-h/2);
    for(int y = 0; y < rows-1; y++){
      beginShape(TRIANGLE_STRIP);
      noStroke();
      
      fill(col);
      for(int x = 0; x < cols; x++){
        vertex(x*scl, y*scl, points[x][y]);
        vertex(x*scl, (y+1)*scl, points[x][y+1]);
      }
      endShape();
    }
    popMatrix();
    
  }
  
  
  
    
}
