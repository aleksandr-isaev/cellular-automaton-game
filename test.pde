human1[][] grid;
human1[][] next;

int cols;
int rows;
int resolution = 10;
boolean paused = false;
int terrain[][];

int redPop = 1;
int yellowPop = 1;
int purplePop = 1;
int greenPop = 1;

int redStr = 1;
int yellowStr = 1;
int purpleStr = 1;
int greenStr = 1;

int redRe = 0;
int yellowRe = 0;
int purpleRe = 0;
int greenRe = 0;

void setup() {
  size(1200, 800);
  cols = (width - 200) / resolution;
  rows = height / resolution;

  terrain = new int [cols][rows];
  grid = new human1[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new human1(0, 1, 0);
      grid[i][j].kill();
      terrain[50][j] = 1;
      //terrain[i][40] = 1;
    }
  }
    
  //terrain[49][40] = 0;
  terrain[50][39] = 0;
  terrain[50][40] = 0;
  terrain[50][41] = 0;
  //terrain[51][40] = 0;
  //water();
  
  grid[spawn()[0]][spawn()[1]] = new human1(1, (int)Math.ceil(random(5)), 0);
  grid[spawn()[0]][spawn()[1]] = new human1(2, (int)Math.ceil(random(5)), 0);
  grid[spawn()[0]][spawn()[1]] = new human1(3, (int)Math.ceil(random(5)), 0);
  grid[spawn()[0]][spawn()[1]] = new human1(4, (int)Math.ceil(random(5)), 0);

}

