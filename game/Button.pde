class Button{
  PVector Pos=new PVector(0,0);
  float width=0;
  float height=0;
  color colour;
  String text;
  boolean pressed=false;
  boolean clicked=false;
  
  //Constructor para crear el boton
  Button(int x, int y, int w, int h, String t, int r, int g, int b){
    Pos.x=x;
    Pos.y=y;
    width=w;
    height=h;
    colour=color(r,g,b);
    text =t;
  }
  void update(){
    if(mousePressed == true && mouseButton== LEFT && pressed==false){
      pressed=true;
      if(mouseX>=Pos.x && mouseX <= Pos.x+width && mouseY >= Pos.y && mouseY <= Pos.y+height){
        clicked=true;
      }
    }else
    {
      clicked=false;
      pressed=false;
    }
    
    if(mousePressed != true){
      pressed=false;
    }
  }
  void render()
  {
    fill(colour);
    rect(Pos.x,Pos.y,width,height);
    
    fill(0);
    textAlign(CENTER,CENTER);
    text(text,Pos.x+(width/2),Pos.y+(height/2));
  }
  boolean isClicked() //Verifica que se haya dado click
  {
    return clicked;
  }
}
