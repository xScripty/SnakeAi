class Displayer{
  NeuralNetwork nn;
  float start,verticalOffset,verticalNeuronDiff
  ,neuronSize,horizontalNeuronDiff,maxWeightWidth;
  
  Displayer(NeuralNetwork nn){
    this.nn=nn;
    this.start=width*0.6;
    this.verticalOffset=35;
    this.verticalNeuronDiff=50;
    this.horizontalNeuronDiff=130;
    this.neuronSize=30;
    this.maxWeightWidth=7;
  }
  
  void display(){
    this.displayLayer(this.nn.inputNeurons,start);
    this.displayWeights(this.nn.inputWeights,start);
    this.displayLayer(this.nn.hiddenNeurons,this.start+horizontalNeuronDiff);
    this.displayWeights(this.nn.hiddenWeights,start+horizontalNeuronDiff);
    this.displayLayer(this.nn.outputNeurons,this.start+horizontalNeuronDiff*2);
  } 
  
  void displayLayer(Matrix layer,float x){
    float y;
    
    for (int i=0;i<layer.grid.length;i++){
      y=this.verticalOffset+i*this.verticalNeuronDiff;
      fill(0,255,0);
      ellipse(x,y,this.neuronSize,this.neuronSize);
    }
  }
  
  void displayWeights(Matrix weights,float firstLayerX){
    PVector startNode,endNode;
    stroke(255);
    
    for (int row=0;row<weights.rows;row++){
      for (int col=0;col<weights.cols;col++){        
        startNode=new PVector(firstLayerX,
          this.verticalOffset+col*this.verticalNeuronDiff);
          
        endNode=new PVector(firstLayerX+this.horizontalNeuronDiff,
        this.verticalOffset+row*this.verticalNeuronDiff);
        
        this.drawWeight(startNode,endNode,weights.grid[row][col]);
      }
    }
  }
  
  void drawWeight(PVector startNode,PVector endNode,float weight){
    color c=weight>0?color(255,0,0):color(0,0,255);
    float lineWidth=this.maxWeightWidth*weight;
    
    stroke(c);
    strokeWeight(Math.abs(lineWidth));
    
    line(startNode.x,startNode.y,endNode.x,endNode.y);
    noStroke();
    strokeWeight(1);
  }
  
}
