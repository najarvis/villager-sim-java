class Tile {
  
  int c;
  int pos_x, pos_y, size;
  
  Tile(int x, int y, int size) {
    c = (int)(noise(x / 10.0, y / 10.0) * 256);
    pos_x = x * size;
    pos_y = y * size;
    this.size = size;
  }
  
  void update(int x, int y){
    c = (int)(noise((pos_x + x) / 32.0, (pos_y + y) / 32.0) * 256);
  }
  
  void draw(){
    fill(c);
    quad(pos_x, pos_y, pos_x + size, pos_y, pos_x + size, pos_y + size, pos_x, pos_y + size);
  }
}