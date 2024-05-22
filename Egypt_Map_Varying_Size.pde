PImage mapImage;
Table locationTable;
int rowCount;
Table dataTable;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
String selectedState = "";
int value = 0;

void setup() {
  size(430, 410);
  mapImage = loadImage("C:\\Users\\lenovo\\OneDrive\\Desktop\\Project Visuallization\\Egypt-Map-Image.jpg");
  locationTable = new Table("Data.tsv");
  rowCount = locationTable.getRowCount();
  dataTable = new Table("random.tsv");

  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if (value > dataMax) {
      dataMax = value;
    }
    if (value < dataMin) {
      dataMin = value;
    }
  }
}
void draw() {
background(255);
image(mapImage, 0, 0);
smooth();
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

void drawData(float x, float y, String abbrev) {
  float value = dataTable.getFloat(abbrev, 1);
  float mapped = map(value, dataMin, dataMax, 2, 10);
  ellipse(x, y, mapped, mapped);
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
void mousePressed(){
//mousePressed() it's function so when mouse is pressed , it print the coordinates of mouse location
println("Mouse Clikcked At Coordinates:  (" + mouseX + "," + mouseY + ")");
}
