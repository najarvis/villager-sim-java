static int OFFSET = Short.MAX_VALUE / 2;
static int AMPLITUDE = 100;
static int WATER_LEVEL = AMPLITUDE / 4;

public class Point{
  
  int x, y;
  double z;
  int size;
  int r, g, b;
  
  public Point(int x, int y, int size){
    this.x = x * size;
    this.y = y * size;
    this.z = (noise(x / 10.0, y / 10.0) * 256);
    this.size = size;
  }
  
  public void update(float offset_x, float offset_y){
    z = ((noise(((OFFSET + x + offset_x) % Short.MAX_VALUE) / 32.0, ((OFFSET + y + offset_y) % Short.MAX_VALUE) / 32.0) * AMPLITUDE) +
        AMPLITUDE / 16) / 2;
    z = Math.max(z, WATER_LEVEL);
    
    if (z == WATER_LEVEL) {
      r = 92;
      g = 172;
      b = 238;
    } else if (z < WATER_LEVEL * 1.5){
      r = 0;
      g = 139;
      b = 69;
    } else if (z < AMPLITUDE * 0.8){
      r = (int) z;
      g = (int) z;
      b = (int) z;
    } else {
      r = 230;
      g = 230;
      b = 230;
    }
    r = lerpColor(r, 0, (float) dist_ratio());
    g = lerpColor(g, 0, (float) dist_ratio());
    b = lerpColor(b, 0, (float) dist_ratio());
  }
  
  public double dist_ratio(){
    return Math.sqrt(Math.pow(x / size - CENTER_X, 2) + Math.pow(y / size - CENTER_X, 2)) / (Math.sqrt(2) * CENTER_X / 2);
  }
  
  public void draw(){
    //translate(x, y, z);
    stroke(r, g, b);
    vertex(x, y, (float) z);
    
  }
  
}