aura_env.addIfTank = function(unit, tankTable)
    local role = UnitGroupRolesAssigned(unit)

    if role == 'TANK' and UnitExists(unit) then table.insert(tankTable, unit) end

    return tankTable
end

aura_env.getTanks = function()
    local tanks = {}
    local groupType = IsInRaid() and "raid" or "party"

    for i = 1, GetNumGroupMembers() do
        local unitId = groupType .. i

        tanks = aura_env.addIfTank(unitId, tanks)
    end

    if (groupType == "party") then
        -- The player is not included in "party"
        tanks = aura_env.addIfTank("player", tanks)
    end

    return tanks
end

aura_env.SetTankMarkers = function()
    local tanks = aura_env.getTanks()

    for i, tank in pairs(tanks) do
        local configKey = "tankMarker" .. i
        local markerNumber = aura_env.config[configKey]

        SetRaidTarget(tank, markerNumber)
    end
end