void draw() {
  background(0);
  fill(255);
  textSize(40);
  text("Purple", 1000, 30);
  textSize(25);
  text("Pop - " + purplePop, 1000, 55);
  if (purplePop == 0){
    text("Avg Str - 0", 1000, 80);  
    text("Avg Re - 0", 1000, 105);
  } else {
    text("Avg Str - " + purpleStr / purplePop, 1000, 80);    
    text("Avg Re - " + purpleRe / purplePop, 1000, 105);  
  }
  purplePop = 0;
  purpleStr = 0;
  purpleRe = 0;
  
  textSize(40);
  text("Red", 1000, 185);
  textSize(25);
  text("Pop - " + redPop, 1000, 210);
  if (redPop == 0){
    text("Avg Str - 0", 1000, 235);  
    text("Avg Re - 0", 1000, 260);  
  } else {
    text("Avg Str - " + redStr / redPop, 1000, 235);
    text("Avg Re - " + redRe / redPop, 1000, 260);
  }
  redPop = 0;
  redStr = 0;
  redRe = 0;
  
  textSize(40);
  text("Green", 1000, 340);
  textSize(25);
  text("Pop - " + greenPop, 1000, 365);
  if (greenPop == 0){
    text("Avg Str - 0", 1000, 390);  
    text("Avg Re - 0", 1000, 415);  
  } else {
    text("Avg Str - " + greenStr / greenPop, 1000, 390);
    text("Avg Re - " + greenRe / greenPop, 1000, 415);
  }
  greenPop = 0;
  greenStr = 0;
  greenRe = 0;
  
  textSize(40);
  text("Yellow", 1000, 495);
  textSize(25);
  text("Pop - " + yellowPop, 1000, 520);
  if (yellowPop == 0){
    text("Avg Str - 0", 1000, 545);  
    text("Avg Re - 0", 1000, 570);  
  } else {
    text("Avg Str - " + yellowStr / yellowPop, 1000, 545);
    text("Avg Re - " + yellowRe / yellowPop, 1000, 570);
  }
  yellowPop = 0;
  yellowStr = 0;
  yellowRe = 0;
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * resolution;
      int y = j * resolution;
      if (terrain[i][j] != 0){
        stroke(0);
        fill(0, 0, 255);
        rect(x, y, resolution - 1, resolution - 1);
      }
      
      if (grid[i][j].getAlive() == true) {
        switch(grid[i][j].getColour()) {
          case 1:
            stroke(0);
            fill(153, 51, 255);
            rect(x, y, resolution - 1, resolution - 1);
            break;
          case 2:
            stroke(0);
            fill(255, 0, 0);
            rect(x, y, resolution - 1, resolution - 1);
            break;
          case 3:
            stroke(0);
            fill(0, 255, 0);
            rect(x, y, resolution - 1, resolution - 1);
            break;
          case 4:
            stroke(0);
            fill(255, 255, 0);
            rect(x, y, resolution - 1, resolution - 1);
            break;
        }
      }
    }
  }

  next = new human1[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      next[i][j] = new human1(0, 1, 0);
      next[i][j].kill();
    }
  }

  // Compute next based on grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        if (grid[i][j].getAlive() == true) {
          //moving
          switch(grid[i][j].move()) {
            case 1:
              if (j - 1 >= 0){
                if(grid[i][j - 1].getAlive() == true && battle(grid[i][j], grid[i][j - 1]) == true && grid[i][j - 1].getColour() != grid[i][j].getColour()){
                  next[i][j - 1] = grid[i][j];
                  grid[i][j - 1].kill();
                } else if((grid[i][j - 1].getAlive() == false && terrain[i][j - 1] == 0) || (grid[i][j - 1].getAlive() == false && terrain[i][j - 1] == 1 && grid[i][j].canSwim())){
                  next[i][j - 1] = grid[i][j];
                }
              } else {
                next[i][j] = grid[i][j];
              }
              break;
            case 2:
              if (i + 1 <= cols - 1){
                if(grid[i + 1][j].getAlive() == true && battle(grid[i][j], grid[i + 1][j]) == true && grid[i + 1][j].getColour() != grid[i][j].getColour()){
                  next[i + 1][j] = grid[i][j];
                  grid[i + 1][j].kill();
                } else if((grid[i + 1][j].getAlive() == false && terrain[i + 1][j] == 0) || (grid[i + 1][j].getAlive() == false && terrain[i + 1][j] == 1 && grid[i][j].canSwim())){
                  next[i + 1][j] = grid[i][j];
                }
              } else {
                next[i][j] = grid[i][j];
              }
              break;
            case 3:
              if (j + 1 <= rows - 1){
                if(grid[i][j + 1].getAlive() == true && battle(grid[i][j], grid[i][j + 1]) == true && grid[i][j + 1].getColour() != grid[i][j].getColour()){
                  next[i][j + 1] = grid[i][j];
                  grid[i][j + 1].kill();
                } else if((grid[i][j + 1].getAlive() == false && terrain[i][j + 1] == 0) || (grid[i][j + 1].getAlive() == false && terrain[i][j + 1] == 1 && grid[i][j].canSwim())){
                  next[i][j + 1] = grid[i][j];
                }
              } else {
                next[i][j] = grid[i][j];
              }
              break;
            case 4:
              if (i - 1 >= 0){
                if(grid[i - 1][j].getAlive() == true && battle(grid[i][j], grid[i - 1][j]) == true && grid[i - 1][j].getColour() != grid[i][j].getColour()){
                  next[i - 1][j] = grid[i][j];
                  grid[i - 1][j].kill();
                } else if(grid[i - 1][j].getAlive() == false && terrain[i - 1][j] == 0 || (grid[i - 1][j].getAlive() == false && terrain[i - 1][j] == 1 && grid[i][j].canSwim())){
                  next[i - 1][j] = grid[i][j];
                }
              } else {
                next[i][j] = grid[i][j];
              }
              break;
            case 0:
              next[i][j] = grid[i][j];
              break;
          }
          
          //encirclement check
          if (circle(i, j)){
            next[i][j].kill();
          }
          
          //reproducing
          if (grid[i][j].reproduce()){
            switch(grid[i][j].giveBirthDir()) {
              case 1:
                 if (j - 1 >= 0 && grid[i][j - 1].getAlive() == false && terrain[i][j - 1] == 0){
                  next[i][j - 1].birth(grid[i][j].getColour(), grid[i][j].getStrength(), grid[i][j].getResearch());
                }
                break;
              case 2:
                if (i + 1 <= cols - 1 && grid[i + 1][j].getAlive() == false && terrain[i + 1][j] == 0){
                  next[i + 1][j].birth(grid[i][j].getColour(), grid[i][j].getStrength(), grid[i][j].getResearch());
                }
                break;
              case 3:
                if (j + 1 <= rows - 1 && grid[i][j + 1].getAlive() == false && terrain[i][j + 1] == 0){
                  next[i][j + 1].birth(grid[i][j].getColour(), grid[i][j].getStrength(), grid[i][j].getResearch());
                }
                break;
              case 4:
                if (i - 1 >= 0 && grid[i - 1][j].getAlive() == false && terrain[i - 1][j] == 0){
                  next[i - 1][j].birth(grid[i][j].getColour(), grid[i][j].getStrength(), grid[i][j].getResearch());
                }
                break;
            }
          }
          stats(next[i][j].getColour(), next[i][j].getStrength(), next[i][j].getResearch());
        }
    }
  }
  
  grid = next;
}

