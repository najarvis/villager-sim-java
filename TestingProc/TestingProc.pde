final int WORLD_SIZE = 64;
int OFFSET_X = 0;
int OFFSET_Y = 0;
Tile[] tiles;
boolean[] keys = new boolean[256];

void setup() {
  size(512, 512);
  background(0);
  noStroke();
  noiseSeed(0);
  tiles = new Tile[WORLD_SIZE * WORLD_SIZE];
  for (int y = 0; y < WORLD_SIZE; y++){
    for (int x = 0; x < WORLD_SIZE; x++){
      tiles[y * WORLD_SIZE + x] = new Tile(x, y, 8);
    }
  }
}

void update() {
  if (keys[(int)'w']) OFFSET_Y-=5;
  if (keys[(int)'s']) OFFSET_Y+=5;
  if (keys[(int)'a']) OFFSET_X-=5;
  if (keys[(int)'d']) OFFSET_X+=5;
  for (Tile t : tiles){
    t.update(OFFSET_X, OFFSET_Y);
  }
}

void keyPressed(){
  keys[key] = true;
}

void keyReleased(){
  keys[key] = false;
}

void draw() {
  // ellipse(mouseX, mouseY, 80, 80);
  update();
  for (Tile t : tiles){
    t.draw();
  }
}