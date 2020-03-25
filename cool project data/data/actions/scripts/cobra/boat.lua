local config = {
    [57701] = Position(33385, 32627, 7),
    [57702] = Position(33314, 32647, 6),
}

function onUse(player, item, fromPosition, itemEx, toPosition)
    for actionId, destination in pairs(config) do
        if item.actionid == actionId then
            player:teleportTo(destination)
            destination:sendMagicEffect(CONST_ME_POFF)
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end
end