public void keyPressed() {

  if ( key == 'p' ) {

    paused = !paused;

    if (paused) {
      noLoop();
    } else {
      loop();
    }
  }
}

boolean battle(human1 attacker, human1 deffender){
  boolean result = false;
  if (attacker.getStrength() >= deffender.getStrength()){
    result = true;
  }
  
  return result; 
}

boolean circle(int ti, int tj){
  boolean circle = false;
  int count = 0;
  int defenderStr = grid[ti][tj].getStrength();
  int ttlAttackerStr = 0;
  
  if (tj - 1 >= 0){
    if (grid[ti][tj - 1].getColour() != grid[ti][tj].getColour() && grid[ti][tj - 1].getAlive() == true){
      count += 1;
      ttlAttackerStr += grid[ti][tj - 1].getStrength();
    }
  }
  if (tj + 1 <= rows - 1){
    if (grid[ti][tj + 1].getColour() != grid[ti][tj].getColour() && grid[ti][tj + 1].getAlive() == true){
      count += 1;
      ttlAttackerStr += grid[ti][tj + 1].getStrength();
    }
  }
  if (ti - 1 >= 0){
    if (grid[ti - 1][tj].getColour() != grid[ti][tj].getColour() && grid[ti - 1][tj].getAlive() == true){
      count += 1;
      ttlAttackerStr += grid[ti - 1][tj].getStrength();
    }
  }
  if (ti + 1 <= cols - 1){
    if (grid[ti + 1][tj].getColour() != grid[ti][tj].getColour() && grid[ti + 1][tj].getAlive() == true){
      count += 1;
      ttlAttackerStr += grid[ti + 1][tj].getStrength();
    }
  }
  
  //ttlAttackerStr >= defenderStr || 
  
  if (ttlAttackerStr >= defenderStr * 2 || count >= 2){
    circle = true;
  }
  
  return circle;
}

void stats(int tcolour, int str, int re){
    switch(tcolour) {
    case 1:
      purplePop += 1;
      purpleStr += str;
      purpleRe += re;
      break;
    case 2:
      redPop += 1;
      redStr += str;
      redRe += re;
      break;
    case 3:
      greenPop += 1;
      greenStr += str;
      greenRe += re;
      break;
    case 4:
      yellowPop += 1;
      yellowStr += str;
      yellowRe += re;
      break;
  }
}

void water(){
 int i = (int)Math.ceil(random(cols - 1));
 int j = (int)Math.ceil(random(rows - 1));
 int size = (int)Math.ceil(random(1000, 3000));
 int count = 0;
 
 terrain[i][j] = 1;
 
 while (count != size){
   int direction = (int)Math.ceil(random(4));
     switch(direction) {
      case 1:
         if (j - 1 >= 0){
          terrain[i][j - 1] = 1;
          j -= 1;
          count += 1;
        }
        break;
      case 2:
        if (i + 1 <= cols - 1){
          terrain[i + 1][j] = 1;
          i += 1;
          count += 1;
        }
        break;
      case 3:
        if (j + 1 <= rows - 1){
          terrain[i][j + 1] = 1;
          j += 1;
          count += 1;
        }
        break;
      case 4:
        if (i - 1 >= 0){
          terrain[i - 1][j] = 1;
          i -= 1;
          count += 1;
        }
        break;
    }
 }
 
}

int[] spawn(){
 int c[] = new int [2];
 boolean check = false;
 int ti;
 int tj;
 while (check == false){
   ti = (int)Math.ceil(random(cols - 1));
   tj = (int)Math.ceil(random(rows - 1));
   if (terrain[ti][tj] == 0){
    check = true; 
    c[0] = ti;
    c[1] = tj;
   }
 }
 
 return c; 
}
