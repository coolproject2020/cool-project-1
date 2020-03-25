local config = {
	[23607] = {backPos = Position(33442, 32052, 9)}
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = config[item.actionid]
	if not teleport then
		return true
	end
	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(teleport.backPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
