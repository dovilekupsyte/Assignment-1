class Country 
{
  PVector pos;
  color textColor, hoverColor;
  float size, tWidth;
  String cName;
  float data;
  
  Country(float data, String cName, PVector pos, float size, color textColor, color hoverColor)
  {
    this.pos = pos;
    this.textColor = textColor;
    this.hoverColor = hoverColor;
    this.size=size;
    this.cName = cName;
    this.data=data;
    textSize(size);
    tWidth = textWidth(cName);
  }
  
  void draw(boolean on)
  {
    textSize(size);
    if (containsMouse()) fill(hoverColor);
    else fill(textColor);
    text(cName, pos.x, pos.y + size);
    if (on)
      rect(pos.x, pos.y, tWidth, size);
   } 
   
  boolean containsMouse() {
    if (mouseX > pos.x && mouseX < pos.x + tWidth && mouseY > pos.y && mouseY < pos.y + size ) 
      return true;
    else return false;
  }
}
