class Ball extends Obj {
  PVector direction;
  ArrayList<Event> goalInTop = new ArrayList<Event>();
  ArrayList<Event> goalInBottom = new ArrayList<Event>();

  Ball(PVector p, float sp, color c) {
    super(p, 50, sp, c);
    reset();
  }
  void reset(){
    pos = initPos.copy();
    direction = PVector.random2D();
  }
  void update() {
    move();
  }

  void move() {
    PVector dire = direction.normalize().mult(speed);
    float a = dire.y / dire.x;//y=[a]x+b
    float b = pos.y -a * pos.x;//y=ax+[b]
    //stroke(255);
    //line(0,b,width,a*width+b);//Show direction of movement
    float movePos=pos.x+dire.x-width/2;
    if(abs(movePos)>=width/2-size){
      float alpha = sign(direction.x);
      float wall = alpha*width/2-alpha*size;//reflection pos
      pos.x = width/2 + wall-(movePos-wall);
      pos.y += dire.y;
      direction.x *= -1;
    }else{
      pos.add(dire);
    }
    
    if (pos.y +size >= height) {
      for(Event e:goalInBottom)
        e.invoke();
      direction = new PVector();
    }
    if(pos.y - size <= 0){
      for(Event e:goalInTop)
        e.invoke();
      direction = new PVector();
    }
  }
  void collision(Obj obj) {
    PVector sub = pos.copy().sub(obj.pos);
    if (sub.magSq() < sq(obj.size+this.size)) {
      float atan=atan2(sub.y, sub.x);
      direction=new PVector(cos(atan), sin(atan));
    }
  }
}
