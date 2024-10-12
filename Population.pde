class Population{
  Snake[] snakes;

  Population(int size){
    this.snakes=new Snake[size];
    
    for (int i=0;i<size;i++){
      this.snakes[i]=new Snake();
    }
  }
  
  void update(){
    for (Snake snake:snakes){
      snake.update();
    }
    checkExtinction();
  }
  
  void makeNextGeneration(){
    Snake[] nextGen=new Snake[this.snakes.length];
    Snake nextSnake;
    
    Snake bestSnake;
    bestSnake=new Snake();
    bestSnake.brain=this.findBestSnake().brain.copyNetwork();
    nextGen[0]=bestSnake;
    
    for(int i=1;i<nextGen.length;i++){
      nextSnake=new Snake();
      nextSnake.brain=this.pickSnake().brain.copyNetwork();
      //nextSnake.brain.mutate(0.75,0.05);
      nextSnake.brain.mutate(0.02,0.9);
      
      nextGen[i]=nextSnake;
    }
    
    this.snakes=nextGen;
    this.update();
  }
  
  void checkExtinction(){
    boolean allDead=true;
    
    for(Snake snake :snakes){
      if (snake.dead==false){
        allDead=false;
      }
    }
    
    if(allDead){
      this.makeNextGeneration();
    }
  }
  
  Snake pickSnake(){
    boolean foundSnake=false;
    int snakeIndex=0;
    float counter=1,fitnessSum=this.getFitnessSum();
    
    while(!foundSnake){
      snakeIndex=floor(random(this.snakes.length));
      
      counter-=this.snakes[snakeIndex].fitness/fitnessSum;
      if(counter<0){
        foundSnake=true;
      }
    }
    return this.snakes[snakeIndex];
  }
  
  Snake findBestSnake(){
    Snake bestSnake=this.snakes[0];
    
    for(Snake snake:this.snakes){
      if(snake.fitness>bestSnake.fitness){
        bestSnake=snake;
      }
    }
    
    return bestSnake;
  }
  
  float getFitnessSum(){
    float sum=0;
    
    for(Snake snake :this.snakes){
      sum+=snake.fitness;
    }
    
    return sum;
  }
  
  void showAll(){
    for(Snake snake:this.snakes){
      snake.show();
    }
  }
  void showBest(){
    boolean aliveSnakeFound=false;
    int i=0;
    
    
    while(!aliveSnakeFound){
      if(snakes[i].dead==false){    
        snakes[i].show();
        snakes[i].brain.displayer.display();
        aliveSnakeFound=true;
      }
      
      i++;
    }
    
  }
}
