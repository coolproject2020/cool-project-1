 local combat = Combat()
 combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
 combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 58)
 combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
 combat:setFormula(COMBAT_FORMULA_SKILL, 5, 5, 1.5, 5)
 function onUseWeapon(player, variant)
 	return combat:execute(player, variant)
 end