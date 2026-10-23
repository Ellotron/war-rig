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

const drawLowerRigMovementLayout = (loc, card, context) => {
  const x = loc.x + 22;
  const y = loc.y + 305;
  const width = 363;
  const height = 166;
  context.fillStyle = "#fff";
  context.fillRect(x, y, width, height);
  context.strokeStyle = "#111";
  context.lineWidth = 2.5;
  context.strokeRect(x, y, width, height);

  context.fillStyle = "#111";
  context.font = "18px Arial";
  context.textAlign = "left";
  context.textBaseline = "middle";
  context.fillText("Armour:", x + 7, y + 17);
  const armour = Math.max(0, Math.min(10, parseInt(card.armourRating, 10) || 0));
  for (let i = 0; i < armour; i++) drawArmourSymbol(context, x + 91 + i * 25, y + 16, 9);

  context.fillStyle = "#fff";
  context.fillRect(x + 229, y + 1, 129, 38);
  context.strokeStyle = "#111";
  context.lineWidth = 2.5;
  context.strokeRect(x + 229, y + 1, 129, 38);
  context.fillStyle = "#111";
  context.font = "18px Arial";
  context.fillText("Weight: " + (card.weight || ""), x + 235, y + 20);

  context.fillStyle = "#fff";
  context.fillRect(x + 229, y + 40, 129, 82);
  context.strokeStyle = "#111";
  context.lineWidth = 2;
  context.strokeRect(x + 229, y + 40, 129, 82);
  context.fillStyle = "#111";
  context.font = "15px Arial";
  context.fillText("Supports max:", x + 235, y + 51);
  context.font = "13px Arial";
  context.fillText("• Light: " + (card.supportLight || "—"), x + 235, y + 67);
  context.fillText("• Medium: " + (card.supportMedium || "—"), x + 235, y + 83);
  context.fillText("• Heavy: " + (card.supportHeavy || "—"), x + 235, y + 99);

  const description = (card.description || "").trim();
  if (description) {
    context.save();
    // Keep description text inside the left column and never let it enter the support table.
    const descX = x + 8;
    const descY = y + 43;
    const descWidth = 211;
    const descHeight = 120;
    context.beginPath();
    context.rect(descX, descY, descWidth, descHeight);
    context.clip();
    context.fillStyle = "#111";
    context.font = "16px Arial";
    context.textAlign = "left";
    context.textBaseline = "top";
    // Parse bold spans the same way as drawRichCardText, retaining ordinary text around them.
    const parseLine = (line: string) => {
      const segments: { text: string; bold: boolean }[] = [];
      const pattern = /\*\*(.*?)\*\*/g;
      let cursor = 0;
      let match;
      while ((match = pattern.exec(line)) !== null) {
        if (match.index > cursor) segments.push({ text: line.slice(cursor, match.index), bold: false });
        segments.push({ text: match[1], bold: true });
        cursor = pattern.lastIndex;
      }
      if (cursor < line.length) segments.push({ text: line.slice(cursor), bold: false });
      return segments;
    };
    const fontFor = (bold: boolean) => bold ? "bold 16px Arial" : "16px Arial";
    const lines: { text: string; bold: boolean }[][] = [[]];
    for (const segment of parseLine(description)) {
      const words = segment.text.match(/\s+|\S+/g) || [];
      for (const word of words) {
        const current = lines[lines.length - 1];
        const currentText = current.map((part) => part.text).join("");
        context.font = fontFor(segment.bold);
        if (current.length > 0 && context.measureText(currentText + word).width > descWidth && !/^\s+$/.test(word)) {
          lines.push([]);
        }
        lines[lines.length - 1].push({ text: word, bold: segment.bold });
      }
    }
    const lineHeight = 18;
    lines.forEach((parts, index) => {
      const top = descY + index * lineHeight;
      if (top + lineHeight > descY + descHeight) return;
      let cursorX = descX;
      for (const part of parts) {
        context.font = fontFor(part.bold);
        context.fillText(part.text, cursorX, top);
        cursorX += context.measureText(part.text).width;
      }
    });
    context.restore();
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
    if (card.layout === "lowerRigMovement") {
      return drawLowerRigMovementLayout(loc, card, context);
    }
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
