import processing.svg.*;

/*
Based on: http://isohedral.ca/escher-like-spiral-tilings/

*/

float tau = 6.28318530718;

void setup() {
  size(400,400);
  //noLoop();
  //beginRecord(SVG, "test.svg");
}

void draw() {
  //line(0,0, width/2, height);
  
  background(100);

  noFill();
  stroke(255, 102, 0);
  
  //bezier(
  //  0,0,
  //  0, height,
  //  width, height,
  //  width, 0);
  
  float vertStep = height / 128.0;
  
  //float x = 50;
  float x = mouseX;
  
  for (int i = 0; i < 127; i++) {
   line(
     x, (i+0) * vertStep,
     x, (i+1) * vertStep
   );
  }
  
  mapped_line(x, 0, x, height);
  
  stroke(0, 102, 255);
  
  for (int i = 0; i < 127; i++) {
    mapped_line(
      (i+0) * 100.0, 0.0,
      (i+1) * 100.0, height
    );
  }
  
    
  //endRecord();
  //println("Finished");
}

/*
Draw a line mapped from the XY plane to the complex plane

Todo: Java will not allow this to be pretty, but can we make these
functions compositional?
*/

public void mapped_line(float x0, float y0, float x1, float y1) {
  float x0Norm = x0 / width;
  float y0Norm = y0 / height;
  float x1Norm = x1 / width;
  float y1Norm = y1 / height;
  
  float stepX = (x1Norm - x0Norm) / 128.0;
  float stepY = (y1Norm - y0Norm) / 128.0;
  
  float halfWidth = 0.5 * width;
  float halfHeight = 0.5 * height;
  float scale = 0.1;
  
  for (int i = 0; i < 128; i++) {
    float x0i = x0Norm + stepX * (i+0);
    float y0i = y0Norm + stepY * (i+0) * tau;
    float x1i = x0Norm + stepX * (i+1);
    float y1i = y0Norm + stepY * (i+1) * tau;
    
   line(
     halfWidth + (map_re(x0i, y0i)) * (float)width * scale, halfHeight + (map_im(x0i, y0i)) * (float)height * scale,
     halfWidth + (map_re(x1i, y1i)) * (float)width * scale, halfHeight + (map_im(x1i, y1i)) * (float)height * scale
   );
  }  
}

/*
No value types
No operator overload
Poor support for static methods or pure functions

... Wow ...

Java is a mess.

So then below we find a poor man's map of XY plane to complex plane.

*/
public float map_re(float r, float i) {
 return exp(r) * cos(i);
}

public float map_im(float r, float i) {
 return exp(r) * sin(i);
}