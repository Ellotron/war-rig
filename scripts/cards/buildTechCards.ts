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

  if (dieColor === "#c62828" || dieColor === "#1565c0") {
    // Red attack dice are D8s; blue attack dice are D12s. Give the die distinct triangular facets
    // and a small face value so it reads as a die, not just a red diamond.
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx - radius, cy);
    context.closePath();
    context.fillStyle = dieColor;
    context.fill();
    context.strokeStyle = dieColor === "#1565c0" ? "#0d2f66" : "#7f1515";
    context.lineWidth = 1;
    context.stroke();

    // Faceted triangular faces and contrasting highlights make the colored die readable at card size.
    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx - radius, cy);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#64b5f6" : "#ef7777";
    context.fill();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius, cy);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#1565c0" : "#b51f1f";
    context.fill();

    context.beginPath();
    context.moveTo(cx - radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#1e88e5" : "#d93636";
    context.fill();

    context.beginPath();
    context.moveTo(cx + radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#0d47a1" : "#981b1b";
    context.fill();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx, cy);
    context.lineTo(cx - radius, cy);
    context.moveTo(cx, cy - radius);
    context.lineTo(cx, cy);
    context.lineTo(cx + radius, cy);
    context.moveTo(cx - radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx + radius, cy);
    context.strokeStyle = dieColor === "#1565c0" ? "#bbdefb" : "#ffd0d0";
    context.lineWidth = 0.7;
    context.stroke();

    context.fillStyle = "#fff";
    context.font = `bold ${Math.max(8, radius * 0.9)}px Arial`;
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillText(dieColor === "#1565c0" ? "12" : "8", cx, cy + 0.5);
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

const drawCappedSymbols = (context, value: number, drawSymbol, x: number, y: number, spacing: number) => {
  const count = Math.max(0, Math.floor(value || 0));
  const visibleCount = count > 5 ? 1 : count;
  for (let i = 0; i < visibleCount; i++) drawSymbol(x + i * spacing);
  if (count > 5) {
    context.save();
    context.fillStyle = "#111";
    context.font = "16px Arial";
    context.textAlign = "left";
    context.textBaseline = "middle";
    context.fillText("x " + count, x + spacing, y);
    context.restore();
  }
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
  const attackDieColor = card.attackDieColor === "red" ? "#c62828" : card.attackDieColor === "blue" ? "#1565c0" : "#111";
  drawCappedSymbols(context, attack, (symbolX) => drawAttackSymbol(context, symbolX, y + 17, 10, attackDieColor), x + 94, y + 17, 25);

  context.fillText("Armour:", x + 7, y + 55);
  const armour = Math.max(0, Math.min(10, parseInt(card.armourRating, 10) || 0));
  drawCappedSymbols(context, armour, (symbolX) => drawArmourSymbol(context, symbolX, y + 53, 9), x + 95, y + 53, 25);

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
  drawCappedSymbols(context, armour, (symbolX) => drawArmourSymbol(context, symbolX, y + 16, 9), x + 91, y + 16, 25);

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

const drawArmourDescriptionLayout = (loc, card, context) => {
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
  const indestructible = card.layout === "indestructibleArmour" || String(card.armourRating).trim() === "∞";
  if (indestructible) {
    context.font = "bold 26px Arial";
    context.fillText("∞", x + 91, y + 17);
    context.font = "16px Arial";
    context.fillText("(Cannot be destroyed)", x + 117, y + 17);
  } else {
    const armour = Math.max(0, Math.min(10, parseInt(card.armourRating, 10) || 0));
    drawCappedSymbols(context, armour, (symbolX) => drawArmourSymbol(context, symbolX, y + 16, 9), x + 91, y + 16, 25);
  }

  if (card.weight && card.weight.trim()) {
    context.fillStyle = "#fff";
    context.fillRect(x + 229, y + 1, 129, 38);
    context.strokeStyle = "#111";
    context.lineWidth = 2.5;
    context.strokeRect(x + 229, y + 1, 129, 38);
    context.fillStyle = "#111";
    context.font = "18px Arial";
    context.fillText("Weight: " + card.weight, x + 235, y + 20);
  }

  const description = (card.description || "").trim();
  if (description) {
    context.save();
    const descX = x + 8;
    const descY = y + 45;
    const descWidth = width - 16;
    const descHeight = height - 53;
    context.beginPath();
    context.rect(descX, descY, descWidth, descHeight);
    context.clip();
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
    const fontFor = (size: number, bold: boolean) => bold ? `bold ${size}px Arial` : `${size}px Arial`;
    const size = 16;
    const lineHeight = 19;
    const lines: { text: string; bold: boolean }[][] = [[]];
    for (const segment of parseLine(description)) {
      for (const word of (segment.text.match(/\s+|\S+/g) || [])) {
        const current = lines[lines.length - 1];
        const currentText = current.map((part) => part.text).join("");
        context.font = fontFor(size, segment.bold);
        if (current.length > 0 && context.measureText(currentText + word).width > descWidth && !/^\s+$/.test(word)) lines.push([]);
        lines[lines.length - 1].push({ text: word, bold: segment.bold });
      }
    }
    context.fillStyle = "#111";
    context.textAlign = "left";
    context.textBaseline = "top";
    lines.forEach((line, index) => {
      const top = descY + index * lineHeight;
      if (top + lineHeight > descY + descHeight) return;
      let cursorX = descX;
      for (const part of line) {
        context.font = fontFor(size, part.bold);
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
  const locations = getLocations(techCardSpec, totalCards);

  const drawBase = (loc, card) =>
    drawCardBase(loc, card, context, assets, techCardSpec);
  const endIfHidden = (_, card) => card.title !== "hidden";
  const drawTitle = (loc, card) =>
    drawCardText(loc, card.title, titleSpec, context);
  const drawDescription = (loc, card) => {
    if (card.layout === "armourDescription") {
      return drawArmourDescriptionLayout(loc, card, context);
    }
    if (card.layout === "lowerRigMovement") {
      return drawLowerRigMovementLayout(loc, card, context);
    }
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
