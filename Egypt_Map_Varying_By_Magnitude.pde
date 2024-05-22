PImage mapImage;
Table locationTable;
int rowCount;
Table dataTable;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
String selectedState = "";
int value = 0;
void setup( ) {
size(430, 410);
mapImage = loadImage("C:\\Users\\lenovo\\OneDrive\\Desktop\\Project Visuallization\\Egypt-Map-Image.jpg");
locationTable = new Table("Data.tsv");
rowCount = locationTable.getRowCount( );
// Read the data table.
dataTable = new Table("random.tsv");
// Find the minimum and maximum values.
for (int row = 0; row < rowCount; row++) {
float value = dataTable.getFloat(row, 0);
if (value > dataMax) {
dataMax = value;
}
if (value < dataMin) {
dataMin = value;
}
}
}
void draw( ) {
background(255);
image(mapImage, 0, 0);
smooth( );
fill(192, 0, 0);
noStroke( );
for (int row = 0; row < rowCount; row++) {
String abbrev = dataTable.getRowName(row);
float x = locationTable.getFloat(abbrev, 1);
float y = locationTable.getFloat(abbrev, 2);
drawData(x, y, abbrev);
}
textAlign(TOP, RIGHT);
text(selectedState, mouseX, mouseY);
}
// Map the size of the ellipse to the data value
// Map the size of the ellipse to the data value
void drawData(float x, float y, String abbrev) {
  float value = dataTable.getFloat(abbrev, 1);
  float diameter = 0;
  if (value >= 2.0) {
    diameter = map(value, 0, dataMax, 10, 30);
    fill(#333366); // blue
  } else {
    diameter = map(value, 0, dataMin, 10, 30);
    fill(#EC5166); // red
  }
  ellipse(x, y, diameter, diameter);
  
  // Display population value when mouse is near the ellipse
  if (dist(mouseX, mouseY, x, y) < diameter / 2) {
    fill(0);
    textSize(12);
    text(nf(value, 0, 2), x, y - diameter / 2 - 5);
  }
}
void mousePressed(){
//mousePressed() it's function so when mouse is pressed , it print the coordinates of mouse location
println("Mouse Clikcked At Coordinates:  (" + mouseX + "," + mouseY + ")");
}
void mouseMoved() {
  for (int row = 0; row < rowCount; row++) {
    String abbrev = dataTable.getRowName(row);
    float x = locationTable.getFloat(abbrev, 1);
    float y = locationTable.getFloat(abbrev, 2);
    float distance = dist(mouseX, mouseY, x, y);

    if (distance < 15) {
      selectedState = abbrev;
      break;
    } else {
      selectedState = "";
    }
  }
  //mouseMoved() it's function so when mouse is moved , it print the value of mouse location
value = value + 5;
  if (value > 255) {
    value = 0;
  }
println("Mouse Moved At : " + value);
}
