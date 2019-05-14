class Tree{
  PShape tree;
  PVector location;
  PVector p_pos;
  PVector vel;
  float size;
  float h;
  float fil;
  Tree(PVector loc, float h_){
    tree = loadShape("Lowpoly_tree_sample.obj");
    //location = new PVector(50,-500,-300);
    location = loc.copy();
    size = 200;
    vel = new PVector(0,0,5.1);
    fil = 0;
    h = h_;
  }  
  void display(){

    pushMatrix();
  //  rotateX(PI);

    translate(location.x - width/2,location.y - height/2,location.z - 700);
    translate(width/2,height/2);
    rotateX(PI);
    //translate(-width/2,-height/2);
    shape(tree,0,0,size,h);
 
    
    popMatrix();

  }
  
  void update(){
    location.add(vel);
  }
  void respawn(){
    h = random(100,400);
    float r = random(1);
    if(r < .5){
      location = new PVector(leftwall + 300 + random(-200,-100),height-150,random(-4000,-5000));
      
    }else{     
      location = new PVector(rightwall - 300 + random(100,200),height-150,random(-4000,-5000));
    }
    size = 200;
  }
    
}
