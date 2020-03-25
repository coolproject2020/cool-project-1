local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Hello, how are you.'} }
npcHandler:addModule(VoiceModule:new(voices))


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I buy everything!. I love itens!"})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my shop  |PLAYERNAME|! I buy stuff, all kinds of stuff!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Thank you,  come again, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Thank you, come again")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())