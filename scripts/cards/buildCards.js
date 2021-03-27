const fs = require("fs");
const { createCanvas, loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");
const drawMultilineText = require("canvas-multiline-text");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });

const loadAssets = async () => {
  return {
    baseImages: [
      await loadImage("./assets/cards/card-hidden.png"),
      await loadImage("./assets/cards/eqp-std-1.png"),
      await loadImage("./assets/cards/eqp-std-2.png"),
      await loadImage("./assets/cards/eqp-std-3.png"),
      await loadImage("./assets/cards/rig-wep-1.png"),
      await loadImage("./assets/cards/rig-wep-2.png"),
      await loadImage("./assets/cards/rig-wep-3.png"),
      await loadImage("./assets/cards/rig-low-1.png"),
      await loadImage("./assets/cards/rig-low-2.png"),
      await loadImage("./assets/cards/rig-low-3.png"),
      await loadImage("./assets/cards/rig-tgt-1.png"),
      await loadImage("./assets/cards/fac-spc-1.png"),
      await loadImage("./assets/cards/fac-spc-2.png"),
      await loadImage("./assets/cards/fac-spc-3.png"),
      await loadImage("./assets/cards/fac-spc-4.png"),
      await loadImage("./assets/cards/fac-spc-5.png"),
      await loadImage("./assets/cards/fac-cre-1.png"),
      await loadImage("./assets/cards/fac-cre-2.png"),
      await loadImage("./assets/cards/fac-cre-3.png"),
      await loadImage("./assets/cards/fac-cre-4.png"),
      await loadImage("./assets/cards/fac-cre-5.png"),
      await loadImage("./assets/cards/eqp-ext-1.png"),
      await loadImage("./assets/cards/eqp-ext-2.png"),
      await loadImage("./assets/cards/eqp-ext-3.png"),
      await loadImage("./assets/cards/fac-ext-1.png"),
      await loadImage("./assets/cards/fac-ext-2.png"),
      await loadImage("./assets/cards/fac-ext-3.png"),
      await loadImage("./assets/cards/rig-tgt-2.png"),
      await loadImage("./assets/cards/rig-tgt-3.png"),
      await loadImage("./assets/cards/rig-tgt-4.png"),
    ],
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
  cost: {
    x1Offset: 38,
    y1Offset: 48,
    x2Offset: 78,
    y2Offset: 88,
    colour: "#FFF",
  },
};

loadAssets().then((assets) => {
  const content = assets.content;
  const totalCards = content
    .map((x) => parseInt(x.count))
    .reduce((a, c) => a + c);
  console.log("Deck size:", totalCards);

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
    context.drawImage(
      assets.baseImages[content[i].base],
      loc.x,
      loc.y,
      cards.width,
      cards.height
    );
    context.font = cards.title.font;
    context.textAlign = cards.title.align;
    context.textBaseline = cards.title.baseline;
    context.fillStyle = cards.title.colour;
    if (content[i].title !== "hidden") {
      // title
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

      // cost
      context.fillStyle = cards.cost.colour;
      if (content[i].red > 0) {
        context.fillText(
          content[i].red,
          loc.x + cards.cost.x1Offset,
          loc.y + cards.cost.y1Offset
        );
      }
      if (content[i].green > 0) {
        context.fillText(
          content[i].green,
          loc.x + cards.cost.x2Offset,
          loc.y + cards.cost.y1Offset
        );
      }
      if (content[i].brown > 0) {
        context.fillText(
          content[i].brown,
          loc.x + cards.cost.x2Offset,
          loc.y + cards.cost.y2Offset
        );
      }
      if (content[i].blue > 0) {
        context.fillText(
          content[i].blue,
          loc.x + cards.cost.x1Offset,
          loc.y + cards.cost.y2Offset
        );
      }
    }
    count--;
  });

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
