/*
Author:        Luke Demarest
 Date:          2017.11
 License:       GPLv3
 Name:          recursive forest
 Description:   
 grow a recursive forest
 with controlP5 interface
 
 */

// import library and declare obj
import controlP5.*;
ControlP5 cp5;

// declare global variables
int controlHeight;
int subControlWidth;
int locationXSliderValue;
float sliderMapValue;
int branchNumSliderValue;
int branchNum;
float branchLengthDivisionSliderValue;
int branchLengthSliderValue;
float branchLengthMinSliderValue;

void setup() {
    // initialize window settings
    size(800, 450);
    background(0);
    stroke(255);

    
    controlHeight = 30;
    subControlWidth = width/3;
    
    cp5 = new ControlP5(this);
    
    // position x of current tree
    cp5.addSlider("locationXSliderValue")
        .setPosition(0, height - controlHeight/2)
        .setSize(width, 15)
        .setRange(0, 100)
        .setValue(50)
        .setLabel("");

    locationXSliderValue = 50;
    sliderMapValue = width/2;
    
    // number of top-level branches
    cp5.addSlider("branchNumSliderValue")
        .setPosition(0, height - controlHeight)
        .setSize(subControlWidth, 15)
        .setRange(0, 9)
        .setValue(1)
        .setLabel("");;
    branchNumSliderValue = 1;
    branchNum = 1;

    // branch length division factor
    cp5.addSlider("branchLengthDivisionSliderValue")
        .setPosition(subControlWidth, height - controlHeight)
        .setSize(subControlWidth, 15)
        .setRange(0, 1)
        .setValue(0.3)
        .setLabel("");;
    branchLengthDivisionSliderValue = 0.3;

    // minimum length for a branch
    cp5.addSlider("branchLengthMinSliderValue")
        .setPosition(2*subControlWidth, height - controlHeight)
        .setSize(subControlWidth, 15)
        .setRange(50, 4.0)
        .setValue(25.0)
        .setLabel("");;

    branchLengthMinSliderValue = 25.0;

    // trunk length
    cp5.addSlider("branchLengthSliderValue")
        .setPosition(0, 0)
        .setSize(15, height - controlHeight)
        .setRange(25.0, height/2 - controlHeight)
        .setValue(85)
        .setLabel("");;

    branchLengthSliderValue = 85;
}

void draw() {
    // draw background every frame
    background(0);

    sliderMapValue = map(locationXSliderValue, 0, 100, 0, width);
    branchNum = branchNumSliderValue;

    // recursive tree 'rooted' at bottom center
    pushMatrix();
    translate(sliderMapValue, height - controlHeight);
    branch(branchLengthSliderValue, branchLengthMinSliderValue, branchLengthDivisionSliderValue, branchNum);
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
        iterationManipulation(numOfBranches);
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