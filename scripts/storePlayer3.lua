function p3Store(gameBox)
    p3StoreHomeBase(gameBox)
    p3StoreHand(gameBox)
    p3StoreLesserFaction(gameBox)
end

function p3StoreLesserFaction(gameBox)
 local lesserFactions = {
    'b47d7b',
    '9b7430',
    '2ef8b3',
 }
 safeStore(lesserFactions, gameBox)
end

function p3StoreHomeBase(gameBox)
 local homeBaseObjects = {
  '967acb',
  'b68a22',
  'f7b016',
  '2bf815',
  '1de2c1',
  '2ae2c2',
  'a68c23'
 }
 safeStore(homeBaseObjects, gameBox)
end

function p3StoreHand(gameBox)
 local handObjects = {
  '64b8c8',
  'addd48',
  'c2e401',
  '66275f',
  '97d47b',
  '614a3c',
  '3a6fdd',
}
safeStore(handObjects, gameBox)
end