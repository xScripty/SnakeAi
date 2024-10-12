class Matrix{
  int rows,cols;
  float[][] grid;
  
  Matrix(int rows,int cols){
    this.rows=rows;
    this.cols=cols;
    this.grid=new float[this.rows][this.cols];
  }
  
  Matrix(float[] inputs){
    this.rows=inputs.length;
    this.cols=1;
    this.grid=new float[this.rows][this.cols];
    this.fromArray(inputs);
  }
  
  Matrix multiplyMatrices(Matrix otherMatrix){
    Matrix resultMatrix=new Matrix(this.rows,otherMatrix.cols);
    float rowSum;
    
    for (int row=0;row<this.rows;row++){
      rowSum=0;
      for (int col=0;col<this.cols;col++){
        rowSum+=this.grid[row][col]*otherMatrix.grid[col][0];
      }
      resultMatrix.grid[row][0]=rowSum;
    }  
     
    return resultMatrix;
  }
 
  void randomize(){
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        this.grid[row][col]=0;
        //this.grid[row][col]=0;
      }
    }  
  }

  void addValue(float value){
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        this.grid[row][col]+=value;
      }
    }
  }  
  void addMatrix(Matrix matrix){
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        this.grid[row][col]+=matrix.grid[row][col];
      }
    }
  }
  
  void activateMatrix(){
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        this.grid[row][col]=this.sigmoid(this.grid[row][col]);
      }
    }
  }
  float sigmoid(float num){
    return (float)(1 / (1 + Math.exp(-num)));
  }
  
  void fromArray(float[] inputs){
    for(int i=0;i<this.rows;i++){
      this.grid[i][0]=inputs[i];
    }
  }
 
  float[] toArray(){
    float[] outputs=new float[this.rows];
    for(int i=0;i<this.rows;i++){
      outputs[i]=this.grid[i][0];
    }
    return outputs;
  }
  
  void display(){
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        print(this.grid[row][col]);
        print("   ");
      }
      print("\n");
    }
    print("----------------------------------------\n");
  }
  
  void mutate(float mutationChance,float maxMutation){
    float mutation,mutationCap;
    
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        mutationCap=random(0,1);
        
        if (mutationCap<mutationChance){
          mutation=random(-maxMutation,maxMutation);
          this.grid[row][col]+=mutation;
          this.grid[row][col]=constrain(this.grid[row][col],-1,1);
        }
      }
    }
  }  
  
  Matrix copyMatrix(){
    Matrix copied= new Matrix(this.rows,this.cols);
    
    for (int row=0;row<this.rows;row++){
      for (int col=0;col<this.cols;col++){
        copied.grid[row][col]=this.grid[row][col];
      }
    }
    return copied;
  }        
}
