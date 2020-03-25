local teleports = {
	{ actionId = 3504, position = Position(32014, 31947, 13) }, -- dream scar
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

    for _, tps in pairs(teleports) do
        if item.actionid == tps.actionId then
            player:teleportTo(tps.position)
        end
    end

end
