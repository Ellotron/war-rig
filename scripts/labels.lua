
function notUsed()
end

function createLabel(guid, labelText, position, width, height, font_size)
    target = safeGet(guid)
    target.createInput({
        input_function = 'notUsed',
        function_owner = nil,
        value          = labelText,
        position       =  position,
        width          = width or 800,
        height         = height or 80,
        font_size      = font_size or 50,
        })
end

function setLabel(guid, labelText)
    target = safeGet(guid)
    target.editInput({value = labelText})
end