local config = {
	[23603] = {backPos = Position(33055, 31911, 9)}
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
