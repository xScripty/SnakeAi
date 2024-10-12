class NeuralNetwork{
  Matrix inputWeights,hiddenWeights;
  Matrix inputNeurons,hiddenNeurons,outputNeurons;
  Matrix inputBias,hiddenBias;
  
  int inputNodes,hiddenNodes,outputNodes;
  Displayer displayer;
  
  NeuralNetwork(int inputNodes,int hiddenNodes,int outputNodes){    
    this.inputNodes=inputNodes;
    this.hiddenNodes=hiddenNodes;
    this.outputNodes=outputNodes;
    
    this.inputWeights=new Matrix(hiddenNodes,inputNodes);
    this.hiddenWeights=new Matrix(outputNodes,hiddenNodes);
    
    this.inputBias=new Matrix(hiddenNodes,1);
    this.hiddenBias=new Matrix(outputNodes,1);
    
    this.inputWeights.randomize();
    this.hiddenWeights.randomize();
    this.inputBias.randomize();
    this.hiddenBias.randomize();
    
    this.displayer=new Displayer(this);
  }
  
  int feedForward(float[] inputsArray){
    this.inputNeurons=new Matrix(inputsArray);
    
    this.hiddenNeurons=this.inputWeights.multiplyMatrices(inputNeurons);
    this.hiddenNeurons.addMatrix(this.inputBias);
    this.hiddenNeurons.activateMatrix();
    
    this.outputNeurons=this.hiddenWeights.multiplyMatrices(this.hiddenNeurons);
    this.outputNeurons.addMatrix(this.hiddenBias);
    this.outputNeurons.activateMatrix();
    
    return this.getBiggestOutput();    
  }
  
  int getBiggestOutput(){
    float[] outputArr=this.outputNeurons.toArray();
    int biggest=0;
    for(int i=1;i<outputArr.length;i++){
      if(outputArr[biggest]<outputArr[i]){
        biggest=i;
      }
    }
    return biggest;
  }
  
  void mutate(float mutationChance,float maxMutation){
    this.inputWeights.mutate(mutationChance,maxMutation);
    this.hiddenWeights.mutate(mutationChance,maxMutation);
    
    this.inputBias.mutate(mutationChance,maxMutation);
    this.hiddenBias.mutate(mutationChance,maxMutation);
  }
  
  NeuralNetwork copyNetwork(){
    NeuralNetwork copied=new NeuralNetwork(this.inputNodes,this.hiddenNodes,
    this.outputNodes);
    
    copied.inputWeights=this.inputWeights.copyMatrix();
    copied.hiddenWeights=this.hiddenWeights.copyMatrix();
    
    copied.inputBias=this.inputBias.copyMatrix();
    copied.hiddenBias=this.hiddenBias.copyMatrix();
    return copied;
  }
  
  void logData(){
    println("inputWeights");
    this.inputWeights.display();
    
    println("inputBias");
    this.inputBias.display();
    
    println("hiddenResults");
    this.hiddenNeurons.display();
    
    println("hiddenWeights");
    this.hiddenWeights.display();
    
    println("hiddenBias");
    this.hiddenBias.display();
    
    println("outputResults");
    this.outputNeurons.display();
  }
}
