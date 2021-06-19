import { buildCards, getDeckSize, getLocations } from "./buildCards";
import {
  missionSpec,
  missionBaseImages,
  rewardSpec,
  techCardSpec,
  techPageSpec,
  titleSpec,
  typeSpec,
} from "./constants";
import { drawCardBase, drawCanvas, drawCardText } from "./drawCards";

const fs = require("fs");
const { loadImage, registerFont } = require("canvas");
const csv = require("csvtojson");

registerFont("./fonts/copperplate.ttf", { family: "Copperplate Gothic" });
registerFont("./fonts/corbel.ttf", { family: "Corbel" });

const loadAssets = async () => {
  return {
    baseImages: await Promise.all(
      missionBaseImages.map(async (image) => await loadImage(image))
    ),
    content: await csv().fromFile("./scripts/cards/missionContent.csv"),
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
  const drawType = (loc, card) =>
    drawCardText(loc, card.type, typeSpec, context);
  const drawDescription = (loc, card) =>
    drawCardText(loc, `Mission: ${card.mission}`, missionSpec, context);
  const drawReward = (loc, card) =>
    drawCardText(loc, `Reward: ${card.reward}`, rewardSpec, context);

  buildCards(locations, content, [
    drawBase,
    endIfHidden,
    drawTitle,
    drawType,
    drawDescription,
    drawReward,
  ]);

  const buffer = canvas.toBuffer("image/png");
  fs.writeFileSync("./assets/cards/missions.png", buffer);
});
