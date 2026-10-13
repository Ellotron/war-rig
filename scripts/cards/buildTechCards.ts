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

const drawAttackSymbol = (context, cx: number, cy: number, radius = 10, dieColor = "#111") => {
  context.save();
  context.beginPath();

  if (dieColor === "#c62828") {
    // Red attack dice are D8s: an octahedral silhouette with triangular facets.
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx - radius, cy);
    context.closePath();
    context.fillStyle = dieColor;
    context.fill();
    context.strokeStyle = "#7f1515";
    context.lineWidth = 1;
    context.stroke();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx - radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx + radius, cy);
    context.moveTo(cx - radius, cy);
    context.lineTo(cx + radius, cy);
    context.strokeStyle = "#ffb3b3";
    context.lineWidth = 0.7;
    context.stroke();
  } else {
    // Black attack dice are D20s, shown as a compact faceted polygon.
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius * 0.78, cy - radius * 0.48);
    context.lineTo(cx + radius, cy + radius * 0.28);
    context.lineTo(cx + radius * 0.48, cy + radius * 0.88);
    context.lineTo(cx - radius * 0.48, cy + radius * 0.88);
    context.lineTo(cx - radius, cy + radius * 0.28);
    context.lineTo(cx - radius * 0.78, cy - radius * 0.48);
    context.closePath();
    context.fillStyle = dieColor;
    context.fill();
    context.strokeStyle = "#777";
    context.lineWidth = 1;
    context.stroke();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx - radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx - radius * 0.78, cy - radius * 0.48);
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx + radius * 0.78, cy - radius * 0.48);
    context.moveTo(cx - radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx - radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx - radius * 0.48, cy + radius * 0.88);
    context.moveTo(cx + radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx + radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx + radius * 0.48, cy + radius * 0.88);
    context.moveTo(cx - radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx, cy + radius * 0.55);
    context.lineTo(cx + radius * 0.62, cy + radius * 0.34);
    context.strokeStyle = "#ddd";
    context.lineWidth = 0.7;
    context.stroke();
  }
  context.restore();
};

const drawArmourSymbol = (context, cx: number, cy: number, size = 10) => {
  context.beginPath();
  context.moveTo(cx, cy - size);
  context.lineTo(cx + size * 0.82, cy - size * 0.55);
  context.lineTo(cx + size * 0.68, cy + size * 0.35);
  context.quadraticCurveTo(cx, cy + size * 1.2, cx, cy + size * 1.2);
  context.quadraticCurveTo(cx, cy + size * 1.2, cx - size * 0.68, cy + size * 0.35);
  context.lineTo(cx - size * 0.82, cy - size * 0.55);
  context.closePath();
  context.fillStyle = "#171717";
  context.fill();
  context.strokeStyle = "#777";
  context.lineWidth = 1.5;
  context.stroke();
};

const drawLightning = (context, x: number, y: number) => {
  context.beginPath();
  context.moveTo(x + 13, y);
  context.lineTo(x, y + 17);
  context.lineTo(x + 10, y + 17);
  context.lineTo(x + 5, y + 32);
  context.lineTo(x + 24, y + 12);
  context.lineTo(x + 14, y + 12);
  context.closePath();
  context.fillStyle = "#f0c84b";
  context.fill();
};

const drawWeaponLayout = (loc, card, context) => {
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
  const attackDieColor = card.attackDieColor === "red" ? "#c62828" : "#111";
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
  const locations = getLocations(techCardSpec, totalCards);

  const drawBase = (loc, card) =>
    drawCardBase(loc, card, context, assets, techCardSpec);
  const endIfHidden = (_, card) => card.title !== "hidden";
  const drawTitle = (loc, card) =>
    drawCardText(loc, card.title, titleSpec, context);
  const drawDescription = (loc, card) => {
    if (card.attackRating || card.armourRating || card.weight || card.specialAbilities) {
      return drawWeaponLayout(loc, card, context);
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
      context.fillRect(loc.x + 26, loc.y + 475, 355, 78);
      return drawCardText(loc, card.flavour, flavourSpec, context);
    },
  ]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/tech.png", buffer);
});
