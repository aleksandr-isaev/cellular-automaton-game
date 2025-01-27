class human1 {
  int country;
  int strength;
  int colour;
  int research;
  boolean alive;
  
  human1(int tcolour, int tstrength, int tresearch){
    colour = tcolour;
    strength = tstrength;
    research = tresearch;
    alive = true;
  }
  
  boolean getAlive(){
    return alive;
  }
  
  int getColour(){
    return colour;
  }
  
  int getStrength(){
    //print(strength);
    return strength;
  }
  
  int getResearch(){
   return research; 
  }
  
  void kill(){
    alive = false;
  }
  
  void birth(int tcolour, int tstrength, int tresearch){
    alive = true;
    colour = tcolour;
    strength = mutate(tstrength);
    research = mutate(tresearch);
  }
  
  boolean canSwim(){
   if (research > 10){
     return true;
   } else {
    return false; 
   }
  }
  
  int move(){
    int direction = 0;
    float moveCheck = random(1);
    if (moveCheck > 0.8){
        direction = (int)Math.ceil(random(4));
    }
    return direction;
  }
  
  int giveBirthDir(){
    int direction = 0;
    direction = (int)Math.ceil(random(4));
    return direction;
  }
  
  boolean reproduce(){
    boolean check = false;
    double chance = random(1);
    
    if (chance >= 0.2){
     check = true;
    }
    
    return check;
  }
  
  int mutate(int trait){
    double chance = random(1);
    if (chance >= 0.99){
     trait += 1;
     //print(trait + " ");
    } else if(chance >= 0.98 && chance < 0.99){
      trait -= 1;
    }
    
    return trait;
  }
  
}
