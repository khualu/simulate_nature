void drawGrid( )
{
  drawGrid(true);
}

void drawGrid(boolean showZero)
{
  final int STEP = 20;
  final int MAX = 200;
  String numStr;

  textFont(font);
  if (showZero)
  {
    text("0", -textWidth("0"), -textDescent());
  }
  for (int x = 0; x < MAX + STEP; x += STEP)
  {
    if (showZero || x != 0 && (!showZero && x != MAX))
    {
      numStr = Integer.toString(x);
      text(numStr, x - textWidth(numStr) / 2, -textDescent());
    }
    line(x, 0, x, MAX);
  }
  for (int y = 0; y < MAX + STEP; y += STEP)
  {
    if (y != 0 )
    {
      numStr = Integer.toString(y);
      text(numStr, -textWidth(numStr)-2, y + textAscent() / 2 );
    }
    line(0, y, MAX, y);
  }
}

