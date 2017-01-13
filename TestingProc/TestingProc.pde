final int SCREEN_SIZE = 512;
final int WORLD_SIZE = 128; // Adjust this for the 'zoom' level. 64 seems to run pretty smooth but you loose details
int OFFSET_X = 0;
int OFFSET_Y = 0;
int frame = 0; // frame counter
Tile[] tiles;
boolean[] keys = new boolean[256]; // Store positions (up / down) for each key.

void setup() {
  size(512, 512); // You can't use variables here.
  
  background(0);
  noStroke();
  
  // Uncomment for consistent noise values
  // noiseSeed(0);
  
  // Tiles are stored in a one dimensional array for speed purposes. This doesn't
  // work great for when we need to get 'near' tiles.
  tiles = new Tile[WORLD_SIZE * WORLD_SIZE];
  for (int y = 0; y < WORLD_SIZE; y++){
    for (int x = 0; x < WORLD_SIZE; x++){
      tiles[y * WORLD_SIZE + x] = new Tile(x, y, SCREEN_SIZE / WORLD_SIZE);
    }
  }
}

void update() {
  // Basic movement with WASD. We don't move any of the tiles, but merely the positions at which the tiles check for the noise value.
  if (keys[(int)'w']) OFFSET_Y-=8;
  if (keys[(int)'s']) OFFSET_Y+=8;
  if (keys[(int)'a']) OFFSET_X-=8;
  if (keys[(int)'d']) OFFSET_X+=8;
  for (Tile t : tiles){
    t.update(OFFSET_X, OFFSET_Y);
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
  for (Tile t : tiles){
    t.draw();
  }
}