class Obstacle{
  PVector pos;
  PVector vel;
  float r;
  PShape rock;
  float angle;
  float leftW = 300;
  float rightW = 700;
  float rotZ;
  float rotY;
  Obstacle(PVector pos_, float r_){
    
    pos = pos_.copy();
    angle = 0;
    rotZ = 0;
    rotY = 0;
    vel = new PVector(0,0,4);
    r = r_;
    rock = createShape(SPHERE,r);
    rock.setTexture(rock_texture);
    rock.setStrokeWeight(0);
    rock.setFill(false);
  }
  void display(){

    noFill();
    noStroke();
    pushMatrix();
    
    translate(pos.x,pos.y,pos.z);
    beginShape();
    texture(rock_texture);
    shape(rock);
    endShape();
    popMatrix();    
    
  }
  
  void resetObstacle(){
    pos = new PVector(random(leftW + r, rightW - r),height - 100,random(-4000,-1000));
    vel = new PVector(0,0,4);
  }
  void update(){
    pos.add(vel);
  }
  
  void respawn(){
    pos = new PVector(random(leftW + r, rightW - r),height - 100,-1500);
  }
}
