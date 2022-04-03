abstract class Obj{
  color col;
  float size;
  PVector pos,initPos;
  float speed;
  Obj(PVector p,float s,float sp, color c){
    initPos = p;
    size = s;
    speed = sp;
    col = c;
    reset();
  }
  void draw(){
    noStroke();
    fill(col);
    ellipse(pos.x,pos.y,size*2,size*2);
  }
  void reset(){
    pos = initPos.copy();
  }
}

