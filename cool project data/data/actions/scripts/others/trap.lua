function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(item.itemid - 1)
	fromPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end
