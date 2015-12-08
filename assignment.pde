Button[] menuButtons;
Country[] cButton;
boolean drawBoxes;
boolean drawBox;
Table alldata;
String[] countries;
PImage img;
final int menu=0;
final int seeChart=1;
final int seeMap=2;
int state=menu;
int[] x = {
  175, 365, 265, 215, 220, 370, 65, 330, 115, 165, 275, 230, 360, 335, 355, 190, 315, 265, 185, 265, 315, 60, 365, 270, 310, 365, 265, 115, 215, 305, 330, 315, 320, 440
};
int[] y= {
  435, 525, 440, 360, 425, 325, 400, 555, 550, 475, 500, 500, 595, 350, 375, 445, 475, 595, 420, 470, 420, 550, 490, 488, 455, 275, 325, 400, 300, 525, 535, 540, 510, 560
};
float[] y1;
float[] y2;
float x1;
float x2;
float scale;


void setup()
{
  size(700, 700);
  background(0);
  smooth(0);
  countries = loadStrings("countries.txt");
  alldata = loadTable("allenergy.tsv");
  img = loadImage("europe.png");
  textAlign(LEFT);
  menuButtons = new Button[3];
  menuButtons[0] = new Button("show graph", new PVector((width/2)-55, 250), 20, color(255), color(255, 0, 0));
  menuButtons[1] = new Button("show map", new PVector((width/2)-50, 350), 20, color(255), color(255, 0, 0));
  menuButtons[2] = new Button("MENU", new PVector(10, 10), 32, color(255, 0, 0), color(255));
  drawBoxes = false;

  cButton = new Country[countries.length];
  int y=50;
  for (int i=0; i<alldata.getRowCount (); i++)
  {
    for (int j=1; j<alldata.getColumnCount (); j++)
    {
      cButton[i]= new Country(alldata.getFloat(i, j), countries[i], new PVector(550, y), 16, color(255), color(255, 0, 0));
    }
    y+=18;
  }
  drawBox=false;

  y1 = new float[countries.length];
  y2 = new float[countries.length];
  showMenu();
}

void draw()
{
  switch(state)
  {
  case menu:
    showMenu();
    break;
  case seeChart:
    menuButtons[2].draw(drawBoxes);
    textAlign(LEFT);
    for (int i = 0; i < cButton.length; i++) {
      cButton[i].draw(drawBox);
    }
    drawChart();
    break;
  case seeMap:
    menuButtons[2].draw(drawBoxes);
    textAlign(LEFT);
    for (int i = 0; i < cButton.length; i++) {
      cButton[i].draw(drawBox);
    }
    break;
  default:
    println("unknown state");
    exit();
    break;
  }
}

void showMenu()
{
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(24);
  text("Consumption of renewable energy in Europe\n2004-2013", width/2, 100);
  for (int i=0; i<menuButtons.length; i++)
  {
    menuButtons[i].draw(drawBoxes);
  }
}

float drawChart()
{
  stroke(255);
  float border = width*0.1f;
  float windowRange = width - (border*3.5f);
  float hInt = windowRange/alldata.getColumnCount()-1;
  float tick = border*0.1f;

  line(border, height-border, border+hInt*(alldata.getColumnCount()-1), height-border);
  line(border, border, border, height-border);

  //drawing ticks on horizontal axis
  for (int i=0; i<alldata.getColumnCount (); i++)
  {
    float x=border+(i*hInt);
    line(x, height-(border-tick), x, height-border);

    float textY = height-(border*0.7f);
    textSize(12);
    text(2004+i, x, textY);
  }
  float max = alldata.getFloat(0, 0);
  for (int i=0; i<alldata.getRowCount (); i++)
  {
    for (int j=0; j<alldata.getColumnCount (); j++)
    {
      if (alldata.getFloat(i, j)>max)
      {
        max=alldata.getFloat(i, j);
      }
    }
  }
  //scaling
  scale = (height-border*2)/max;
  float Vint = 58;
  float VdataGap=max/Vint;
  float VwindowRange=height-(border*2);
  float VwindowGap=VwindowRange/Vint;
  for (int i=0; i<Vint; i++)
  {
    float y=(height-border)-(i*VwindowGap);
    line(border-tick, y, border, y);
  }
  for (int i=0; i<29; i++)
  {
    float y=(height-border)-(2*(i*VwindowGap));
    text((50000*i), 5, y);
  }
  return border;
}

void mousePressed()
{
  if (state==menu)
  {
    if (menuButtons[0].containsMouse()) 
    {
      background(0);
      state=seeChart;
      if (drawBoxes) drawBoxes = false;
      else drawBoxes = true;
    }
    if (menuButtons[1].containsMouse())
    {
      background(0);
      state=seeMap;
      if (drawBoxes) drawBoxes = false;
      else drawBoxes = true;
    }
  }
  if (state==seeChart)
  {
    if(menuButtons[2].containsMouse())
    {
      state=menu;
    }
    for (int i=0; i<cButton.length; i++)
    {
      if (cButton[i].containsMouse())
      {
        background(0);
        for (int j=1; j<alldata.getColumnCount (); j++)
        {
          float border = width*0.1f;
          float windowRange = width - (border*3.5f);
          float lineW = windowRange / alldata.getColumnCount()-1;
          float x1 = border + ((j-1)*lineW);
          float x2 = border + (j*lineW);
          float y1 = (height-border) - (alldata.getFloat(i, j-1) * scale);
          float y2 = (height-border) - (alldata.getFloat(i, j) * scale);
          stroke(50);
          line(x2, y2, border, y2);
          stroke(255, 0, 0);
          line(x1, y1, x2, y2);
        }
      }
    }
  }
  if (state==seeMap)
  {
    if(menuButtons[2].containsMouse())
    {
      state=menu;
    }
    background(0);
    img.resize(500, 500);
    image(img, 40, 100);
    for (int i=0; i<cButton.length; i++)
    {
      if (cButton[i].containsMouse())
      {
        stroke(255, 0, 0);
        fill(255);
        rect(x[i], y[i], 170, 70);
        fill(0);
        textSize(12);
        text(countries[i]+"\nConsumption of reusable \nenergy in 2013:\n\tAll: "+alldata.getFloat(i, 9)+" terajoules", x[i]+5, y[i]+10);
        stroke(255, 0, 0);
        fill(255, 0, 0);
        ellipse(x[i], y[i], 6, 6);
      }
    }
  }
}

