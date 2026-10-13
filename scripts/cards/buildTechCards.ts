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
    if (card.attackRating || card.armourRating || card.weight || card.specialAbilities) {
      const parts = [];
      if (card.attackRating) parts.push(`Attack: ${card.attackRating}`);
      if (card.armourRating) parts.push(`Armour: ${card.armourRating}`);
      if (card.weight) parts.push(`Weight: ${card.weight}`);
      if (card.specialAbilities && card.specialAbilities.trim()) {
        parts.push(`Special abilities: ${card.specialAbilities.trim()}`);
      }
      return drawRichCardText(loc, parts.join("\\n"), {
        ...techDescriptionSpec,
        xOffset: 31,
        yOffset: 315,
        width: 345,
        height: 130,
        minFontSize: 14,
        maxFontSize: 18,
      }, context);
    }
    if (!card.description || !card.description.trim()) return true;
    return drawRichCardText(loc, card.description, techDescriptionSpec, context);
  };
  const drawCost = (loc, card) => drawCardCost(loc, card, context, costSpec);

  buildCards(locations, content, [
    drawBase,
    endIfHidden,
    drawTitle,
    drawCost,
    drawDescription,
    (loc, card) => {
      if (!card.flavour || !card.flavour.trim()) return true;
      // Clear the existing printed flavour text before drawing the italic replacement.
      context.fillStyle = "#fff";
      context.fillRect(
        loc.x + 26,
        loc.y + 475,
        355,
        78
      );
      return drawCardText(loc, card.flavour, flavourSpec, context);
    },
  ]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
