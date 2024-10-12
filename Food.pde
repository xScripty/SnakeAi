class Food{
  PVector pos;
  float size;
  Food(){
    this.pickLocation();
    this.size=scale;
  }
  void pickLocation(){
    int row= floor(random(gridLength));
    int col=floor(random(gridLength));
    this.pos=new PVector(row*scale,col*scale);
  }
  void show(){
    fill(255,0,50);
    rect(this.pos.x,this.pos.y,this.size,this.size);
  }
}
