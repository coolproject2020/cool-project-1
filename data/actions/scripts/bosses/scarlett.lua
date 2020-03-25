local config = {
	time = 1,
	requiredLevel = 100,  -- Level que pode usa o item ou a lavanca
	daily = true, -- nao mexe nisso
	centerDemonRoomPosition = Position(33396, 32652, 6), -- position que o player vai cai dentro da sala do boss
	playerPositions = {
		Position(33395, 32661, 6),  -- position de onde os player pode usa o Item ou lavanca
		Position(33395, 32662, 6),
		Position(33395, 32663, 6),
		Position(33396, 32662, 6),
		Position(33394, 32662, 6)
	},
	newPositions = {
		Position(33396, 32652, 6), -- Mesma position onde os player vai cai dentro da sala se for varios player em varios lugares é so coloca em cada uma position.
		Position(33396, 32652, 6),
		Position(33396, 32652, 6),
		Position(33396, 32652, 6)
	},
	soltoPosition = {
		Position(33395, 32671, 6) -- position onde o player vai quando acaba o tempo dele.
	},
	demonPositions = {
		Position(33219, 31657, 13) -- position do boss se quizer por mais de um boss é so adiciona Position(33219, 31657, 13), com a virgula
	}
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 36319 then  -- item que é usado para entra na area do boss
		local storePlayers, playerTile = {}

		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "wrong position.")
				return true
			end

			if playerTile:getLevel() < config.requiredLevel then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "All the players need to be level ".. config.requiredLevel .." or higher.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 9, 9, 9, 9)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Scarlett Etzel !")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.demonPositions do
			Game.createMonster("Scarlett Etzel", config.demonPositions[i])
		end

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			doRemoveItem(item.uid, 1)
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Scarlett Etzel!!")
		end
	elseif item.itemid == 36319 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 36319 and 36319 or 36319)
	return true
end