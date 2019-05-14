import processing.sound.*;

import peasy.*;
SoundFile treeHitSound;
SoundFile waterSound; 
SoundFile spraySound;
boolean spraySoundPlaying = false;
boolean powerUpLive = false;
PImage backgroundImg;
PeasyCam cam;
Powerup p;
Character man;
PImage rock_texture;
PImage boat_texture; 
ArrayList<Obstacle> obs;
ArrayList<Tree> trees;
ArrayList<Particle> water;
float leftwall = 100;
float rightwall = 900;
PVector gravity;
Boat boat;
Tree tree;
Terrain river; 
Terrain b1;
Terrain b2;

int score;
int highScore;
int level;
void reset(){

  trees.clear();
  
  for(int i = 0; i < obs.size(); i++){
    obs.get(i).resetObstacle();
   
  }
  int treeBack = 0;
  for(int i = 0; i < 10; i++){
    treeBack -= 500;
    float distUp = height - 150;
    float h_ = random(100,400);
    Tree t = new Tree(new PVector(leftwall + 200 + random(-200,-100),distUp,treeBack), h_);

    
    trees.add(t);
  }
  treeBack = 0;
  for(int i = 0; i < 10; i++){
    treeBack -= 500;
    float h_ = random(100,400);
    trees.add(new Tree(new PVector(rightwall - 200 + random(100,200),height-150,treeBack),h_));
  }
  man.resetSelf();
  boat.resetSelf();
  score = 0;
  level = 1;

}
void setup(){
  size(1000,700,P3D);
  man = new Character();
  score = 0;
  rock_texture = loadImage("rock.jpg");
  boat_texture = loadImage("WoodFine0025_M.jpg");
  level = 1;
  obs = new ArrayList<Obstacle>();
  water = new ArrayList<Particle>();
  trees = new ArrayList<Tree>();
  boat = new Boat(new PVector(width/2,height/2));
  //translate(500,500);
  //cam = new PeasyCam(this, 100);
 
  river = new Terrain(100000,width/2, 100,400,5000, color(0,50,255), 20, .09, 20, 0.2);
  b1 = new Terrain(20,-500, 150,2000,5000, color(194, 178, 128), 200, .005, 100, 3);
  b2 = new Terrain(-20,1700,150,2000,5000, color(194, 178, 128), 200, .009, 100, 3);
  gravity = new PVector(0,0.01,0);
  treeHitSound = new SoundFile(this, "data/treeHit.wav");
  waterSound = new SoundFile(this, "data/water.wav");
  spraySound = new SoundFile(this, "data/spray.wav");
  
  waterSound.amp(0.1);
  waterSound.loop();
  
  backgroundImg = loadImage("sen.png");
  int farBack = 0;
  for(int i = 0; i < 6; i++){
    farBack -= 500;
    obs.add(new Obstacle(new PVector(random(leftwall + 200 + 60, rightwall - 200 - 60),height - 100,farBack),40));
  }
  int treeBack = 0;
  for(int i = 0; i < 10; i++){
    treeBack -= 500;
    float distUp = height - 150;
    float h_ = random(100,400);
    Tree t = new Tree(new PVector(leftwall + 300 + random(-200,-100),distUp,treeBack), h_);

    
    trees.add(t);
  }
  treeBack = 0;
  for(int i = 0; i < 10; i++){
    treeBack -= 500;
    float h_ = random(100,400);
    trees.add(new Tree(new PVector(rightwall - 300 + random(100,200),height-150,treeBack),h_));
  }
}

void draw(){
  float givePowerup = random(1,100);
  
  if(givePowerup < 2 && !powerUpLive){
    p = new Powerup(new PVector(random(leftwall + 300, rightwall - 300), height - 300, -2000));
    powerUpLive = true;
 
  }
  
  background(backgroundImg);
  camera(width/2,300,500,width/2,height-100,0,0,1.0,0);
  if(powerUpLive){
    p.display();
    p.update();
    if(man.checkPowerUpHit()){
   
      powerUpLive = false;
      p.size = 0;
      if(p.type == 0){
        man.gun.particlesPerLoop++;
      }
      if(p.type == 1){
        man.gun.sprayRadius++;
      }
      if(p.type == 2){
        man.boatTurnSpeed++;
      }
    }
  }
  fill(0);
  textSize(70);
  text(score, 100, 100); 
  text(highScore, 400, 100); 
  
  man.display();
  if(man.checkObstacleCollisions() || man.checkBoundCollision()){
    if(score > highScore){
      highScore = score;
    }
    reset();
  }

  man.update();
  river.update();
  river.display();
  boat.display();
  b1.update();
  b1.display();
  b2.update();
  b2.display();
  for(Tree t : trees){
    t.display();
    t.update();
    if(t.location.z > 2000){
      t.respawn();
    }
    if(t.size > 300){
      t.respawn();
      treeHitSound.play();
      score++;
      if(score % 5 == 0){
        level++;
        for(Obstacle o : obs){
          o.vel.z++;
        }        
      }
    }
  }


  for(Obstacle o : obs){  
    o.display();
    o.update();
    if(o.pos.z > 250){
      o.respawn();
    }
  }
  if(powerUpLive && p.pos.z > 450){
    powerUpLive = false;
  }
  
  for(int i = water.size() - 1; i >= 0; i--){
    Particle p = water.get(i);
    p.update();
    p.display();  
    p.checkTreeCollision();
    p.applyForce(gravity);
    if(p.finished()){
      water.remove(i);
    }
  }

}
