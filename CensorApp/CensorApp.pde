import controlP5.*;

ControlP5 jControl;

PImage img;
int range = 100;
int pixel = 10;
boolean ctrlPressed;

void setup() {
 size(800, 850);
 
 //initialize image
 img = loadImage("default.png");
 
 //initialize control
 jControl = new ControlP5(this);
 
 //value, min, max, -, x, y, width, height
 Slider rangeSlider = jControl.addSlider("range", 0, 255, 100, 10, 10, 150, 30);
 Slider pixelSlider = jControl.addSlider("pixel", 0, 50, 100, 250, 10, 150, 30);
 
 //name, value (float), x, y, width, height
 jControl.addButton("open")
     .setPosition(650,10)
     .setSize(100,30);
}

public void open() {
  selectInput("Select where your image will be saved :", "openFile");
}

void openFile(File selection){
  if(selection == null){
    return;
  }
  else{
    String myFile = selection.getPath();
    System.out.print("\"" + myFile + "\"");
    img  = loadImage(myFile);
    return;
  }
}

void draw() {
 background(0);
 
 //img
 image(img, 0, 50);
 img.resize(800, 800);
 
 // call pixelating function
 pixelateImage(pixel);
}

void pixelateImage(int pixel_size){
   //disable shape stroke
   noStroke();
  
  for(int y=mouseY-range; y<mouseY+range; y+=pixel_size){
    for(int x=mouseX-range; x<mouseX+range; x+=pixel_size){
      //get pixel color at location
      color pixel_color = img.get(x, y - 50);
      
      // set shape fill color
      fill(pixel_color);
      
      //draw shape
      rect(x, y, pixel_size, pixel_size);
    }
  }
}

void keyPressed() {
  // special key
  if (key == CODED) {
    if (keyCode == CONTROL) {
      ctrlPressed = true;
    }
  }
  // regular key
  else {
    if (ctrlPressed && keyCode == 83) {
      selectFolder("Select where your image will be saved :", "folderSelected");
    }
    else {
      // do another thing
    }
  }
}

void folderSelected(File selection){
  if(selection == null){
    return;
  }
  else{
    String myDir = selection.getPath() + "\\";
    PImage saveImg  = get(0, 50, 800, 800);
    saveImg.save(myDir + "screenshot.png");
  }
}
