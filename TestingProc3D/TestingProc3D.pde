final int SCREEN_SIZE = 1024;
final static int WORLD_SIZE = 128; // Adjust this for the 'zoom' level. 64 seems to run pretty smooth but you loose details
final static int CENTER_X = WORLD_SIZE / 2;
float OFFSET_X = 0;
float OFFSET_Y = 0;
int frame = 0; // frame counter
Point[] points;
boolean[] keys = new boolean[256]; // Store positions (up / down) for each key.

double acc = 0.01;
double speed = acc;

void setup() {
  size(512, 512, P3D); // You can't use variables here.
  
  background(0);
  noStroke();
  frameRate(60);
  
  // Uncomment for consistent noise values
  // noiseSeed(0);
  
  // Tiles are stored in a one dimensional array for speed purposes. This doesn't
  // work great for when we need to get 'near' tiles.
  points = new Point[WORLD_SIZE * WORLD_SIZE];
  for (int y = 0; y < WORLD_SIZE; y++){
    for (int x = 0; x < WORLD_SIZE; x++){
      points[y * WORLD_SIZE + x] = new Point(x, y, SCREEN_SIZE / WORLD_SIZE);
    }
  }
}

void update() {
  // Basic movement with WASD. We don't move any of the tiles, but merely the positions at which the tiles check for the noise value.
  if (keys[(int)'w']) OFFSET_Y-=8;
  if (keys[(int)'s']) OFFSET_Y+=8;
  if (keys[(int)'a']) OFFSET_X-=8;
  if (keys[(int)'d']) OFFSET_X+=8;
  OFFSET_Y -= speed;
  speed += acc;
  for (Point p : points){
    p.update(OFFSET_X, OFFSET_Y);
  }
}

// These next two functions are simply to see if a key is currently being pressed while
// being able to have multiple down at once.
void keyPressed(){
  keys[key % 256] = true;
}

void keyReleased(){
  keys[key % 256] = false;
}

void draw() {
  // Draw automatically updates each frame so I just call update here.
  update();
  background(0); // Clear background
  pushMatrix(); // Since we are drawing only 1 object, this step isn't necessary to do every frame
  
  rotateX(PI / 2.2); // So we can see it
  rotateZ(PI / 4);
  translate(-350, -650, -325); // I just kept re-running the program until this looked nice.
  
  noFill();
  
  int i = 0;
  beginShape();
  for (Point p : points){
    
    //stroke(((float) p.z / AMPLITUDE) * 256);
    if (i % WORLD_SIZE == 0){ // Lines go from one side to the other, but do not connect to the other side.
      endShape();
      beginShape();
    }
    i++;
    p.draw();
  }
  endShape();
  
  popMatrix();
}