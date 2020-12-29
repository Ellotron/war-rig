require("customProperties")
require("utilities")

function moveChassisToConstructionArea(chassis, includeY)
    if getCustomProperty(chassis, TYPE) ~= CHASSIS then
        log(chassis)
        log("Not a chassis")
        return
    end

    p = getCustomProperty(chassis, CHASSIS_1_CONSTRUCTION_P)
    if includeY or true then
        p.y = self.getPosition().y
    end
    r = getCustomProperty(chassis, CHASSIS_1_CONSTRUCTION_R)

    chassis.setPosition(p)
    chassis.setRotation(r)
end

function attachComponent(side)
    objs = Player["White"].getSelectedObjects()
    if tablelength(objs) ~= 2 then
        print("Exactly two objects must be selected")
        return
    end
    chassis = nil
    component = nil
    if getCustomProperty(objs[1], TYPE) == CHASSIS then
        chassis = objs[1]
        component = objs[2]
    end
    if getCustomProperty(objs[2], TYPE) == CHASSIS then
        chassis = objs[2]
        component = objs[1]
    end
    if chassis == nil then
        print("One object must be a chassis")
        return
    end
    if side == CHASSIS_LEFT_LEG or side == CHASSIS_RIGHT_LEG then
        if getCustomProperty(component, TYPE) ~= LEG_COMPONENT then
            print("One object must be a leg component")
            return
        end
    end

    if tablelength(component.getJoints()) ~= 0 then
        print('Component is already attached')
        return
    end
    if getCustomProperty(chassis, CHASSIS_SIDE_NUMBERS[side]) ~= nil then
        print('Side is already occupied')
        return
    end

    moveChassisToConstructionArea(chassis)
    chassis_off = getCustomProperty(chassis, CHASSIS_CONSTRUCTION_OFFSETS)
    component_off = getCustomProperty(component, CHASSIS_CONSTRUCTION_OFFSETS)
    chassis_p = chassis.getPosition()
    component_p = component.getPosition()

    if side == CHASSIS_LEFT_ARM then
        component_p.y = chassis_p.y
        component.setPosition(component_p)
        component_p.x = chassis_p.x + chassis_off[CCO_LEFT_ARM_X]
        component.setPosition(component_p)
    end
    if side == CHASSIS_RIGHT_ARM then
        component_p.y = chassis_p.y + 0.1
        component.setPosition(component_p)
        component_p.x = chassis_p.x + chassis_off[CCO_RIGHT_ARM_X]
        component.setPosition(component_p)
    end
    if side == CHASSIS_LEFT_LEG then
        chassis_p.y = component_p.y + component_off[CCO_LEG_Y]
        chassis.setPosition(chassis_p)
        component_p.x = chassis_p.x + chassis_off[CCO_LEFT_LEG_X]
        component.setPosition(component_p)
    end
    if side == CHASSIS_RIGHT_LEG then
        chassis_p.y = component_p.y + component_off[CCO_LEG_Y]
        chassis.setPosition(chassis_p)
        component_p.x = chassis_p.x + chassis_off[CCO_RIGHT_LEG_X]
        component.setPosition(component_p)
    end
    if side == CHASSIS_BODY then
        component_p.y = chassis_p.y
        component.setPosition(component_p)
        component_p.x = chassis_p.x
        component.setPosition(component_p)
        component_p.z = chassis_p.z + chassis_off[CCO_BODY_Z]
        component.setPosition(component_p)
    end
    if side == CHASSIS_HEAD then
        component_p.y = chassis_p.y + chassis_off[CCO_HEAD_Y]
        component.setPosition(component_p)
        component_p.z = chassis_p.z
        component_p.x = chassis_p.x
        component.setPosition(component_p)
    end

    component.jointTo(chassis, {
        ["type"]        = "Fixed",
        ["collision"]   = false,
        ["break_force"]  = 1000000000.0,
        ["break_torgue"] = 1000000000.0,
    })
    setCustomProperty(chassis, CHASSIS_SIDE_NUMBERS[side], component.getGUID())

    print('Joined to side ', side)
end

