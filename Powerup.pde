class Powerup{
  PVector vel;
  PVector pos;
  PImage type0img;
  PImage type1img;
  PImage type2img;
  float size;
  PShape coin;
  float type; // 0 : ppl++, 1 : sprayRadius++
  Powerup(PVector pos_){
    vel = new PVector(0,0,level+4-1);
    pos = pos_.copy();
    size = 100;
    float typeR = random(100);
    type0img = loadImage("particles.png");
    type1img = loadImage("radius.png");
    type2img = loadImage("wheel.png");
    if(typeR < 33){
      type = 0;
    }else if(typeR >= 33 && typeR < 67){
      type = 1;
    }
    else{
      type = 2;
    }
  }
  
  void display(){
    stroke(0);
    strokeWeight(1);
    noFill();
    //if(type == 0){    
    //  texture(type0img);
    //}
    //if(type == 1){
    //  texture(type1img);
    //}
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rect(-1,-1,size/2 + 1,size/2 + 1);
    if(type == 0){
      image(type0img,0,0,size/2,size/2);
    }
    if(type == 1){   
      image(type1img,0,0,size/2,size/2);
    }
    if(type == 2){
      image(type2img,0,0,size/2,size/2);
    }
  
    
    popMatrix();
 
  }
  
  void update(){
    pos.add(vel);
  }
  
  
}
