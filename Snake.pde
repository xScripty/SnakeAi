import java.util.ArrayList; 

class Snake{
  PVector position,lastPosition,velocity;
  float size,fitness;
  Food food;
  ArrayList<PVector> tail;
  boolean dead;
  NeuralNetwork brain;
  PVector[] outputDecipher={new PVector(0,-1),new PVector(0,1),
      new PVector(-1,0),new PVector(1,0)};
  int deathTimer,TIMER_MAX=125,tilesMoved;
  Sensor sensor;
  
  Snake(){
    this.position=new PVector(scale*(gridLength/2),scale*(gridLength/2));
    this.velocity=new PVector(1,0);
    this.size=scale;
    this.food=new Food();
    this.tail=new ArrayList<PVector>();
    this.dead=false;
    this.brain= new NeuralNetwork(6,3,4);
    this.deathTimer=this.TIMER_MAX;
    this.tilesMoved=0;
    this.sensor=new Sensor(this);
  }
  
  void update(){
    if (dead){
      return;
    }
    float[] brainInput=this.sensor.getInputs();
    int output= this.brain.feedForward(brainInput);
    this.setDir(this.outputDecipher[output]);
    
    PVector scaledVelocity=PVector.mult(this.velocity,scale);
    this.lastPosition=this.position.copy();
    this.position.add(scaledVelocity);
    
    if(!this.checkFood()){
      this.shiftTail();
    }
    this.checkDeath();
    this.deathTimer--;
    tilesMoved++;
    
  }
  
  void calcFitness(){
    float timeWeight=0.2,lengthWeight=200;
    float timeScore=this.tilesMoved*timeWeight;
    float lengthScore=(float)Math.pow(this.tail.size(),3)*lengthWeight;
    
    this.fitness=timeScore+lengthScore;

  }
  
  
  
  void shiftTail(){
    int tailSize=this.tail.size();
    for (int i=1;i<tailSize;i++){
      this.tail.set(i-1,this.tail.get(i));
    }
    if(tailSize!=0){
      this.tail.set(tailSize-1,this.lastPosition.copy());
    }
  }
  
  boolean checkFood(){
    boolean foundFood=false;
    float distance=dist(this.food.pos.x,this.food.pos.y
            ,this.position.x,this.position.y);
    if (distance<1){
      foundFood=true;
      this.eatFood();    
    }
    return foundFood;
  }  
  void eatFood(){
    this.deathTimer=this.TIMER_MAX;
    PVector scaledVelocity=PVector.mult(this.velocity,scale);
    this.food.pickLocation();
    this.tail.add(PVector.sub(this.position,scaledVelocity));
  }    
 
  void checkDeath(){
    boolean tooWide=this.position.x<0||this.position.x>width;
    boolean tooHigh=this.position.y<0||this.position.y>height;
    boolean noFood=this.deathTimer<=0;

    if (tooWide||tooHigh||noFood){
      this.dead=true;
      this.calcFitness();
    }
    else{
      this.checkBodyHit();
    }
  }
  
  
  void checkBodyHit(){
    for(PVector part :this.tail){
      if (dist(part.x,part.y,this.position.x,this.position.y)<1){
        this.dead=true;
      }
    }
  }
 
  void setDir(PVector dir){
    this.velocity=dir;
  }
  
  void show(){
    if (dead){
      return;
    }
    
    fill(255,0,60);
    food.show();
    
    fill(70);
    rect(this.position.x,this.position.y,this.size,this.size);
    for(PVector part:this.tail){
      rect(part.x,part.y,this.size,this.size);
    }
    //this.brain.displayer.display();
  }
}
