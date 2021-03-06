import {
  buildCards,
  getDeckSize,
  getLocations,
  getTypeDeckContent,
} from "./buildCards";
import {
  missionSpec,
  missionBaseImages,
  rewardSpec,
  techCardSpec,
  techPageSpec,
  titleSpec,
  typeSpec,
  missionCardImages,
  imageSpec,
  flavourSpec,
} from "./constants";
import {
  drawCardBase,
  drawCanvas,
  drawCardText,
  drawCardImage,
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
      missionBaseImages.map(async (image) => await loadImage(image))
    ),
    cardImages: await Promise.all(
      missionCardImages.map(async (image) => await loadImage(image))
    ),
    content: await csv().fromFile("./scripts/cards/missionContent.csv"),
  };
};

const buildMissions = (outputName: string, content: any[], assets: any) => {
  const totalCards = getDeckSize(content);
  console.log("Deck size:", totalCards);

  const { context, canvas } = drawCanvas(techPageSpec);
  const locations = getLocations(techCardSpec, totalCards);

  const drawBase = (loc, card) =>
    drawCardBase(loc, card, context, assets, techCardSpec);
  const endIfHidden = (_, card) => card.title !== "hidden";
  const drawTitle = (loc, card) =>
    drawCardText(loc, card.title, titleSpec, context);
  const drawImage = (loc, card) =>
    drawCardImage(loc, card.image, imageSpec, context, assets);
  const drawType = (loc, card) =>
    drawCardText(loc, card.type, typeSpec, context);
  const drawDescription = (loc, card) =>
    drawCardText(loc, `Mission: ${card.mission}`, missionSpec, context);
  const drawReward = (loc, card) =>
    drawCardText(loc, `Reward: ${card.reward}`, rewardSpec, context);
  const drawFlavour = (loc, card) =>
    drawCardText(loc, card.flavour, flavourSpec, context);

  buildCards(locations, content, [
    drawBase,
    endIfHidden,
    drawTitle,
    drawImage,
    drawType,
    drawDescription,
    drawReward,
    drawFlavour,
  ]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync(`./assets/cards/${outputName}.png`, buffer);
};

loadAssets().then((assets) => {
  const content = assets.content;
  buildMissions("missions1", getTypeDeckContent("Level 1", content), assets);
  buildMissions("missions2", getTypeDeckContent("Level 2", content), assets);
  buildMissions("missions3", getTypeDeckContent("Level 3", content), assets);
});
