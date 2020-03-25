local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local function formulaValues(level, skill, attack, factor)
    local skillTotal = skill * attack
	local levelTotal = level / 5
    return -(((skillTotal * 0.02) + 4) + (levelTotal)), -(((skillTotal * 0.04) + 9) + (levelTotal))
	end

function onCastSpell(creature, var)
	if not creature:isPlayer() then return combat:execute(creature, var) end
    local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	local target = Creature(var.number)
	local dmg = weapon:hasAttribute("attack") and weapon:getAttribute("attack") or ItemType(weapon.itemid):getAttack()
	local tmpedmg = ItemType(weapon.itemid):getElementDamage()
	local edmg = (tmpedmg ~= nil and tmpedmg > 0) and tmpedmg or 0
	local skill = creature:getSkillFromId(weapon.itemid)
	local min, max = formulaValues(creature:getLevel(), skill, dmg+edmg, 1)
	creature:getPosition():sendDistanceEffect(target:getPosition(), weaponDistanceEffect[ItemType(weapon.itemid):getWeaponType()])
		if getConfigInfo("removeWeaponCharges") == true and weapon:hasAttribute("charges") then
	local charges = weapon:getAttribute("charges")
	if charges == 1 then
	weapon:remove(1)
	else
	weapon:setAttribute("charges", charges-1)
	end
	end
	local crit = 1 -- 1 for not crit, 2 for crit
	local dmgmultiplier = 1 -- this is for the elemental damage, the elemental damage will not crit (avoid duplicate crit effect) but will multiply the damage in case of calculated crit in script
	local critchance = creature:getEffectiveSkillLevel(SKILL_CRITICAL_HIT_CHANCE)
	if critchance > 0 and math.random(1, 100) <= critchance then
	crit = 2
	if dmg > 0 then
	dmgmultiplier = 1 + (creature:getEffectiveSkillLevel(SKILL_CRITICAL_HIT_DAMAGE)/100)
	end
	end
	if dmg > 0 then
	doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, math.min(0, (min * dmg / (edmg + dmg))), math.min(0, (max * dmg / (edmg+dmg))), CONST_ME_HITAREA, ORIGIN_SPELL, true, crit)
	end
	if edmg > 0 then
	doTargetCombatHealth(creature, target, ItemType(weapon.itemid):getElementType(), math.min(0, min * edmg * dmgmultiplier / (edmg + dmg)), math.min(0, max * edmg * dmgmultiplier / (edmg+dmg)), CONST_ME_HITAREA, ORIGIN_SPELL, false, (dmg > 0 and 1 or crit))
	end
	
	return true
end
