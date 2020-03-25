local t = {
    39001, {
    [20] = {2157, 100, "Congratulations, you have achieved one of seven goals! You have been awarded with 100 Golden Nuggets!", 1},
    [30] = {9971, 50, "Congratulations, you have achieved two of seven goals! You have been awarded with 50 Golden Ingots!", 2},
    [40] = {2358, 1, "Congratulations, you have achieved three of seven goals! You have been awarded with Rich Boots!", 3},
    [50] = {8976, 1, "Congratulations, you have achieved four of seven goals! You have been awarded with a Lottery Bird!", 4},
    [60] = {9970, 20, "Congratulations, you have achieved five of seven goals! You have been awarded with Buffary Coins!", 5},
    [70] = {5785, 1, "Congratulations, you have achieved six seven goals! You have been awarded with a V.I.P Medal!", 6},
    [80] = {9970, 50, "Congratulations, you have achieved  all seven goals! You have been awarded with Buffary Coins!", 7}
    }
}
function onAdvance(cid, skill, oldlevel, newlevel)
    if skill == SKILL__LEVEL then
        for level, v in pairs(t[2]) do
            if oldlevel < level and getPlayerLevel(cid) >= level and setPlayerStorageValue(cid, t[1], v[7]) then
                doPlayerAddItem(cid, v[1], v[2])
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, v[3])
                setPlayerStorageValue(cid, t[1], v[7])
            end
        end
    end
    doPlayerSave(cid, true)
    return true
end