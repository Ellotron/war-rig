const { createCanvas } = require("canvas");
const drawMultilineText = require("canvas-multiline-text");

export const drawCanvas = (page: PageSpec) => {
  const canvas = createCanvas(page.width, page.height);
  const context = canvas.getContext("2d");

  context.fillStyle = page.backColour;
  context.fillRect(0, 0, page.width, page.height);

  return { context, canvas };
};

export const drawCardBase = (
  cardLocation: CardLocation,
  cardContent: any,
  context,
  assets,
  cardSize: Size
) => {
  context.drawImage(
    assets.baseImages[cardContent.base],
    cardLocation.x,
    cardLocation.y,
    cardSize.width,
    cardSize.height
  );
  return true;
};

export const drawCardTitle = (
  cardLocation: CardLocation,
  cardContent: any,
  titleSpec: TitleSpec,
  context
) => {
  context.font = titleSpec.font;
  context.textAlign = titleSpec.align;
  context.textBaseline = titleSpec.baseline;
  context.fillStyle = titleSpec.colour;
  drawMultilineText(context, cardContent.title, {
    rect: {
      x: cardLocation.x + titleSpec.xOffset,
      y: cardLocation.y + titleSpec.yOffset,
      width: titleSpec.width,
      height: titleSpec.height,
    },
    font: titleSpec.font,
    minFontSize: titleSpec.minFontSize,
    maxFontSize: titleSpec.maxFontSize,
  });
  return true;
};

export const drawCardCost = (
  loc: CardLocation,
  card: any,
  context,
  cards: CostSpec
) => {
  context.fillStyle = cards.colour;
  if (card.red > 0) {
    context.fillText(card.red, loc.x + cards.x1Offset, loc.y + cards.y1Offset);
  }
  if (card.green > 0) {
    context.fillText(
      card.green,
      loc.x + cards.x2Offset,
      loc.y + cards.y1Offset
    );
  }
  if (card.brown > 0) {
    context.fillText(
      card.brown,
      loc.x + cards.x2Offset,
      loc.y + cards.y2Offset
    );
  }
  if (card.blue > 0) {
    context.fillText(card.blue, loc.x + cards.x1Offset, loc.y + cards.y2Offset);
  }
  return true;
};
