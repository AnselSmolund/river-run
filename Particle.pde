class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float radius;
  float mass;
  float life;
  color col = color(0,0,255,life);
   
  Particle(PVector loc, PVector vel){
    velocity = new PVector(vel.x,vel.y,vel.z);
    acceleration = new PVector(0,0,0);
    mass = random(10);
    radius = mass / 2;
    location = new PVector(loc.x,loc.y,loc.z);
    life = 255;
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    //acceleration.mult(0);
    life-=random(1,2);
  }
  void checkTreeCollision(){
    for(int i = 0; i < trees.size(); i++){
      Tree t = trees.get(i);          
    //  t.fil = map(PVector.dist(location,t.location),0,PVector.dist(location,t.location),255,0);
      if(PVector.dist(location,t.location) < t.size/2){
        t.fil = 255;
        t.size+=0.1;
     
      }
    }
  }
  void display(){
    pushMatrix();
  

    //translate(man.pos.x,man.pos.y,man.pos.z);
    //rotateY(man.rotation_angle);
    //translate(-man.pos.x,-man.pos.y,-man.pos.z);
    

    stroke(0,0,random(200,255),life*3);
    strokeWeight(radius);
    point(location.x,location.y,location.z-700);
    popMatrix();
  }

  boolean finished(){
    if(life < 0.0){
      return true;
    }else{
      return false;
    }
  } 
}
