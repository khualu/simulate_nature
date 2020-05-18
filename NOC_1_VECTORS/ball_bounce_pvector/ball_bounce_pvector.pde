Ball b;

void setup() {
 size (600,500);
 b = new Ball();
}

void draw() {
 b.move();
 b.bounce();
 b.display();
}
