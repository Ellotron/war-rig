import { buildCards, getDeckSize, getLocations } from "./buildCards";
import {
  costSpec,
  techBaseImages,
  techCardSpec,
  techDescriptionSpec,
  flavourSpec,
  techPageSpec,
  titleSpec,
} from "./constants";
import {
  drawCardBase,
  drawCanvas,
  drawCardCost,
  drawCardText,
  drawRichCardText,
  drawCardFlavour,
} from "./drawCards";

const fs = require("fs");
const { loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });
registerFont("./fonts/corbel.ttf", { family: "Corbel" });
registerFont("./fonts/corbelita.ttf", { family: "Corbel Italic" });

const loadAssets = async () => {
  return {
    baseImages: await Promise.all(
      techBaseImages.map(async (image) => await loadImage(image))
    ),
    content: await csv().fromFile("./scripts/cards/techContent.csv"),
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
  const drawTitle = (loc, card) =>
    drawCardText(loc, card.title, titleSpec, context);
  const drawDescription = (loc, card) => {
    if (!card.description || !card.description.trim()) return true;
    return drawRichCardText(loc, card.description, techDescriptionSpec, context);
  };
  const drawCost = (loc, card) => drawCardCost(loc, card, context, costSpec);
  const drawFlavour = (loc, card) => {
    if (!card.flavour || !card.flavour.trim()) return true;
    return drawCardFlavour(loc, card.flavour, flavourSpec, context);
  };


  buildCards(locations, content, [
    drawBase,
    endIfHidden,
    drawTitle,
    drawCost,
    drawDescription,
    drawFlavour,
  ]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
