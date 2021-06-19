import { buildCards, getDeckSize, getLocations } from "./buildCards";
import {
  costSpec,
  techBaseImages,
  techCardSpec,
  techPageSpec,
  titleSpec,
} from "./constants";
import {
  drawCardBase,
  drawCanvas,
  drawCardCost,
  drawCardTitle,
} from "./drawCards";

const fs = require("fs");
const { loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });

const loadAssets = async () => {
  return {
    baseImages: await Promise.all(
      techBaseImages.map(async (image) => await loadImage(image))
    ),
    content: await csv().fromFile("./scripts/cards/content.csv"),
  };
};

loadAssets().then((assets) => {
  const content = assets.content;
  const totalCards = getDeckSize(content);
  console.log("Deck size:", totalCards);

  const { context, canvas } = drawCanvas(techPageSpec);
  const locations = getLocations(techCardSpec, totalCards);

  const drawBase = (loc, card) =>
    drawCardBase(loc, card, context, assets, techCardSpec);
  const endIfHidden = (_, card) => card.title !== "hidden";
  const drawTitle = (loc, card) => drawCardTitle(loc, card, titleSpec, context);
  const drawCost = (loc, card) => drawCardCost(loc, card, context, costSpec);

  buildCards(locations, content, [drawBase, endIfHidden, drawTitle, drawCost]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
