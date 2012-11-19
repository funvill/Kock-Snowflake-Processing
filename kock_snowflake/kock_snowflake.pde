/**
 * Witten by: Steven Smethurst 
 * Modifed from: http://forum.processing.org/topic/kock-snowflake-position-in-center
 * Last update: 18 Nov, 2012 
 */ 
 
int generations = 4;
int sideLen0 = 729;
int gen = 0;
int sideLen = sideLen0;
String initiator = "F--F--F";
String fRule1 = "F+F--F+F";
String fRule2 = "F-F++F-F";
float angle = PI/3;

void setup() 
{
  size(740, 850);
  background(255);
  stroke(0);
  strokeWeight(10);  // Thicker
  //noLoop();
}

void draw()
{
  // Move to starting position
  int startX = width/2 - (sideLen0/2);
  int startY = height/2 + int(sideLen0/3.5);
  translate(startX, startY); 
  pushMatrix();
  //outside flake
  String rules1 = generateState(initiator, gen, fRule1);
    // Map string to graphics  
  print(gen+".");
  for (int i = 0; i < rules1.length(); i++) {
    print(rules1.charAt(i));
    turtleGraphics(rules1.charAt(i));
  }
  println();
  //inside flake
  popMatrix();
  String rules2 = generateState(initiator, gen, fRule2);
    // Map string to graphics  
  print(gen+".");
  for (int i = 0; i < rules2.length(); i++) {
    print(rules2.charAt(i));
    turtleGraphics(rules2.charAt(i));
  }
  println();
  //next generation
  gen++;
  sideLen = sideLen/3;
  if (gen==generations) noLoop();
}//draw()


// Take the initiator and number of generations and compute final state
String generateState(String initial, int generations, String fRule) {
  String state = initial;
  for (int i = 0; i < generations; i++) {
    state = substitue(state, fRule);
  }
  return state;
}//generateState()


// Use the replacement rule to create new string
String substitue(String s, String fRule) 
{
  String newString = "";
  for (int i = 0; i < s.length(); i++) {
    // Replace each instance of F
    if (s.charAt(i) == 'F') {
      newString += fRule;
    } 
    else {
      newString += s.charAt(i);
    }
  }
  return newString;
}//substitue()


// Map the string to turtle graphics commands
void turtleGraphics(char c)
{
  switch(c) {
  case 'F':
    line(0, 0, sideLen, 0);
    translate(sideLen, 0);
    break;
  case '+':
    rotate(angle);
    break;
  case '-':
    rotate(-angle);
    break;
  }
}//turtleGraphics()
