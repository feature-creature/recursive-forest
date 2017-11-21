float mouseMap;
void setup() {
    size(500, 500);
    stroke(255);

    mouseMap = 25;
}

void draw() {
    background(0);
    mouseMap = map(mouseY, 0, height, 500, 25);

    // tree begins at center bottom
    translate(width/2, height);
    branch(mouseMap);
}

void branch(float branchLength) {

    // current iteration's branch (parent)
    strokeWeight(branchLength/10);
    line(0, 0, 0, -branchLength);

    // next iteration's branches (child)
    pushMatrix();
    // move to end of previous iteration's branch (parent)
    translate(0, -branchLength);

    // half the branch length for the next iteration
    branchLength *= 0.5;

    // execute next iteration 
    // draw (child) branches or leaves (end child)
    if (branchLength >= 4) {

        // move both branches right
        rotate(PI*0.25);

        // right branch
        branch(branchLength);

        // move left branch all the way back
        rotate(-PI*0.5);
        // left branch
        branch(branchLength);
    } else {
        // end with a 'leaf'
        ellipse(0, 0, 4, 4);
    }
    popMatrix();
}