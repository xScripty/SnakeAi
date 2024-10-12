class Sensor{
  Snake snake;
  
  Sensor(Snake snake){
    this.snake= snake;
  }
  
  float[] getInputs(){
    float[] inputs=new float[6];
    
    inputs[0]=this.hasObstacle(new PVector(0,1));
    inputs[1]=this.hasObstacle(new PVector(0,-1));
    inputs[2]=this.hasObstacle(new PVector(1,0));
    inputs[3]=this.hasObstacle(new PVector(-1,0));
    inputs[4]=floor(this.snake.food.pos.x)==floor(this.snake.position.x)?0:
    (this.snake.food.pos.x>this.snake.position.x?1:-1);
    inputs[5]=floor(this.snake.food.pos.y)==floor(this.snake.position.y)?0:
    (this.snake.food.pos.y>this.snake.position.y?1:-1);
    
    return inputs;
  }
  float hasObstacle(PVector dir){
    PVector position=PVector.add(this.snake.position,
    PVector.mult(dir,scale));

    boolean tooWide=position.x<0||position.x>width;
    boolean tooHigh=position.y<0||position.y>height;
    boolean bodyHit=this.checkBodyHit(position);

    if (tooWide||tooHigh||bodyHit){
      return 1;
    }
    else{
      return 0;
    }
  }
  boolean checkBodyHit(PVector position){
    boolean hitBody=false;
    
    for(PVector part :this.snake.tail){
      if (dist(part.x,part.y,position.x,position.y)<1){
        hitBody=true;
      }
    }
    
    return hitBody;
  }
  
}
