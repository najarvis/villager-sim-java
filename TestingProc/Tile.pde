static int OFFSET = Short.MAX_VALUE / 2;

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
    // Because the noise function mirrors along the x = 0 and y = 0 axis, we start in the middle of short.
    // This means it will repeat every 2^16 (65536) tiles. The reason I used Short versus Integer is
    // for some reason the noise function produces duplicate results when numbers get too high. For example,
    // noise (Integer.MAX_VALUE) had the same value as (Integer.MAX_VALUE - 20). This means the player would
    // see large areas of low detail.
    c = (int)(noise(((OFFSET + pos_x + x) % Short.MAX_VALUE) / 32.0, ((OFFSET + pos_y + y) % Short.MAX_VALUE) / 32.0) * 256);
    
  }
  
  void draw(){
    int r, g, b;
    int MAX_OFFSET = 64;
    // If statements for coloring
    if (c < 90){
      r = 70;
      g = 130;
      b = 180;
    }
    else if (c < 100){
      r = 238;
      g = 238;
      b = 209;
    }
    else if (c < 155){
      r = 0;
      g = 205;
      b = 102;
    }
    else if (c < 180){
      r = 100;
      g = 100;
      b = 100;
    }
    else {
      r = c;
      g = c;
      b = c;
    }
    
    // Add some smoothing to give variation between the same colors.
    r = (int)lerp(r - MAX_OFFSET, r + MAX_OFFSET, c / 256.0);
    g = (int)lerp(g - MAX_OFFSET, g + MAX_OFFSET, c / 256.0);
    b = (int)lerp(b - MAX_OFFSET, b + MAX_OFFSET, c / 256.0);
    fill(r + (int)((noise(pos_x, pos_y) - 0.5) * MAX_OFFSET / 2), g + (int)((noise(pos_x, pos_y) - 0.5) * MAX_OFFSET / 2), b + (int)((noise(pos_x, pos_y) - 0.5) * MAX_OFFSET / 2));
    //fill(r, g, b); // Uncomment for smooth values rather than the random overlay.
    
    // Very simple drawing the tile.
    quad(pos_x, pos_y, pos_x + size, pos_y, pos_x + size, pos_y + size, pos_x, pos_y + size);
  }
}