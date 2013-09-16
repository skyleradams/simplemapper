import java.awt.geom.*;

class maprect {
  //basic rectangle class
  private point[] points = new point[4];
  
  maprect(point[] vertexes){
    this.points = vertexes;
  }
  
  point getPoint(int n){
    return this.points[n];
  }
  
  maprect scale(float s){
    int cx1 = (int) ((points[0].getX() + points[2].getX()) * .5f);
    int cy1 = (int) ((points[0].getY() + points[2].getY()) * .5f);
    int cx2 = (int) ((points[1].getX() + points[3].getX()) * .5f);
    int cy2 = (int) ((points[1].getY() + points[3].getY()) * .5f);
    
    Line2D diag1 = new Line2D.Float(points[0].getX(), points[0].getY(), points[2].getX(), points[2].getY());
    Line2D diag2 = new Line2D.Float(points[1].getX(), points[1].getY(), points[3].getX(), points[3].getY());
i 
    
    int n0x = (int) ((points[0].getX() - cx1) * s + cx1);
    int n0y = (int) ((points[0].getY() - cy1) * s + cy1);
    int n1x = (int) ((points[1].getX() - cx2) * s + cx2);
    int n1y = (int) ((points[1].getY() - cy2) * s + cy2);
    int n2x = (int) ((points[2].getX() - cx1) * s + cx1);
    int n2y = (int) ((points[2].getY() - cy1) * s + cy1);
    int n3x = (int) ((points[3].getX() - cx2) * s + cx2);
    int n3y = (int) ((points[3].getY() - cy2) * s + cy2);
    
    return new maprect(new point[]{new point(n0x,n0y), new point(n1x,n1y), new point(n2x,n2y), new point(n3x,n3y)});

  }
  
  void drawColor(color c){
    noStroke();
    fill(c);
    beginShape();
    vertex(points[0].getX(), points[0].getY());
    vertex(points[1].getX(), points[1].getY());
    vertex(points[2].getX(), points[2].getY());
    vertex(points[3].getX(), points[3].getY());
    endShape();
  }
  
  void drawOutline(int weight, int bright){
    stroke(bright);
    strokeWeight(weight);
    strokeCap(PROJECT);
    line(points[0].getX(), points[0].getY(), points[1].getX(), points[1].getY());
    line(points[1].getX(), points[1].getY(), points[2].getX(), points[2].getY());
    line(points[2].getX(), points[2].getY(), points[3].getX(), points[3].getY());
    line(points[3].getX(), points[3].getY(), points[0].getX(), points[0].getY());
    
  }
    
  void drawImg (PImage img){
    beginShape();
    texture(img);
    vertex(points[0].getX(), points[0].getY(), 0, 0);
    vertex(points[1].getX(), points[1].getY(), IMAGE_X, 0);
    vertex(points[2].getX(), points[2].getY(), IMAGE_X, IMAGE_Y);
    vertex(points[3].getX(), points[3].getY(),0, IMAGE_Y);
    endShape();
  }

}
