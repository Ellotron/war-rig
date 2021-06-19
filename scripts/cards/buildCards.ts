export const getDeckSize = (cardContent: CardContent[]) =>
  cardContent.map((x) => parseInt(x.count)).reduce((a, c) => a + c);

export const getLocations = (
  cardSpec: CardSpec,
  totalCards: number
): CardLocation[] => {
  const locations = [];
  var x = 0;
  var y = 0;
  for (var i = 1; i <= totalCards; i++) {
    locations.push({ x, y });
    x += cardSpec.width + cardSpec.hGap;
    if (i > 0 && i % cardSpec.perRow == 0) {
      x = 0;
      y += cardSpec.height + cardSpec.vGap;
    }
  }
  return locations;
};

export const getTypeDeckContent = (type: string, content: any[]) => {
  return content
    .filter((c) => c.type.includes(type))
    .concat([{ title: "hidden", count: 1, base: 0 }]);
};

export const buildCards = (
  cardLocations: CardLocation[],
  cardContent: CardContent[],
  buildSteps: ((location: CardLocation, content: CardContent) => boolean)[]
) => {
  var i = -1;
  var count = 0;
  cardLocations.forEach((loc) => {
    if (count === 0) {
      i++;
      count = parseInt(cardContent[i].count);
    }
    for (var f = 0; f < buildSteps.length; f++) {
      if (!buildSteps[f](loc, cardContent[i])) break;
    }
    count--;
  });
};
