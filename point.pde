class point {
  //keeps track of points that can be shared between rectangles.
  private float x;
  private float y;
  private boolean dragging;
  
  point(int xin, int yin){
    this.x = xin;
    this.y = yin;
  }
  
  float getX(){
    return this.x;
  }
  float getY(){
    return this.y;
  }
  
  void setCoords(float xin, float yin){
    this.x = xin;
    this.y = yin;
  }
  
  void drawCircle(int size, int shade){
    fill(shade);
    ellipse(this.x, this.y, size, size);
  }
  
  void setDragging(boolean what){
    this.dragging = what;
  }
  
  boolean beingDragged(){
    return this.dragging;
  }
  
  boolean inCircle(int circlediam, float mx, float my){
    float dist = dist(mx, my, this.x, this.y);
    if (dist<circlediam/2){
      return true;
    }
    else{
      return false;
    }
  }
}
