type PageSpec = Size & {
  backColour: string;
};

type CardContent = {
  count: string;
};

type Size = {
  width: number;
  height: number;
};

type CostSpec = {
  x1Offset: number;
  y1Offset: number;
  x2Offset: number;
  y2Offset: number;
  colour: string;
};

type TextSpec = Offset & {
  width: number;
  height: number;
  minFontSize: number;
  maxFontSize: number;
  font: string;
  align: string;
  baseline: string;
  colour: string;
};

type CardSpec = Size & {
  perRow: number;
  hGap: number;
  vGap: number;
};

type ImageSpec = Size & Offset;

type Offset = {
  xOffset: number;
  yOffset: number;
};

type CardLocation = {
  x: number;
  y: number;
};
