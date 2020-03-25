local rewards = {
	--- None
	[0] = {
        [SKILL_LEVEL] = {
            {lvl = 100, items = {{2160, 10}}, storage = 54778},
        }
    },
    --- Sorcerer
    [1] = {
        [SKILL_LEVEL] = {
            {lvl = 13, items = {{2191, 1}}, storage = 54778},
			{lvl = 19, items = {{2188, 1}}, storage = 54779},
			{lvl = 26, items = {{2189, 1}}, storage = 54780},
			{lvl = 33, items = {{2187, 1}}, storage = 54781}
        }
    },
    --- Druid
    [2] = {
        [SKILL_LEVEL] = {
            {lvl = 13, items = {{2186, 1}}, storage = 54778},
			{lvl = 19, items = {{2185, 1}}, storage = 54779},
			{lvl = 26, items = {{2181, 1}}, storage = 54780},
			{lvl = 33, items = {{2183, 1}}, storage = 54781}
        }
    },
    --- Paladin
    [3] = {
        [SKILL_DISTANCE] = {
            {lvl = 20, items = {{7438, 1}}, storage = 54776},
        }
    },
    --- Knight
    [4] = {
        [SKILL_SWORD] = {
            {lvl = 15, items = {{7385, 1}}, storage = 54776},
            {lvl = 40, items = {{2407, 1}}, storage = 54777}
        },
        [SKILL_CLUB] = {
            {lvl = 15, items = {{2423, 1}}, storage = 54776},
            {lvl = 40, items = {{7430, 1}}, storage = 54777}
        },
        [SKILL_AXE] = {
            {lvl = 15, items = {{2430, 1}}, storage = 54776},
            {lvl = 40, items = {{7456, 1}}, storage = 54777}
        }
    }
}

function onAdvance(player, skill, oldlevel, newlevel)
    local rewardstr = "Items received: "
    local reward_t = {}
    local voc = player:getVocation():getBase():getId()
    if rewards[voc][skill] then
        for j = 1, #rewards[voc][skill] do
            local r = rewards[voc][skill][j]
            if not r then
                return true
            end

            if newlevel >= r.lvl then
                if player:getStorageValue(r.storage) < 1 then
                    player:setStorageValue(r.storage, 1)
                    for i = 1, #r.items do
                        local itt = ItemType(r.items[i][1])
                        if itt then
                            player:addItem(r.items[i][1], r.items[i][2])
                            table.insert(reward_t, itt:getName() .. (r.items[i][2] > 1 and " x" .. r.items[i][2] or ""))
                        end
                    end
                end
            end
        end
   
        if #reward_t > 0 then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, rewardstr .. table.concat(reward_t, ", "))
        end
    end
    return true
end

function onLogin(player)
    player:registerEvent("onadvance_reward")
    return true
end