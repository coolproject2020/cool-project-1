local teleports = {
	{ actionId = 3500, position = Position(32014, 31947, 13) }, -- summer next 
	{ actionId = 3501, position = Position(33695, 32190, 5) }, -- summer back
	{ actionId = 3502, position = Position(32066, 31951, 13) }, -- winter next {x = 32066, y = 31951, z = 13}
	{ actionId = 3503, position = Position(33688, 32112, 5) }, -- winter back {x = 33688, y = 32112, z = 5}
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
