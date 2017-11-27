/*
Author:        Luke Demarest
Date:          2017.11
License:       GPLv3
Name:          recursive forest
Description:   
               grow a recursive forest
               with controlP5 interface

*/

float mouseMapX;
float mouseMapXMin;
float mouseMapXMax;
float mouseMapY;
float mouseMapYMin;
float mouseMapYMax;
float numKey;

void setup() {
    // initialize window settings
    size(500, 500);
    background(0);
    stroke(255);

    mouseMapXMin = 4.0;
    mouseMapXMax = 50.0;
    mouseMapX = 4.0;

    mouseMapYMin = height/2;
    mouseMapYMax = 25.0;    
    mouseMapY = 25.0;

    numKey = 3;
}

void draw() {
    // draw background every frame
    background(0);

    // update input values
    mouseMapX = map(mouseX, 0, width, mouseMapXMax, mouseMapXMin);
    mouseMapY = map(mouseY, 0, height, mouseMapYMin, mouseMapYMax);

    // recursive tree 'rooted' at bottom center
    pushMatrix();
    translate(width/2, height);
    branch(mouseMapY, mouseMapX, 0.5, numKey);
    popMatrix();
}

void branch(float branchLength, float branchLengthMin, float branchLengthDivision, float numOfBranches) {
    // current iteration's branch
    branchVisual(branchLength);

    // next iteration's branches (child)
    pushMatrix();

    // move to end of previous iteration's branch (parent)
    translate(0, -branchLength);

    // designate a proportion of the length of the current branch for the length of the next iteration's branch (child)
    branchLength *= branchLengthDivision;

    // execute next iteration 
    // draw branch (child) or 'leaf' (terminating child)
    if (branchLength >= branchLengthMin) {
        iterationManipulation(numKey);
        for (float i = 0; i < numOfBranches; i++) {
            pushMatrix();
            branchManipulation(branchLength, branchLengthMin, branchLengthDivision, numOfBranches, i);
            branch(branchLength, branchLengthMin, branchLengthDivision, numOfBranches);
            popMatrix();
        }
    } else {
        endVisual();
    }

    popMatrix();
}

void iterationManipulation(float numOfBranches) {
    //translate(0,-10);
}

void branchManipulation(float branchLength, float branchLengthMin, float branchLengthDivision, float numOfBranches, float thisBranch) {
    float rotValue = map(thisBranch + 0.5, 0, numOfBranches, PI/-2, PI/2);
    rotate(rotValue);
}

void branchVisual(float branchLength) {
    pushStyle();
    // style
    strokeWeight(branchLength/10);
    stroke(255, branchLength);
    // shape
    line(0, 0, 0, -branchLength);
    popStyle();
}

void endVisual() {
    pushStyle();
    // style
    stroke(255);
    // shape
    ellipse(0, 0, 4, 4);
    popStyle();
}