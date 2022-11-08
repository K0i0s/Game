/*Clase Player donde se pondra todo lo relacionado al jugador, incluyendo las mecanicas*/
class Player {
  PVector pos;
  PVector vel=new PVector(0, 0);
  PVector acc=new PVector(0, 0);
  PVector maxvel=new PVector(ball_size[levels]/2, ball_size[levels]/2);
  int p=0;
  int sd=1;
  //cambio de velocidad
  float mm=1;
  //gravedad
  float g=1;
  float hg=0;
  float bounce=0.5;
  float bounce_2=1.5;
  void prep() {
    maxvel=new PVector(ball_size[levels]/2, ball_size[levels]/2);
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        if (level[levels][i][j]==1) {
          pos=new PVector((width/level[levels][i].length)*j+(width/level[levels][i].length)/2, (height/level[levels].length)*i+(height/level[levels].length)/2);
          vel.x=0;
          vel.y=0;
          g=1;
          hg=0;
          return;
        }
      }
    }
  }
  //Movimiento
  void move() {
    if (keyPressed==false) {
      if (g!=0) {
        float save=vel.y;
        vel.set(vel.x*slide, save);
      } else {
        float save=vel.x;
        vel.set(save, vel.y*slide);
      }
    }
    PVector att=new PVector(pos.x, pos.y);
    int k=0;
    if ((d_d==1)&&(g!=0)) {
      att.add(mm, 0);
      att.sub(pos);
      k=1;
    }
    if ((a_a==1)&&(g!=0)) {
      att.add(-mm, 0);
      att.sub(pos);
      k=1;
    }
    if ((w_w==1)&&(hg!=0)) {
      att.add(0, -mm);
      att.sub(pos);
      k=1;
    }
    if ((s_sp==1)&&(hg!=0)) {
      att.add(0, mm);
      att.sub(pos);
      k=1;
    }
    if ((s_s==1)&&(sd==1)) {
      g*=-1;
      hg*=-1;
      sd=0;
    }
    if (k==0) {
      att.sub(pos);
    }
    if (g!=0) {
      acc.set(att.x, 0);
    } else {
      acc.set(0, att.y);
    }
    if (mode==0) {
      acc.add(hg, g);
    }
    acc.setMag(0.5);
    if (mode==1) {
      acc.add(hg, g);
    }
    vel.add(acc);
    if (vel.x>maxvel.x) {
      vel.x=maxvel.x;
    }
    if (vel.y>maxvel.y) {
      vel.y=maxvel.y;
    }
    if (vel.x<-maxvel.x) {
      vel.x=-maxvel.x;
    }
    if (vel.y<-maxvel.y) {
      vel.y=-maxvel.y;
    }
    vel.div(hitboxCheck);
    for (int lo=0; lo<hitboxCheck; lo++) {
      pos.add(vel);
      hitbox();
    }
    vel.mult(hitboxCheck);
    if (pos.x<0) {
      prep();
    }
    if (pos.x>width) {
      prep();
    }
    if (pos.y<0) {
      prep();
    }
    if (pos.y>height) {
      prep();
    }
    int gs=0;
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        if (level[levels][i][j]==5) {
          gs=1;
        }
      }
    }

    if (gs==0) {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==6) {
            level[levels][i][j]=3;
          }
        }
      }
    } else {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==3) {
            level[levels][i][j]=6;
          }
        }
      }
    }
    //-------------------------------
    gs=0;
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        if (level[levels][i][j]==15) {
          gs=1;
        }
      }
    }

    if (gs==0) {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==14) {
            level[levels][i][j]=-14;
          }
        }
      }
    } else {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==-14) {
            level[levels][i][j]=14;
          }
        }
      }
    }

    if (frameCount%60==0) {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if ((level[levels][i][j]==9)||(level[levels][i][j]==8)) {
            if (level[levels][i][j]==8) {
              level[levels][i][j]=9;
            } else {
              level[levels][i][j]=8;
            }
          }
        }
      }
    }
  }
  void hitbox() {
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        //block
        if ((level[levels][i][j]==2)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        //cambiar bloques
        if ((level[levels][i][j]==8)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        //muerte
        if ((level[levels][i][j]==4)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }

        //meta

        if ((level[levels][i][j]==3)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }

        //key
        if ((level[levels][i][j]==5)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }

        //bounce pad
        if ((level[levels][i][j]==7)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          vel.y=-maxvel.y;
          vel.y*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          vel.y=maxvel.y;
          vel.y*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          vel.x=-maxvel.x;
          vel.x*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          vel.x=maxvel.x;
          vel.x*=bounce_2;
        }

        //Cambio de gravedad

        //Hacia arriba
        if ((level[levels][i][j]==10)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
        }
        if ((level[levels][i][j]==10)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
        }
        if ((level[levels][i][j]==10)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
        }
        if ((level[levels][i][j]==10)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
        }
        //Hacia la derecha
        if ((level[levels][i][j]==11)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
        }
        if ((level[levels][i][j]==11)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
        }
        if ((level[levels][i][j]==11)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
        }
        if ((level[levels][i][j]==11)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
        }
        //Hacia abajo
        if ((level[levels][i][j]==12)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==12)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==12)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==12)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
        }
        //Hacia la izquierda
        if ((level[levels][i][j]==13)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
        }
        if ((level[levels][i][j]==13)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
        }
        if ((level[levels][i][j]==13)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
        }
        if ((level[levels][i][j]==13)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
        }
        //compuerta
        if ((level[levels][i][j]==14)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==14)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==14)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        if ((level[levels][i][j]==14)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        //Llave de la compuerta
        if ((level[levels][i][j]==15)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        //Parar
        if ((level[levels][i][j]==16)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          bounce/=10;
          vel.y*=-bounce;
          bounce*=10;
          vel.x*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          bounce/=10;
          vel.y*=-bounce;
          bounce*=10;
          vel.x*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          bounce/=10;
          vel.x*=-bounce;
          bounce*=10;
          vel.y*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          bounce/=10;
          vel.x*=-bounce;
          bounce*=10;
          vel.y*=bounce;
        }
      }
    }
  }

  void show() {
    fill(255, 255, 0);
    noStroke();
    ellipse(pos.x, pos.y, ball_size[levels], ball_size[levels]);
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        noFill();
        noStroke();
        //Bloque Regular
        if (level[levels][i][j]==2) {
          fill(45);
          stroke(45);
        } else if (level[levels][i][j]==3) { //Meta
          fill(0, 255, 0, 100);
          stroke(0, 255, 0, 100);
        } else if (level[levels][i][j]==4) { //Muerte
          fill(255, 0, 0);
          stroke(255, 0, 0);
        } else if (level[levels][i][j]==5) { //Llave
          fill(255, 255, 0, 100);
          stroke(255, 255, 0, 100);
        } else if (level[levels][i][j]==6) { //Puerta
          fill(0, 0, 255, 100);
          stroke(0, 0, 255, 100);
        } else if (level[levels][i][j]==7) { //
          fill(0, 255, 255, 100);
          stroke(0, 255, 255, 100);
        } else if (level[levels][i][j]==8) {
          fill(180, 100, 100);
          stroke(180, 100, 100);
        } else if (level[levels][i][j]==9) {
          fill(180, 100, 50, 100);
          stroke(180, 100, 50, 100);
        } else if (level[levels][i][j]==14) {
          fill(100, 25, 25);
          stroke(100, 25, 25);
        } else if (level[levels][i][j]==15) {
          fill(255, 225, 125);
          stroke(255, 225, 125);
        } else if (level[levels][i][j]==16) {
          fill(0);
          stroke(0);
        } else {
          noFill();
          noStroke();
        }
        rect((width/level[levels][i].length)*j, (height/level[levels].length)*i, (width/level[levels][i].length), (height/level[levels].length));
        if (level[levels][i][j]==10) {
          up((width/level[levels][i].length)*j, (height/level[levels].length)*i, (width/level[levels][i].length), (height/level[levels].length));
        }
        if (level[levels][i][j]==11) {
          right((width/level[levels][i].length)*j, (height/level[levels].length)*i, (width/level[levels][i].length), (height/level[levels].length));
        }
        if (level[levels][i][j]==12) {
          down((width/level[levels][i].length)*j, (height/level[levels].length)*i, (width/level[levels][i].length), (height/level[levels].length));
        }
        if (level[levels][i][j]==13) {
          left((width/level[levels][i].length)*j, (height/level[levels].length)*i, (width/level[levels][i].length), (height/level[levels].length));
        }
      }
    }
  }
}
