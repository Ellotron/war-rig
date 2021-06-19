import { getDeckSize, getLocations } from "./buildCards";

describe("getDeckSize", () => {
  it("should count card repetitions", () => {
    expect(getDeckSize([{ count: "3" }, { count: "2" }, { count: "1" }])).toBe(
      6
    );
  });
});

const cards = {
  perRow: 4,
  width: 40,
  height: 50,
  hGap: 2,
  vGap: 1,
};

const oneRow = [
  { x: 0, y: 0 },
  { x: 42, y: 0 },
  { x: 84, y: 0 },
  { x: 126, y: 0 },
];

const onePointFiveRows = oneRow.concat([
  { x: 0, y: 51 },
  { x: 42, y: 51 },
]);

const twoRows = onePointFiveRows.concat([
  { x: 84, y: 51 },
  { x: 126, y: 51 },
]);

describe("getLocations", () => {
  it.each`
    scenario             | cardSizing | totalCards | expectedLocations
    ${"handle 1 row"}    | ${cards}   | ${4}       | ${oneRow}
    ${"handle 1.5 rows"} | ${cards}   | ${6}       | ${onePointFiveRows}
    ${"handle 2 rows"}   | ${cards}   | ${8}       | ${twoRows}
  `("should $scenario", ({ cardSizing, totalCards, expectedLocations }) => {
    expect(getLocations(cardSizing, totalCards)).toStrictEqual(
      expectedLocations
    );
  });
});
