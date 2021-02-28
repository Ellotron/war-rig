const fs = require("fs");
const { createCanvas, loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });

const loadAssets = async () => {
  return {
    base: await loadImage("./assets/cards/card-base.png"),
    content: await csv().fromFile("./scripts/cards/content.csv"),
  };
};

const wordsToLines = (words, thresh, context) => {
  var lines = [];
  var line = "";
  var wordIndex = 0;
  while (wordIndex < words.length) {
    var textWidth = context.measureText(line).width;
    while (textWidth < thresh && wordIndex < words.length) {
      const lineWithSpace = `${line} `;
      line = `${line == "" ? "" : lineWithSpace}${words[wordIndex++]}`;
      textWidth = context.measureText(line).width;
    }
    lines.push(line);
    line = "";
  }
  return lines;
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
    maxWidth: 278,
    single: {
      hOffset: 240,
      vOffset: 68,
    },
    double: {
      vOffset1: 51,
      vOffset2: 85,
    },
    font: "22pt Copperplate Gothic",
    align: "center",
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
    context.fillStyle = cards.title.colour;

    const words = content[i].title.split(" ");
    const lines = wordsToLines(words, cards.title.maxWidth / 2, context);
    const titleCentre = loc.x + cards.title.single.hOffset;
    if (lines.length == 1) {
      context.fillText(
        lines[0],
        titleCentre,
        loc.y + cards.title.single.vOffset
      );
    } else if (lines.length == 2) {
      context.fillText(
        lines[0],
        titleCentre,
        loc.y + cards.title.double.vOffset1
      );
      context.fillText(
        lines[1],
        titleCentre,
        loc.y + cards.title.double.vOffset2
      );
    } else {
      console.error(`No handling for ${lines.length} line titles ${lines}`);
    }

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
