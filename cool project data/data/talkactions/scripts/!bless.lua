function onSay(cid)

	local player = Player(cid)
	local totalBlessPrice = getBlessingsCost(player:getLevel()) * 5 * 0.7
	
	if player:getBlessings() == 6 then
				player:sendCancelMessage("You already have been blessed!", cid)
			elseif player:removeMoney(totalBlessPrice) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by all of eight gods!")
				for b = 1, 6 do
					player:addBlessing(b, 1)
				end
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
				
			else
				player:sendCancelMessage("You don't have enough money. You need " .. totalBlessPrice .. " to buy bless.", cid)
			end
end