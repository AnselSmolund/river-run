class Gun{
  PVector pos;
  float w;
  float h;
  float angleY;
  float angleX;
  float sprayRadius;
  float particlesPerLoop;
  float sizeOfParticle;

  Gun(PVector pos_, float w_, float h_, float sr, float ppl, float s){
    pos = pos_.copy();
    w = w_;
    h = h_;
    angleY = 0;
    noStroke();
    sprayRadius = sr;
    particlesPerLoop = 5;
    sizeOfParticle = s;
  }
  
  void display(){

    
    //pushMatrix();
    //translate(man.pos.x,man.pos.y,man.pos.z);
    //rotateY(angleY);
    //rotate(angleX);
    ////popMatrix();
    
    ////pushMatrix();
    //translate(-10,-20,0);
    //fill(0);
    //box(w,h,5);
    //popMatrix();
  }
  
  void update(){
    angleY = man.rotation_angle;
    //angleX = map(mouseY,0,height,-2,-1);
    if(mousePressed){
      if(!spraySoundPlaying){ 
        spraySound.loop();
      }
      spraySoundPlaying = true;
      for(int i = 0; i < particlesPerLoop; i++){
        float x = man.gun.pos.x;
        float y = man.gun.pos.y;
        float z = man.gun.pos.z;
        float angY = map(angleY,0,-PI,-10,10);
        float angX = map(mouseY,0,height,-10,0);
        Particle p = new Particle(new PVector(x,y,z+700),new PVector(angY + random(-sprayRadius,sprayRadius),-2,-10));
        p.radius = random(sizeOfParticle)/2;
        water.add(p); 
      }    
    }else{
      spraySound.stop();
      spraySoundPlaying = false;
    }
  }
    
  
}
