local t = {
players = { -- posições que os players devem ficar ao puxar a alavanca
[1] = Position(33395,32661,6),
[2] = Position(33394,32662,6),
[3] = Position(33395,32662,6),
[4] = Position(33395,32663,6),
[5] = Position(33396,32662,6)
},

boss = {name = "Scarlett Etzel", create_pos = Position(33396,32642,6)},

destination = Position(33395,32656,6), -- posição para qual os players serão teleportados

cooldown = {0, "sec"}, -- tempo para ser teleportado novamente. Ex.: {2, "sec"}, {5, "min"}, {10, "hour"}, {3, "day"}

storage = 56482 -- storage não utilizado no seu servidor
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local players, tab = {}, t.players
for i = 1, #tab do
local tile = Tile(tab)
if tile then
local p = Player(tile:getTopCreature())
if p then
if p:getStorageValue(t.storage) <= os.time() then
players[#players + 1] = p:getId()
end
end
end
end
if #players == 0 then
player:sendCancelMessage("One or all players did not wait " .. getStrTime(t.cooldown) .. " to go again.")
return true
end
for i = 1, #tab do
local playerTile = Tile(tab)
local playerToGo = Player(playerTile:getTopCreature())
if playerToGo then
if isInArray(players, playerToGo:getId()) then
playerToGo:setStorageValue(t.storage, mathtime(t.cooldown) + os.time())
playerTile:relocateTo(t.destination)
tab:sendMagicEffect(CONST_ME_POFF)
end
end
end
t.destination:sendMagicEffect(CONST_ME_TELEPORT)
Game.createMonster(t.boss.name, t.boss.create_pos)
item:transform(item.itemid == 36319 or 1946 or 1945)
return true
end

local boss_room = {fromPos = Position(33386, 32639, 6), toPos = Position(33405, 32659, 6)}
local bossplayer = Player(cid)
local exit = Position(33395, 32659, 6)

if bossplayer and isInRange(bossplayer:getPosition(), boss_room.fromPos, boss_room.toPos) then
   bossplayer:teleportTo(exit)
        end

function mathtime(table) -- by dwarfer
local unit = {"sec", "min", "hour", "day"}
for i, v in pairs(unit) do
if v == table[2] then
return table[1](60^(v == unit[4] and 2 or i-1))(v == unit[4] and 24 or 1)
end
end
return error("Bad declaration in mathtime function.")
end

function getStrTime(table) -- by dwarfer
local unit = {["sec"] = "second",["min"] = "minute",["hour"] = "hour",["day"] = "day"}
return tostring(table[1].." "..unit[table[2]]..(table[1] > 1 and "s" or ""))
end