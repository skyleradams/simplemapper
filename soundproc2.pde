import ddf.minim.*;
import ddf.minim.analysis.*;

//SIMPLEMAPPER
//A PROJECTION MAPPING PROGRAM
//using Minim beat detection: //http://matthewbrown.net.au/programming/minim-and-beat-detection/


 

  
final int IMAGE_X = 1125;
final int IMAGE_Y = 1193;
final int EDIT_RAD= 20;
final int RAND = 2;

AudioPlayer song;
AudioInput mic;
BeatDetect beat;
BeatListener bl;
Minim minim;
boolean editmode;
boolean drawneditpoints;
boolean dragging;
boolean image;
float kickSize, snareSize, hatSize;
ArrayList<maprect> quads;
ArrayList<point> points;

int rand1, rand2, rand3;
 
void setup()
{
  
size(1000, 800, P3D);
background(0);
smooth();
strokeJoin(ROUND);


//setup audio input stuff
minim = new Minim(this);
mic = minim.getLineIn(Minim.STEREO, 512);
//song = minim.loadFile("terminal.mp3", 1024);
//song.play();
// a beat detection object that is FREQ_ENERGY mode that
// expects buffers the length of song's buffer size
// and samples captured at songs's sample rate
beat = new BeatDetect(mic.bufferSize(), mic.sampleRate());
beat.setSensitivity(10);
kickSize = snareSize = hatSize = 5;
// make a new beat listener, so that we won't miss any buffers for the analysis
bl = new BeatListener(beat, mic);

//set up visual stuff
quads = new ArrayList<maprect>();
points = new ArrayList<point>();
//setup interface stuff
editmode = false;
drawneditpoints = false;
dragging = false;
image = false;

//manual input of rects for now, add some better edit features.
point[] pointsderp = new point[4];
point[] points2 = new point[4];
point[] points3 = new point[4];
pointsderp[0] = new point(0, 0);
pointsderp[1] = new point(500, 0);
pointsderp[2] = new point(500, 500);
pointsderp[3] = new point(0, 500);
points2[0] = new point(500,0);
points2[1] = new point(700,0);
points2[2] = new point(700,500);
points2[3] = new point(500,500);
points3[0] = new point(0, 500);
points3[1] = new point(500, 500);
points3[2] = new point(700, 500);
points3[3] = new point(500, 700);




  //add other stuff here
 maprect test = new maprect(pointsderp);
 maprect test2 = new maprect(points2);
 maprect test3 = new maprect(points3);
  quads.add(test);
 quads.add(test2);
 quads.add(test3);

}
 
void draw()
{



if ( beat.isKick() ) kickSize = 32;
if ( beat.isSnare() ) snareSize = 32;
if ( beat.isHat() ) hatSize = 200;

//go into edit or present mode
if(keyPressed){
  if (key == 'e') {
    editmode = true;
    if(!drawneditpoints) {background(0);}
    print("editmode:\n");
    image=false;
  }
  if (key == 'r') {
    editmode = false;
    drawneditpoints=false;
    background(0);
    print("displaymode\n");
    image=false;
  }
  if(key == 'i'){
    image = true;
    background(0);
  }
 }


if (editmode && !drawneditpoints){
  //drag around rectangles and create new rects
  //find vertexes, without any duplicates
  println("get here");
  for(maprect rect : quads){
    for(int j=0; j<4; j++){
       rect.getPoint(j).drawCircle(EDIT_RAD, 255);
       println("why?");
       //add points to their own array. duplicates don't matter because rectangles share corners.
       points.add(rect.getPoint(j));
       rect.drawOutline(2,255);
       }     
    }
    drawneditpoints = true;
}
else if(editmode && drawneditpoints){
  //let user drag around points and make new shapes.
  if(mousePressed){
    //check to see if any points under, mouse, and set them to draggable
    if(!dragging){
      for(point p : points){
        if(p.inCircle(EDIT_RAD, mouseX, mouseY)){
          p.setDragging(true);
          println("point at "+p.getX()+","+p.getY());
          dragging = true;
        }
      }
    }
    else{
      background(0);
      println("ever get here?");
      for (point p : points){
        if(p.beingDragged()){
          p.setCoords(mouseX,mouseY);
         
    }
     p.drawCircle(EDIT_RAD,255);
   } 
  }

}r
}
else if(!editmode){
  background(0);
  //pulse outline to the beat, color to snare.
  PImage img = loadImage("burningman.png");
  color x = color(240, hatSize, hatSize);
  for(maprect q : quads){

    if(image){
      float scale = 1.0f - ((float) kickSize * (0.75 / 32.0f));
      q.drawOutline((int)kirckSize, 255);
      q.scale(scale).drawImg(img);
    }
    else{
      q.drawOutline((int)kickSize, 255);
      q.drawColor(x);
       
    }
    
  }
  

  if( kickSize>4) kickSize-=3;
  if(hatSize>16) hatSize-=16;
  //testmode.drawcolor(y);
}



}

 
void stop()
{
// always close Minim audio classes when you are finished with them
//song.close();
mic.close();
// always stop Minim before exiting
minim.stop();
 
// this closes the sketch
super.stop();
}

void mouseReleased(){
 for(point p: points){
   p.setDragging(false);
   println("dragged");
 }
 dragging = false;
 //create wireframe again.
  for(maprect rect : quads){
       rect.drawOutline(2,255);
      
    }
}
