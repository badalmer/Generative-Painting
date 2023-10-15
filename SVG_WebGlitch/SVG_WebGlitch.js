// Brandon A. Dalmer 2023
// Web Glitch

const n = 256; // Reduce resolution for better performance
let grid = [];

function setup() {
  createCanvas(windowWidth, windowHeight);
  for (let x = 0; x < n; x++) {
    grid[x] = [];
  }
  initialize();
}

function initialize() {
  for (let x = 0; x < n; x++) {
    for (let y = 0; y < n; y++) {
      grid[x][y] = (x + y) % 2 ? 1 : 0;
    }
  }
}

function draw() {
  let next = [];
  for (let x = 0; x < n; x++) {
    next[x] = [];
    for (let y = 0; y < n; y++) {
      const r = noise(x / 99, y / 99, frameCount / 99);
      const sw = int(20 * r) % 5;
      let val;
      switch (sw) {
        case 0:
          val = grid[(x - 1 + n) % n][y]; // west
          break;
        case 1:
          val = grid[(x + 1) % n][y]; // east
          break;
        case 2:
          val = grid[x][(y - 1 + n) % n]; // north
          break;
        case 3:
          val = grid[x][(y + 1) % n]; // south
          break;
        case 4:
          val = grid[x][y]; // self
          break;
      }
      next[x][y] = val;
    }
  }
  grid = next;

  background(255);
  loadPixels();
  for (let x = 0; x < n; x++) {
    for (let y = 0; y < n; y++) {
      grid[x][y] && set(x * (width / n), y * (height / n), 0);
    }
  }
  updatePixels();
}

function mousePressed() {
  initialize();
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
