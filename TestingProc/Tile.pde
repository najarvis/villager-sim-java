class Tile {
  
  int c;
  int pos_x, pos_y, size;
  
  Tile(int x, int y, int size) {
    c = (int)random(255);
    pos_x = x * size;
    pos_y = y * size;
    this.size = size;
  }
  
  void update(){
    c = (int)random(255);
  }
  
  void draw(){
    fill(c);
    quad(pos_x, pos_y, pos_x + size, pos_y, pos_x + size, pos_y + size, pos_x, pos_y + size);
  }
}