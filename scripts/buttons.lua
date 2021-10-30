require("utilities")
require("customProperties")

TOGGLE_PROPERTY = 'toggle'
TOGGLE_LABEL_ON_PROPERTY = 'toggleLabelOn'
TOGGLE_LABEL_OFF_PROPERTY = 'toggleLabelOff'
TOGGLE_FUNC = 'setToggle'

function setToggle(guid)
    local button = safeGet(guid, false)
    local newState = not getCustomProperty(button, TOGGLE_PROPERTY)
    setCustomProperty(button, TOGGLE_PROPERTY, newState)
    updateButtonLabel(button, newState)
end

function updateButtonLabel(button, onOff)
    local property = ''
    if (onOff) then property = TOGGLE_LABEL_ON_PROPERTY
    else property = TOGGLE_LABEL_OFF_PROPERTY end
    local newLabel = getCustomProperty(button, property)
    button.editButton({index=0, label=newLabel})
end

function createToggle(guid, labelOn, labelOff, initialState, position, size, font_size)
    local state = initialState or false
    local label = ''
    _G[TOGGLE_FUNC .. guid] = function()
        setToggle(guid)
    end
    createButton(guid, label, TOGGLE_FUNC .. guid, position, size, font_size)
    local button = safeGet(guid, false)
    setCustomProperty(button, TOGGLE_PROPERTY, state)
    setCustomProperty(button, TOGGLE_LABEL_ON_PROPERTY, labelOn or 'On')
    setCustomProperty(button, TOGGLE_LABEL_OFF_PROPERTY, labelOff or 'Off')
    updateButtonLabel(button, state)
end

function createButton(guid, label, functionName, position, size, font_size)
    position = position or {0,0.2,0}
    size = size or 500
    but = safeGet(guid)
    but.createButton({
       click_function = functionName,
       function_owner = nil,
       label          = label,
       position       = position,
       rotation       = {0,0,0},
       width          = size,
       height         = size,
       font_size      = font_size or 200,
    })
end
