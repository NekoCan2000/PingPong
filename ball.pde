class Ball extends Obj {
  PVector direction;
  Player[] players;
  ArrayList<Event> goalInTop = new ArrayList<Event>();
  ArrayList<Event> goalInBottom = new ArrayList<Event>();

  Ball(PVector p, float sp, color c, Player[] players) {
    super(p, 50, sp, c);
    reset();
    this.players = players;
  }
  void reset() {
    pos = initPos.copy();
    direction = new PVector(0,1);//PVector.random2D();
  }
  void update() {
    move();
  }

  void move() {
    boolean coll = false;
    PVector dire=null;
    do {
      coll= false;
      dire = direction.normalize().mult(speed);
      float a = dire.y / dire.x;//y=[a]x+b
      float b = pos.y -a * pos.x;//y=ax+[b]
      //stroke(255);
      //line(0,b,width,a*width+b);//Show direction of movement
      float movePos=pos.x+dire.x-width/2;

      if (abs(movePos)>=width/2-size) {
        coll = true;
        float alpha = sign(direction.x);
        float wall = alpha*width/2-alpha*size;//reflection pos
        pos.x = width/2 + wall-(movePos-wall);
        pos.y += dire.y;
        direction.x *= -1;
        
      } else if (collPlayers(dire)) {
        coll=true;
      }
      pos.add(direction);
    } while (coll);
    


    if (pos.y +size >= height) {
      for (Event e : goalInBottom)
        e.invoke();
      direction = new PVector();
    }
    if (pos.y - size <= 0) {
      for (Event e : goalInTop)
        e.invoke();
      direction = new PVector();
    }
  }
  boolean collPlayers(PVector dire) {
    PVector movePos = pos.copy().add(dire);
    for (Player obj : players) {
      PVector sub = movePos.copy().sub(obj.pos);
      float dist = sub.magSq();
      float coll = sq(obj.size+this.size);
      if (dist < coll) {
        float atan=atan2(sub.y, sub.x);
        direction=new PVector(cos(atan), sin(atan));
        return true;
      }
    }
    return false;
  }
}
