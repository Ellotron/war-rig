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
import { drawArmourSymbol, drawAttackSymbol, drawLightning } from "./drawSymbols";

const fs = require("fs");
const { loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });
registerFont("./fonts/corbel.ttf", { family: "Corbel" });
registerFont("./fonts/corbelita.ttf", { family: "Corbel Italic" });

const drawWeaponDescription = (loc, card, context) => {
  // Rebuild the original weapon-stat panel so values can change without
  // turning the stats into a generic paragraph. The original artwork's
  // labels and pre-printed symbols are replaced by this consistently placed layout.
  const x = loc.x + 22;
  const y = loc.y + 305;
  const width = 363;
  const height = 162;
  context.fillStyle = "#fff";
  context.fillRect(x, y, width, height);
  context.strokeStyle = "#111";
  context.lineWidth = 2.5;
  context.strokeRect(x, y, width, height);

  context.fillStyle = "#111";
  context.font = "18px Arial";
  context.textAlign = "left";
  context.textBaseline = "middle";
  context.fillText("Attack:", x + 7, y + 17);
  const attack = Math.max(0, Math.min(10, parseInt(card.attackRating, 10) || 0));
  const attackDieColor = card.attackDieColor === "red" ? "#c62828" : card.attackDieColor === "blue" ? "#1565c0" : "#111";
  for (let i = 0; i < attack; i++) drawAttackSymbol(context, x + 94 + i * 25, y + 17, 10, attackDieColor);

  context.fillText("Armour:", x + 7, y + 55);
  const armour = Math.max(0, Math.min(10, parseInt(card.armourRating, 10) || 0));
  for (let i = 0; i < armour; i++) drawArmourSymbol(context, x + 95 + i * 25, y + 53, 9);

  // Weight remains in its own boxed area at the top-right, as on the source card.
  context.fillStyle = "#fff";
  context.fillRect(x + 247, y + 1, 111, 38);
  context.strokeStyle = "#111";
  context.lineWidth = 2.5;
  context.strokeRect(x + 247, y + 1, 111, 38);
  context.fillStyle = "#111";
  context.font = "18px Arial";
  context.fillText(`Weight: ${card.weight || ""}`, x + 253, y + 20);

  context.font = "18px Arial";
  context.fillText("Special Abilities:", x + 7, y + 87);
  if (card.specialAbilities && card.specialAbilities.trim()) {
    drawLightning(context, x + 14, y + 107);
    context.fillStyle = "#111";
    context.textAlign = "left";
    context.font = "16px Arial";
    const text = card.specialAbilities.trim();
    const maxWidth = width - 62;
    const words = text.split(/\s+/);
    let line = "";
    let lineY = y + 112;
    for (const word of words) {
      const candidate = line ? line + " " + word : word;
      if (line && context.measureText(candidate).width > maxWidth) {
        context.fillText(line, x + 54, lineY);
        line = word;
        lineY += 21;
      } else {
        line = candidate;
      }
    }
    if (line) context.fillText(line, x + 54, lineY);
  }
  return true;
};

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
  const locations = getLocations(
    techCardSpec,
    totalCards,
    techPageSpec.pageBreak
  );

  const drawBase = (loc, card) =>
    drawCardBase(loc, card, context, assets, techCardSpec);
  const endIfHidden = (_, card) => card.title !== "hidden";
  const drawTitle = (loc, card) =>
    drawCardText(loc, card.title, titleSpec, context);
  const drawDescription = (loc, card) => {
    if (card.attackRating && card.armourRating) {
      return drawWeaponDescription(loc, card, context);
    }
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
