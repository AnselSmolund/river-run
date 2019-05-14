class Boat{
  PShape boat;
  PVector location;
  float size;
  float fil;
  float tilt; 
  
  Boat(PVector loc){
    boat = loadShape("Canoe.obj");
    location = loc.copy();
    //boat.setTexture(boat_texture);
    boat.setFill(color(193, 154, 107));
    size = 100;
    fil = 0;
    tilt = 0;
  }  
  void resetSelf(){
    location.x = width/2;
    tilt = 0;
  }
  void display(){

    fill(210,105,30);
    pushMatrix();
   // rotateY(PI);  
    
    lights();
    translate(location.x - width/2,location.y - 130,location.z);
    if(location.x/20 < river.cols-1 && location.x/20 > 0){
      translate(0,river.points[int(location.x/20)][river.rows-1]/3,0);
    }
    translate(width/2,height/2);
    rotateX(PI);
    rotateY(PI/2);
    rotateX(tilt);
    rotateY(tilt);

    //translate(-width/2,-height/2);
    scale(40);

    shape(boat);
     
    popMatrix();

  }
  
  void update(){
    
  }

    
}
