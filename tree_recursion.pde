float mouseMapX;
float mouseMapXMin;
float mouseMapXMax;
float mouseMapY;
float mouseMapYMin;
float mouseMapYMax;

void setup() {
    size(500, 500);
    stroke(255);
    
    mouseMapXMin = 4.0;
    mouseMapXMax = 50.0;
    mouseMapX = 4.0;
    
    mouseMapYMin = height/2;
    mouseMapYMax = 25.0;    
    mouseMapY = 25.0;
    
}

void draw() {
    background(0);
    
    // input updates
    mouseMapX = map(mouseX, 0, width, mouseMapXMax, mouseMapXMin);
    mouseMapY = map(mouseY, 0, height, mouseMapYMin, mouseMapYMax);

    // tree begins at bottom center
    pushMatrix();
    translate(width/2, height);
    branch(mouseMapY, mouseMapX, 0.5);
    popMatrix();
}

void branch(float branchLength, float branchLengthMin, float branchLengthDivision) {

    // current iteration's branch (parent)
    strokeWeight(branchLength/10);
    line(0, 0, 0, -branchLength);

    // next iteration's branches (child)
    pushMatrix();
    // move to end of previous iteration's branch (parent)
    translate(0, -branchLength);

    // half the branch length for the next iteration
    branchLength *= branchLengthDivision;

    // execute next iteration 
    // draw (child) branches or leaves (end child)
    if (branchLength >= branchLengthMin) {

        // right branch
        pushMatrix();
        rotate(PI*0.25);
        branch(branchLength, branchLengthMin, branchLengthDivision);
        popMatrix();

        // left branch
        pushMatrix();
        rotate(-PI*0.25);
        branch(branchLength, branchLengthMin, branchLengthDivision);
        popMatrix();

    } else {
        // end with a 'leaf'
        ellipse(0, 0, 4, 4);
    }
    popMatrix();
}