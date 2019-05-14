class Character{
  PVector pos;
  PVector vel;
  PVector acc;
  float w;
  float h;
  color col;
  float col_count;
  float rotation_angle;
  float boatTurnSpeed = 3;
  Gun gun;
  Character(){
    pos = new PVector(width/2,height-130,0);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    w = 20;
    h = 60;
    col = color(51);
    col_count = 0;
    
    rotation_angle = 0;
    //pos, w, h, sprayradius, ppl, size
    gun = new Gun(new PVector(pos.x, pos.y, pos.z),100,5,0,1,10);
    
  }

  boolean checkObstacleCollisions(){
    for(int i = 0; i < obs.size(); i++){
      float d = PVector.dist(pos,obs.get(i).pos);
      if(d - obs.get(i).r - 10 < w/2){
        return true;
      }
      else{
        col = color(51);
      }
    }
    return false;
  }
  
  boolean checkPowerUpHit(){
    float d = PVector.dist(pos,p.pos);
    if(d - p.size < h/2){
      return true;
    }else{
      return false;
    }
  }
  
  boolean checkBoundCollision(){
    if(pos.x + w > rightwall + 60 || pos.x - w < leftwall - 60){
      return true;
      
    }
    return false;
  }
  
  void resetSelf(){
    pos.x = width/2;
    rotation_angle = 0;
    gun.pos = pos.copy();
    gun.particlesPerLoop = 1;
    gun.sprayRadius = 0;
    boatTurnSpeed = 3;
    
  }
  void display(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(col);
    noStroke();
    rotateY(rotation_angle);
    box(w,h,w);
    popMatrix();
    gun.display();
    
  
  }
  
  void jump(){
    acc.y = -0.5;   
  
  }
  void update(){
    gun.update();
    vel.y += acc.y;
    pos.y += vel.y;
    acc.add(new PVector(0,.1,0));
    
    if(pos.y > height - 130){
      pos.y = height - 131;
      vel.y = 0;
    }
  
    
    rotation_angle = map(mouseX,0,width,0,-PI);
    if(keyPressed == true){
      if(keyCode == 37 || key == 'a'){   
        man.pos.x-=boatTurnSpeed;
        gun.pos.x-=boatTurnSpeed;
        boat.location.x-=boatTurnSpeed;
        boat.tilt-=0.01;
      }
      if(keyCode == 39 || key == 'd'){
        man.pos.x+=boatTurnSpeed;
        gun.pos.x+=boatTurnSpeed;
        boat.location.x+=boatTurnSpeed;
        boat.tilt+=0.01;
      }
      if(key == 'w'){
        jump();      
      }        
    }
    else{
      if(boat.tilt > 0){
        boat.tilt -= 0.01;
      }
      if(boat.tilt < 0){
        boat.tilt += 0.01;
      }
    }

  }
    
}
