const { createCanvas } = require("canvas");
const drawMultilineText = require("canvas-multiline-text");

export const drawCanvas = (page: PageSpec) => {
  const canvas = createCanvas(page.width, page.height);
  const context = canvas.getContext("2d");

  context.fillStyle = page.backColour;
  context.fillRect(0, 0, page.width, page.height);

  return { context, canvas };
};

export const drawCardBase = (
  cardLocation: CardLocation,
  cardContent: any,
  context,
  assets,
  cardSize: Size
) => {
  context.drawImage(
    assets.baseImages[cardContent.base],
    cardLocation.x,
    cardLocation.y,
    cardSize.width,
    cardSize.height
  );
  return true;
};

export const drawCardImage = (
  cardLocation: CardLocation,
  cardImage: number,
  imageSpec: ImageSpec,
  context,
  assets
) => {
  context.drawImage(
    assets.cardImages[cardImage],
    cardLocation.x + imageSpec.xOffset,
    cardLocation.y + imageSpec.yOffset,
    imageSpec.width,
    imageSpec.height
  );
  return true;
};

export const drawCardText = (
  cardLocation: CardLocation,
  text: string,
  textSpec: TextSpec,
  context
) => {
  context.font = textSpec.font;
  context.textAlign = textSpec.align;
  context.textBaseline = textSpec.baseline;
  context.fillStyle = textSpec.colour;
  drawMultilineText(context, text, {
    rect: {
      x: cardLocation.x + textSpec.xOffset,
      y: cardLocation.y + textSpec.yOffset,
      width: textSpec.width,
      height: textSpec.height,
    },
    font: textSpec.font,
    minFontSize: textSpec.minFontSize,
    maxFontSize: textSpec.maxFontSize,
  });
  return true;
};

/**
 * Draw description markup. Use **text** for bold and newline characters for
 * explicit line breaks. Plain text remains supported for existing CSV rows.
 */
export const drawRichCardText = (
  cardLocation: CardLocation,
  text: string,
  textSpec: TextSpec,
  context
) => {
  const x = cardLocation.x + textSpec.xOffset;
  const y = cardLocation.y + textSpec.yOffset;
  const maxWidth = textSpec.width;
  const maxHeight = textSpec.height;
  const baseFont = textSpec.font || "Arial";
  const colour = textSpec.colour || "#000";

  // Clear the full printed rules-text panel, not just the new text bounds.
  // Keep a small inset to preserve the card outline and stop before flavour text.
  context.fillStyle = "#fff";
  context.fillRect(cardLocation.x + 16, cardLocation.y + 305, 375, 145);
  const parseLine = (line: string) => {
    const segments: { text: string; bold: boolean }[] = [];
    const pattern = /\*\*(.*?)\*\*/g;
    let cursor = 0;
    let match;
    while ((match = pattern.exec(line)) !== null) {
      if (match.index > cursor) {
        segments.push({ text: line.slice(cursor, match.index), bold: false });
      }
      segments.push({ text: match[1], bold: true });
      cursor = pattern.lastIndex;
    }
    if (cursor < line.length) {
      segments.push({ text: line.slice(cursor), bold: false });
    }
    return segments;
  };

  const fontFor = (size: number, bold: boolean) =>
    bold ? `bold ${size}px ${baseFont}` : `${size}px ${baseFont}`;

  for (
    let size = textSpec.maxFontSize;
    size >= textSpec.minFontSize;
    size -= 1
  ) {
    const lineHeight = Math.ceil(size * 1.2);
    const lines: { text: string; bold: boolean }[][] = [];
    let fits = true;

    for (const explicitLine of String(text || "").split("\n")) {
      const wrapped: { text: string; bold: boolean }[][] = [[]];
      for (const segment of parseLine(explicitLine)) {
        const words = segment.text.match(/\s+|\S+/g) || [];
        for (const word of words) {
          const current = wrapped[wrapped.length - 1];
          const currentText = current.map((part) => part.text).join("");
          context.font = fontFor(size, segment.bold);
          const candidate = currentText + word;
          if (current.length > 0 && context.measureText(candidate).width > maxWidth && !/^\s+$/.test(word)) {
            wrapped.push([]);
          }
          wrapped[wrapped.length - 1].push({ text: word, bold: segment.bold });
        }
      }
      lines.push(...wrapped);
      if (lines.length * lineHeight > maxHeight) {
        fits = false;
        break;
      }
    }

    if (!fits) continue;

    context.fillStyle = colour;
    context.textAlign = "left";
    context.textBaseline = "top";
    lines.forEach((line, index) => {
      let cursorX = x;
      for (const segment of line) {
        context.font = fontFor(size, segment.bold);
        context.fillText(segment.text, cursorX, y + index * lineHeight);
        cursorX += context.measureText(segment.text).width;
      }
    });
    return true;
  }

  // Keep the description legible at the configured minimum size if it cannot
  // fit; callers can then spot and adjust the card layout for unusually long text.
  context.font = fontFor(textSpec.minFontSize, false);
  context.fillStyle = colour;
  context.textAlign = "left";
  context.textBaseline = "top";
  context.fillText(String(text || ""), x, y, maxWidth);
  return true;
};

export const drawCardCost = (
  loc: CardLocation,
  card: any,
  context,
  cards: CostSpec
) => {
  context.fillStyle = cards.colour;
  if (card.red > 0) {
    context.fillText(card.red, loc.x + cards.x1Offset, loc.y + cards.y1Offset);
  }
  if (card.green > 0) {
    context.fillText(
      card.green,
      loc.x + cards.x2Offset,
      loc.y + cards.y1Offset
    );
  }
  if (card.brown > 0) {
    context.fillText(
      card.brown,
      loc.x + cards.x2Offset,
      loc.y + cards.y2Offset
    );
  }
  if (card.blue > 0) {
    context.fillText(card.blue, loc.x + cards.x1Offset, loc.y + cards.y2Offset);
  }
  return true;
};
