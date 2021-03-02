const fs = require("fs");
const { createCanvas, loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");
const drawMultilineText = require("canvas-multiline-text");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });

const loadAssets = async () => {
  return {
    base: await loadImage("./assets/cards/card-base.png"),
    content: await csv().fromFile("./scripts/cards/content.csv"),
  };
};

const page = {
  width: 4096,
  height: 4096,
  backColour: "#000",
};

const cards = {
  perRow: 10,
  width: 407,
  height: 584,
  hGap: 2,
  vGap: 1,
  title: {
    width: 278,
    height: 40,
    xOffset: 240,
    yOffset: 35,
    minFontSize: 25,
    maxFontSize: 100,
    font: "Copperplate Gothic",
    align: "center",
    baseline: "alphabetic",
    colour: "#000",
  },
};

loadAssets().then((assets) => {
  const content = assets.content;
  const totalCards = content
    .map((x) => parseInt(x.count))
    .reduce((a, c) => a + c);
  console.log(totalCards);

  const canvas = createCanvas(page.width, page.height);
  const context = canvas.getContext("2d");

  context.fillStyle = page.backColour;
  context.fillRect(0, 0, page.width, page.height);

  const locations = [];
  var x = 0;
  var y = 0;
  for (var i = 1; i <= totalCards; i++) {
    locations.push({ x, y });
    x += cards.width + cards.hGap;
    if (i > 0 && i % cards.perRow == 0) {
      x = 0;
      y += cards.height + cards.vGap;
    }
  }

  var i = -1;
  var count = 0;
  locations.forEach((loc) => {
    if (count === 0) {
      i++;
      count = content[i].count;
    }
    context.drawImage(assets.base, loc.x, loc.y, cards.width, cards.height);
    context.font = cards.title.font;
    context.textAlign = cards.title.align;
    context.textBaseline = cards.title.baseline;
    context.fillStyle = cards.title.colour;

    drawMultilineText(context, content[i].title, {
      rect: {
        x: loc.x + cards.title.xOffset,
        y: loc.y + cards.title.yOffset,
        width: cards.title.width,
        height: cards.title.height,
      },
      font: cards.title.font,
      minFontSize: cards.title.minFontSize,
      maxFontSize: cards.title.maxFontSize,
    });
    count--;
  });

  // context.font = '22pt Copperplate Gothic'
  // context.textAlign = 'center'
  // context.textBaseline = 'top'
  // context.fillStyle = '#3574d4'

  // const text = 'Hello, World!'

  // const textWidth = context.measureText(text).width
  // context.fillRect(600 - textWidth / 2 - 10, 170 - 5, textWidth + 20, 120)
  // context.fillStyle = '#fff'
  // context.fillText(text, 600, 170)

  // context.fillStyle = '#fff'
  // context.font = 'bold 30pt Menlo'
  // context.fillText('flaviocopes.com', 600, 530)

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
