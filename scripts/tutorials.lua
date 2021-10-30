
require("buttons")
require("labels")
require("customProperties")
require("automation")
require("tutorial1")
require("tutorial2")

TUTORIAL_SCENARIO_PROP = "tscenario"
tutorialCardGuid =  '3ec3b5'

tutorials =
{
    tutorial1,
    tutorial2
}

function selectPreviousScenario()
    card = safeGet(tutorialCardGuid)
    local index = getCustomProperty(card, TUTORIAL_SCENARIO_PROP) - 1
    if index > 0 then
        setLabel(tutorialCardGuid, tutorials[index].title)
        setCustomProperty(card, TUTORIAL_SCENARIO_PROP, index)
    end
end

function selectNextScenario()
    card = safeGet(tutorialCardGuid)
    local index = getCustomProperty(card, TUTORIAL_SCENARIO_PROP) + 1
    if index <= tablelength(tutorials) then
        setLabel(tutorialCardGuid, tutorials[index].title)
        setCustomProperty(card, TUTORIAL_SCENARIO_PROP, index)
    end
end

function startScenario()
    local index = getCustomProperty(card, TUTORIAL_SCENARIO_PROP)
    local result = runScript(tutorials[index], card)
    log(string.format("Script result: %s", result))
end

function continueScenario()
  local index = getCustomProperty(card, TUTORIAL_SCENARIO_PROP)
  local result = runSteps(tutorials[index].steps, card)
  log(string.format("Script result: %s", result))
end


function showHideTutorials(gameBox, show)
    local initialised = safeGet(tutorialCardGuid, false)
    if (show) then
      safePlace(gameBox, {
        guid = tutorialCardGuid,
        position = { x = -28.3385753631592, y = 3.62151598930359, z = -11.9862651824951 },
        rotation = { x = -2.37896801991155E-06, y = 179.999206542969, z = 0.000402836682042107 }
      })
    else
      safeStore({ tutorialCardGuid }, gameBox)
    end

    if show and initialised == nil then
      local size = 200
      local font_size = 40
      createToggle(tutorialCardGuid, '✔', '✘', true, {0.6, 0.2, 0.8}, 100, font_size)
      createButton(tutorialCardGuid, '|<', 'selectPreviousScenario', {-0.90, 0.2, -0.10}, size, font_size)
      createButton(tutorialCardGuid, 'Continue', 'continueScenario', {0.4, 0.2, 0.28}, size, font_size)
      createButton(tutorialCardGuid, 'Start', 'startScenario', {-0.3,0.2,0.28}, size, font_size)
      createButton(tutorialCardGuid, '>|', 'selectNextScenario', {0.92, 0.2, -0.10}, size, font_size)
      createLabel(tutorialCardGuid, '', {0.20, 0.2, -0.61})
      card = safeGet(tutorialCardGuid)
      setCustomProperty(card, TUTORIAL_SCENARIO_PROP, 0)
      selectNextScenario()
    end
end