final int WORLD_SIZE = 256;
Tile[] tiles;

void setup() {
  size(512, 512);
  background(0);
  noStroke();
  tiles = new Tile[WORLD_SIZE * WORLD_SIZE];
  for (int y = 0; y < WORLD_SIZE; y++){
    for (int x = 0; x < WORLD_SIZE; x++){
      tiles[y * WORLD_SIZE + x] = new Tile(x, y, 2);
    }
  }
}

void update() {
  for (Tile t : tiles){
    t.update();  
  }
}

void draw() {
  // ellipse(mouseX, mouseY, 80, 80);
  update();
  for (Tile t : tiles){
    t.draw();
  }
}