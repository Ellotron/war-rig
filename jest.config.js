module.exports = {
  automock: false,
  transform: {
    "^.+\\.ts?$": "ts-jest",
  },
  preset: "ts-jest",
  transformIgnorePatterns: ["/node_modules/"],
  testMatch: ["**/**/*test.ts"],
};
