require("utilities")

SCRIPT_STATE_STEP = "CurrentStep"

STEP_TYPE_BREAK = "Break"
STEP_TYPE_MOVE = "Move"
STEP_TYPE_FUNC = "Func"
STEP_TYPE_TEXT = "Text"


-- Run an automation script
-- @param script object: { steps: [ { type: StepType, ... } ] }
-- @param state object: an object against which the script state can be stored
-- @return string any error that occurred
function runScript(script, state)
    if type(state) ~= "userdata" then
        return string.format('State must be an object: %s', type(state))
    end
    if script == nil or script.steps == nil or tablelength(script.steps) == 0 then
        return 'No script or steps provided'
    end
    MusicPlayer.setPlaylist({})
    setCustomProperty(state, SCRIPT_STATE_STEP, 1)
    return runSteps(script.steps, state)
end

-- Runs the provided steps from the point indictaed by state
-- @param steps array: Step all steps from the script
-- @param state object: with prop "CurrentStep" indicating starting step
-- @return string any error that occurred
function runSteps(steps, state)
    local index = getCustomProperty(state, SCRIPT_STATE_STEP)
    for i=index,tablelength(steps) do
        local step = steps[i]
        log(string.format("Step: %s", step.stepType))
        runStep(step, state)
        index = i + 1
        if step.stepType == STEP_TYPE_BREAK then break end
    end
    setCustomProperty(state, SCRIPT_STATE_STEP, index)
    return ''
end

-- Called by runSteps to run each step type:
-- > Move: take step.objects from the world or gameBox and place them obj: { guid: str, position: vec, rotation: vec, thenPlace: obj}.
-- > Func: run the gloablly defined function with the name step.funcName: str
function runStep(step, state)
    local stepType = step.stepType
    if stepType == STEP_TYPE_MOVE then
        forEach(step.objects, function(obj) safePlace(gameBox, obj) end)
    elseif stepType == STEP_TYPE_FUNC then
        _G[step.funcName]()
    elseif stepType == STEP_TYPE_TEXT then
        printText(step, 1, state)
    end
end

function printText(step, index, state)

    if (index == 1 and step.audio and getCustomProperty(state, TOGGLE_PROPERTY)) then
        local audio = {
            url = string.format("https://war-rig-borderlands.s3.eu-west-2.amazonaws.com/tutorial/%s.mp3", step.audio),
            title = step.audio
        }
        MusicPlayer.setCurrentAudioclip(audio)
        MusicPlayer.play()
    end
    if index <= tablelength(step.text) then
        broadcastToAll(step.text[index], {r=1, g=1, b=1})
        Wait.time(function() printText(step, index + 1) end, step.delaySeconds)
    end
end