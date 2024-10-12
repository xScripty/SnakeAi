float scale;
int gridLength;
Snake testSnake;
Population pop;

void setup(){
  size(1000,1000);
  frameRate(7);
  
  gridLength=15;
  scale=width/(float)gridLength;
  
  //testSnake=new Snake();
  pop=new Population(10000);
}

void draw(){
  background(0);
  //testSnake.show();
  //testSnake.update();
  for(int i=0;i<3;i++){
    pop.update();
  }
  
  pop.showBest();
}

void keyPressed(){
  if(keyCode==UP){
    testSnake.setDir(new PVector(0,-1));
  }else if(keyCode==DOWN){
    testSnake.setDir(new PVector(0,1));
  }else if(keyCode==LEFT){
    testSnake.setDir(new PVector(-1,0));
  }else if(keyCode==RIGHT){
    testSnake.setDir(new PVector(1,0));
  }
}
