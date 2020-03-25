local config = {
	[23600] = {timer = Storage.Grimvale.BloodbackTimer, range = 8, newPos = Position(33181, 32012, 8), bossName = 'Bloodback', bossPos = Position(33185, 32015, 8)}
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleport = config[item.actionid]
	if not teleport then
		return
	end

	if player:getExhaustion(teleport.timer) > 0 then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('You have to wait to challange this enemy again!', TALKTYPE_MONSTER_SAY)
		return true
	end

	if roomIsOccupied(teleport.bossPos, teleport.range, teleport.range) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('Someone is fighting against the boss! You need wait awhile.', TALKTYPE_MONSTER_SAY)
		return true
	end
	clearRoom(teleport.bossPos, teleport.range, teleport.range, fromPosition)
	local monster = Game.createMonster(teleport.bossName, teleport.bossPos, true, true)
	if not monster then
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say('You have ten minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.', TALKTYPE_MONSTER_SAY)
	addEvent(clearBossRoom, 60 * 10 * 1000, player.uid, monster.uid, teleport.bossPos, teleport.range, teleport.range, fromPosition)
	player:setExhaustion(teleport.timer, 2 * 60 * 60)
	return true
end
