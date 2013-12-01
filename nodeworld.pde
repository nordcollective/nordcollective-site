int nNodes = 600;
PVector[] pos = new PVector[nNodes];
PVector[] vel = new PVector[nNodes];

void setup() {
  size(window.canvasWidth, window.canvasHeight, P2D);
  colorMode(RGB, 255);
  background(220, 220, 220);
  frameRate(30);
  strokeWeight(1);
  for (int i = 0; i < nNodes; i++) {
    pos[i] = new PVector();
    vel[i] = new PVector();
    pos[i].x = random(-width/4, width/4);
    pos[i].y = random(-width/4, width/4);
  }
}

void draw() {
  translate(width/2, height/2);
  background(250);
  for (int i = 0; i < nNodes; i++) {
    PVector cPos = pos[i];
    fill(0,0,0,40)
    stroke(0,0,0,0);
    ellipse(cPos.x, cPos.y, 3, 3);
    if (i == 0) continue;
    PVector pPos = pos[i - 1];
    stroke(0,0,0,40);
    line(pPos.x, pPos.y, cPos.x, cPos.y);
    
    // run simulation
    PVector force = cPos.get();
    force.sub(pPos);
      
    //force.setMag(force.mag() - noise(i) * width);
    float mag = max(force.mag(), 0.001);
    force.mult(1 - (noise(i) * width * 0.5) / mag);
      
    force.mult(0.05);
    force.mult(-0.5);
    vel[i].add(force);
    force.mult(-1);
    vel[i-1].add(force);
    
    vel[i].mult(0.97);
    vel[i].x += random(-0.1, 0.1);
    vel[i].y += random(-0.1, 0.1);
    
    if (cPos.mag() > width*0.3) {
        PVector toCenter = cPos.get();
        toCenter.mult(-0.01);
        vel[i].add(toCenter);
    }
      
    cPos.add(vel[i]);
  };
}

