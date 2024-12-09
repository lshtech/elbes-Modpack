--- STEAMODDED HEADER
--- MOD_NAME: TOGA's Stuff
--- MOD_ID: TOGAPack
--- MOD_AUTHOR: [TheOneGoofAli]
--- MOD_DESCRIPTION: Personal timewaster project.
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d, Talisman>=2.0.0-beta9]
--- BADGE_COLOR: fd9712
--- PREFIX: toga
--- VERSION: 0.98.2-ConsumerPreviewHotfix2
----------------------------------------------
------------MOD CODE -------------------------

sendDebugMessage("Hello World! Starting TOGAPack...")

-- Define thy map.
SMODS.Atlas{key = "TOGAJokersMain", path = "togajokers.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersOther", path = "togajokersother.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersWindows", path = "togajokerswinos.png", px = 72, py = 95}
SMODS.Atlas({key = "modicon", path = "togaicon.png", px = 32, py = 32}):register()

-- Hear me scream! Microsoft Access 97 Sound.wav
SMODS.Sound({key = "win95start", path = "win95start.ogg"}) -- The Microsoft Sound (95 & NT4)
SMODS.Sound({key = "win95tada", path = "win95tada.ogg"}) -- tada.wav (3.x, 95 & NT4)
SMODS.Sound({key = "win98start", path = "win98start.ogg"}) -- The Microsoft Sound (98) [edited]
SMODS.Sound({key = "win98tada", path = "win98tada.ogg"}) -- tada.wav (98, ME, 2000 and XP)
SMODS.Sound({key = "winmestart", path = "winmestart.ogg"}) -- Windows Logon Sound for ME/2000 [edited]
SMODS.Sound({key = "winmeshutdown", path = "winmeshutdown.ogg"}) -- Windows Logoff Sound for ME/2000 [edited]
SMODS.Sound({key = "winnt4start", path = "winnt4start.ogg"}) -- Windows Logon Sound for NT4 [edited]
SMODS.Sound({key = "winnt4shutdown", path = "winnt4shutdown.ogg"}) -- Windows Logoff Sound for NT4 [edited]
SMODS.Sound({key = "ssb64crowdohh", path = "Crowd Ohhh.ogg"}) -- Crowd Ohhh from Super Smash Bros 64
SMODS.Sound({key = "duck", path = "duck.ogg"}) -- Mac OS 9 Quack
SMODS.Sound({key = "kcud", path = "kcud.ogg"}) -- kcauQ 9 SO caM
SMODS.Sound({key = "ie31", path = "1.wav"}) -- Internet Explorer 3 Administration Kit Autorun
SMODS.Sound({key = "access97", path = "Microsoft Access 97 Sound.wav"}) -- Microsoft Access 97

-- I command you to execute.
SMODS.Sound({key = "win95pluscmd1", path = "plus95/Dangerous Creatures menu command.ogg"})
SMODS.Sound({key = "win95pluscmd2", path = "plus95/Inside your Computer menu command.ogg"})
SMODS.Sound({key = "win95pluscmd3", path = "plus95/Jungle menu command.ogg"})
SMODS.Sound({key = "win95pluscmd4", path = "plus95/Leonardo da Vinci menu command.ogg"})
SMODS.Sound({key = "win95pluscmd5", path = "plus95/Mystery menu command.ogg"})
SMODS.Sound({key = "win95pluscmd6", path = "plus95/Nature menu command.ogg"})
SMODS.Sound({key = "win95pluscmd7", path = "plus95/Science menu command.ogg"})
SMODS.Sound({key = "win95pluscmd8", path = "plus95/Space menu command.ogg"})
SMODS.Sound({key = "win95pluscmd9", path = "plus95/Sports menu command.ogg"})
SMODS.Sound({key = "win95pluscmd10", path = "plus95/The 60's USA menu command.ogg"})
SMODS.Sound({key = "win95pluscmd11", path = "plus95/The Golden Era menu command.ogg"})
SMODS.Sound({key = "win95pluscmd12", path = "plus95/Windows 95 menu command.ogg"})

-- I think, therefore, I am.
togabalatro = SMODS.current_mod
togabalatro.config_tab = function() -- didn't expect it to be THIS convoluted... but other mods sure were going this route.
	return {n = G.UIT.ROOT, config = {r = 0.1, align = "cm", padding = 0.1, colour = G.C.BLACK, minw = 7, minh = 2}, nodes = {
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenAdding" },
			}},
			{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
				{ n = G.UIT.T, config = { text = "SFX when getting Windows (OS) Jokers", scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenRemoving" },
			}},
			{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
				{ n = G.UIT.T, config = { text = "SFX when removing Windows (OS) Jokers", scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenTriggered" },
			}},
			{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
				{ n = G.UIT.T, config = { text = "SFX when some Jokers from this mod are triggered", scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}}
	}}
end

-- Count steel card amount in full deck and round up the returned result.
local function toga_gettotalsteelcount()
	local allsteel = 0
	if G.playing_cards then
		for k, v in pairs(G.playing_cards) do
			if v.config.center == G.P_CENTERS.m_steel then allsteel = allsteel+1 end
		end
	end
	return math.floor(allsteel/4)
end

-- Update variable for Iron Will.
local function toga_updatesteelrepeat(target)
	return toga_gettotalsteelcount()*target.ability.extra.repetitions
end

-- Check for 2 and King.
local function toga_y2kcheck(context)
	local twopresent = 0
	local kingpresent = 0
	for i = 1, #context.full_hand do
		if SMODS.Ranks[context.full_hand[i].base.value].key == "2" then
			twopresent = twopresent+1
		end
		if SMODS.Ranks[context.full_hand[i].base.value].key == "King" then
			kingpresent = twopresent+1
		end
	end
	return twopresent, kingpresent
end

SMODS.Joker{
	key = 'y2kbug',
	loc_txt = {
		name = 'Y2K Bug',
		text = {
		"If the played hand contains a",
		"{C:attention}2{} and a {C:attention}King{},",
		"each scoring card gives",
		"{C:chips}+#1#{} Chips and {C:red}+#2#{} Mult",
		"{C:inactive,s:0.8}Have you updated your system yet?{}"
		}
	},
	config = { extra = { chips = 16, mult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 0 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local twos, kings = toga_y2kcheck(context)
			if twos > 0 and kings > 0 then
				return {chips = card.ability.extra.chips, mult = card.ability.extra.mult, card = context.other_card}
			end
		end
	end
}

SMODS.Joker{
	key = 'controlpanel',
	loc_txt = {
		name = 'Control Panel',
		text = {
		"Gain {C:money}$#1#{} for every Joker slot",
		"at end of round. Ante 2 and onwards",
		"grant {C:money}bonus money{} per slot based",
		"on {C:attention}#2#%{} of the value of the {C:attention}current Ante{}.",
		--"If the {C:attention}current Ante{} is {C:attention}2{} or higher,",
		--"increase the amount by {C:attention}#2#%{} of current Ante.",
		"{s:0.9}Total amount is rounded up.{}",
		"{C:inactive,s:0.8}(Currently {}{C:money,s:0.8}$#3#{}{C:inactive,s:0.8}){}",
		"{C:inactive,s:0.8}Look at all them settings!{}"
		}
	},
	config = { extra = { money = 1, antemult = 0.2, totalmoney = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.antemult*100, card.ability.extra.totalmoney } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 1 },
	cost = 7,
	blueprint_compat = true,
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.money > 0 then
			local antebonus = 0
			if G.GAME.round_resets.ante > 1 then antebonus = G.GAME.round_resets.ante*card.ability.extra.antemult end
			local slotbonus = 0
			if G.jokers then slotbonus = card.ability.extra.money*G.jokers.config.card_limit end
			card.ability.extra.totalmoney = math.ceil(slotbonus+(slotbonus*antebonus))
			return card.ability.extra.totalmoney
		end
	end,
	update = function(self, card)
		if card.ability.extra.money > 0 then
			local antebonus = 0
			if G.GAME.round_resets.ante > 1 then antebonus = G.GAME.round_resets.ante*card.ability.extra.antemult end
			local slotbonus = 5
			if G.jokers then slotbonus = card.ability.extra.money*G.jokers.config.card_limit end
			card.ability.extra.totalmoney = math.ceil(slotbonus+(slotbonus*antebonus))
		end
	end
}

SMODS.Joker{
	key = 'ironwill',
	loc_txt = {
		name = 'Iron Will',
		text = {
		"Retrigger a scoring card",
		"#1# time(s) per {C:attention}4 Steel Cards{}",
		"in your {C:important}full deck{}.",
		"{C:inactive,s:0.8}(Currently #2#){}"
		}
	},
	config = { extra = { repetitions = 1, totalrepetitions = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, toga_updatesteelrepeat(card) } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 0 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.totalrepetitions = card.ability.extra.repetitions*toga_gettotalsteelcount() or 0
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			return {
				message = 'One more!',
				repetitions = card.ability.extra.totalrepetitions,
				card = context.other_card
			}
		end
	end,
	update = function(self, card)
		card.ability.extra.totalrepetitions = card.ability.extra.repetitions*toga_gettotalsteelcount() or 0
	end
}

local function toga_multaverage(card)
	card.ability.extra.baseXmult = math.max(card.ability.extra.baseXmult, 1)
	local averagecalc = (G.GAME.current_round.hands_left + G.GAME.current_round.discards_left)/2
	return math.max(card.ability.extra.baseXmult * averagecalc, card.ability.extra.baseXmult, 1)
end

SMODS.Joker{
	key = 'taskmgr',
	loc_txt = {
		name = 'Task Manager',
		text = {
			"Gives {X:mult,C:white}XMult{} based on",
			"calculated average of current",
			"{C:chips}hands{} and {C:red}discards{} left.",
			"{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{}{C:inactive,s:0.8}){}",
		}
	},
	config = { extra = { baseXmult = 1, totalXmult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.totalXmult} }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.totalXmult = toga_multaverage(card)
			if card.ability.extra.totalXmult > 1 then
				return {
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.totalXmult } }),
					Xmult_mod = card.ability.extra.totalXmult,
					colour = G.C.MULT
				}
			end
		end
	end,
	update = function(self, card, context)
		card.ability.extra.totalXmult = toga_multaverage(card)
	end
}

-- Random text.
local function toga_randomruntext()
	local stringtable = { 'Run!', 'Again!', 'Again?', 'One more!', 'Another one!', 'Thread!' }
	return stringtable[math.random(#stringtable)]
end

-- Talisman used here for multiplication of chips.
SMODS.Joker{
	key = 'jimbo95',
	loc_txt = {
		name = 'Start Menu',
		text = {
		"{C:attention}+#1#{} hand size",
		"Retrigger all Jokers #2# time(s).",
		"{X:chips,C:white} X#3# {} Chips, {X:mult,C:white} X#4# {} Mult",
		"{C:inactive,s:0.8}Start Me Up.{}"
		}
	},
	config = { extra = { h_size = 2, retriggers = 1, x_chips = 1.25, x_mult = 1.25} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_size, card.ability.extra.retriggers, card.ability.extra.x_chips, card.ability.extra.x_mult } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 4, y = 0 },
	cost = 20,
	blueprint_compat = true,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.extra.x_chips < 1 then card.ability.extra.x_chips = math.ceil(card.ability.extra.x_chips) end -- no reduce.
			if card.ability.extra.x_mult < 1 then card.ability.extra.x_mult = math.ceil(card.ability.extra.x_mult) end -- only extend.
			
			if card.ability.extra.x_mult > 1 then -- do if there's actually a mattering multiplier.
				SMODS.eval_this(card, {
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
					Xmult_mod = card.ability.extra.x_mult,
					colour = G.C.MULT
				})
			end
			if card.ability.extra.x_chips > 1 then -- do if there's actually a mattering multiplier.
				return {
					message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.x_chips } }),
					Xchip_mod = card.ability.extra.x_chips,
					colour = G.C.CHIPS
				}
			end
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			if card.ability.extra.retriggers < 1 then card.ability.extra.retriggers = 1 end -- always at least once.
			return {
				message = toga_randomruntext(),
				repetitions = card.ability.extra.retriggers,
				card = card,
			}
		end
	end,
	update = function(self, card)
		if card.ability.extra.x_chips < 1 then card.ability.extra.x_chips = math.ceil(card.ability.extra.x_chips) end -- no reduce.
		if card.ability.extra.x_mult < 1 then card.ability.extra.x_mult = math.ceil(card.ability.extra.x_mult) end -- only extend.
		if card.ability.extra.retriggers < 1 then card.ability.extra.retriggers = 1 end -- always at least once.
	end
}

SMODS.Joker{
	key = 'solitairejoker',
	loc_txt = {
		name = 'Solitaire Joker',
		text = {
			"{C:attention}+#1#{} hand size",
			"{C:chips}+#2#{} Chips",
			"Lose {C:chips}#3#{} hand(s)",
			"at start of round.",
			"{C:inactive,s:0.8}An Office regular.{}"
		}
	},
	config = { extra = { h_size = 3, chips = 100, hands = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_size, card.ability.extra.chips, card.ability.extra.hands } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 0 },
	cost = 8,
	blueprint_compat = true,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced and not context.blueprint then
			ease_hands_played(-card.ability.extra.hands)
		end
		
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips
			}
		end
	end
}

-- Random SFX.
local function toga_plus95rndsfx()
	return 'toga_win95pluscmd'..math.random(1, 12)
end

SMODS.Joker{
	key = 'drivespace',
	loc_txt = {
		name = 'DriveSpace',
		text = {
			"{X:attention,C:white}X#1#{} Blind requirement",
			"when a card {C:attention}scores{}."
		}
	},
	config = { extra = { reduce = 0.99 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.reduce } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 1 },
	cost = 20,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.cardarea == G.play then
			if context.other_card and not context.before and not context.after and not context.repetition and not context.repetition_only and not context.blueprint then
				-- card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Compress!', colour = G.C.FILTER})
				G.E_MANAGER:add_event(Event({func = function()
					G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.reduce)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
					G.HUD_blind:recalculate() 
					G.hand_text_area.blind_chips:juice_up()
					card:juice_up()
	
					if not silent and togabalatro.config.SFXWhenTriggered then play_sound(toga_plus95rndsfx()) end
				return true end }))
			end
		end
	end
}

SMODS.Joker{
	key = 'win95',
	loc_txt = {
		name = 'Windows 95',
		text = {
			"{C:chips}+#1#{} hand(s) & {C:red}+#2#{} discard(s)",
			"upon selecting a {C:attention}Blind{}.",
			"Earn {C:money}$#3#{} at end of round.",
			"If there are #5# or fewer",
			"Jokers, get {X:money,C:white} X#4# {} the amount."
		}
	},
	config = { extra = { hands = 1, discards = 1, money = 4, Xmoney = 2, slots = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.discards, card.ability.extra.money, card.ability.extra.Xmoney, card.ability.extra.slots } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 0 },
	cost = 8,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced and not context.blueprint then
			ease_hands_played(card.ability.extra.hands)
			ease_discard(card.ability.extra.discards)
		end
	end,
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.money > 0 then
			if #G.jokers.cards <= card.ability.extra.slots then
				return card.ability.extra.money * card.ability.extra.Xmoney
			else
				return card.ability.extra.money
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_win95start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_win95tada")
		end
	end
}

SMODS.Joker{
	key = 'win98',
	loc_txt = {
		name = 'Windows 98',
		text = {
			"{C:chips}+#1#{} Chips & {C:red}+#2#{} Mult",
			"for each {C:attention}Consumable{} held. {C:dark_edition}Negative{}",
			"ones give only half as much.",
			"{C:inactive,s:0.8}(Currently {}{C:chips,s:0.8}+#3#{}{C:inactive,s:0.8} & {}{C:red,s:0.8}+#4#{}{C:inactive,s:0.8}){}"
		}
	},
	config = { extra = { chips = 24, mult = 3, totalchips = 0, totalmult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.totalchips, card.ability.extra.totalmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 0 },
	cost = 7,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.totalchips = 0
			card.ability.extra.totalmult = 0
			
			if G.consumeables then
				for i, v in pairs (G.consumeables.cards) do
					local pluschip, plusmult = 0, 0
					if G.consumeables.cards[i].edition and G.consumeables.cards[i].edition.negative == true then
						pluschip = card.ability.extra.chips/2
						plusmult = card.ability.extra.mult/2
					else
						pluschip = card.ability.extra.chips
						plusmult = card.ability.extra.mult
					end
					card.ability.extra.totalchips = card.ability.extra.totalchips+pluschip
					card.ability.extra.totalmult = card.ability.extra.totalmult+plusmult
				end
			end
			
			if card.ability.extra.chips > 0 and card.ability.extra.totalchips > 0 then
				SMODS.eval_this(card, {message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.totalchips } }), chip_mod = card.ability.extra.totalchips})
			end
			if card.ability.extra.mult > 0 and card.ability.extra.totalmult > 0 then
				SMODS.eval_this(card, {message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.totalmult } }), mult_mod = card.ability.extra.totalmult})
			end
		end
	end,
	update = function(self, card, context)
		card.ability.extra.totalchips = 0
		card.ability.extra.totalmult = 0
			
		if G.consumeables then
			for i, v in pairs (G.consumeables.cards) do
				local pluschip, plusmult = 0, 0
				if G.consumeables.cards[i].edition and G.consumeables.cards[i].edition.negative == true then
					pluschip = card.ability.extra.chips/2
					plusmult = card.ability.extra.mult/2
				else
					pluschip = card.ability.extra.chips
					plusmult = card.ability.extra.mult
				end
				card.ability.extra.totalchips = card.ability.extra.totalchips+pluschip
				card.ability.extra.totalmult = card.ability.extra.totalmult+plusmult
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_win98start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_win98tada")
		end
	end
}

SMODS.Joker{
	key = 'winmillenium',
	loc_txt = {
		name = 'Windows ME',
		text = {
			"Each {C:attention}Joker{} held adds {C:chips}+#1#{} Chips",
			"to this Joker. Increase",
			"{C:attention}individual{} Joker bonus by {C:chips}+#2#{}",
			"for every {C:attention}Voucher{} purchased.",
			"{C:inactive,s:0.8}(Currently {}{C:chips,s:0.8}+#3#{}{C:inactive,s:0.8} per Joker, total: {}{C:chips,s:0.8}+#4#{}{C:inactive,s:0.8}){}"
		}
	},
	config = { extra = { chips = 15, chipbonus = 15, totalbonus = 15, totalchips = 15 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chipbonus, card.ability.extra.totalbonus, card.ability.extra.totalchips } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 1 },
	cost = 7,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			local vouchercount = 0
			for i, v in pairs(G.GAME.used_vouchers) do
				if v == true then vouchercount = vouchercount + 1 end
			end
			card.ability.extra.totalbonus = card.ability.extra.chips + card.ability.extra.chips*vouchercount
			card.ability.extra.totalchips = (card.ability.extra.chips*#G.jokers.cards) + (card.ability.extra.chips*vouchercount*#G.jokers.cards)
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.totalchips } }),
				chip_mod = card.ability.extra.totalchips
			}
		end
	end,
	update = function(self, card, context)
		if G.GAME and G.jokers then
			local vouchercount = 0
			for i, v in pairs(G.GAME.used_vouchers) do
				if v == true then vouchercount = vouchercount + 1 end
			end
			card.ability.extra.totalbonus = card.ability.extra.chips + card.ability.extra.chips*vouchercount
			card.ability.extra.totalchips = (card.ability.extra.chips*#G.jokers.cards) + (card.ability.extra.chips*#G.jokers.cards*vouchercount)
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winmestart")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winmeshutdown")
		end
	end
}

SMODS.Joker{
	key = 'winnt4',
	loc_txt = {
		name = 'Windows NT4',
		text = {
			"Retrigger all",
			"played {C:attention}non-face{} cards",
			"{C:inactive,s:0.6}Hang on, this is just a{}",
			"{C:inactive,s:0.6}backwards Sock and Buskin!{}"
		}
	},
	config = { extra = { repetitions = 1 } },
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 1 },
	cost = 15,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if not context.other_card:is_face() then
				-- This is basically the inverse of Sock and Buskin...
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winnt4start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winnt4shutdown")
		end
	end
}

SMODS.Joker{
	key = 'jokersrb2kart',
	loc_txt = {
		name = 'Karting Joker',
		text = {
			"Gains {X:mult,C:white}X#2#{} Mult when {C:attention}cards{} are",
			"{C:money}bought{}/{C:money}sold{} or when {C:attention}leaving{} shop.",
			"{C:green}#5# in #6#{} chance to gain {X:mult,C:white}X#3#{} Mult",
			"when a {C:attention}Blind{} or {C:attention}Booster Pack{}",
			"is skipped instead of {C:attention}losing #4#%{}",
			"of currently accumulated {X:mult,C:white}XMult{}.",
			"{C:red,s:0.8}Self destructs if {X:mult,C:white,s:0.8}XMult{C:red,s:0.8} goes below {X:mult,C:white,s:0.8}X1{}{C:red,s:0.8}.{}",
			"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive}){}",
			"{C:inactive,s:0.7}I am literally a racer, what's your excuse?"
		}
	},
	config = { extra = { Xmult_current = 1, add_shop = 0.02, addshortcut = 0.5, shortcutfailmult = 0.34, maxchance = 8, toexactchance = 3} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_current, card.ability.extra.add_shop, card.ability.extra.addshortcut, (1-card.ability.extra.shortcutfailmult)*100,
						  (G.GAME.probabilities.normal or 1) * (card.ability.extra.maxchance - card.ability.extra.toexactchance), card.ability.extra.maxchance } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 0 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.extra.Xmult_current > 1 then
				return {
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult_current } }),
					Xmult_mod = card.ability.extra.Xmult_current,
					colour = G.C.MULT
				}
			end
			
			if card.ability.extra.Xmult_current < 1 then -- Catch.
				play_sound('tarot1')
				if not silent and togabalatro.config.SFXWhenTriggered then play_sound('toga_ssb64crowdohh') end -- Eliminated!
				card:start_dissolve()
				return true
			end
		end
		
		if (context.buying_card or context.selling_card or context.ending_shop) and not context.individual and not context.blueprint then
			card.ability.extra.Xmult_current = card.ability.extra.Xmult_current + card.ability.extra.add_shop
			G.E_MANAGER:add_event(Event({func = function()
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')});
				return true
			end}))
		end
		
		if (context.skip_blind or context.skipping_booster) and not context.blueprint then
			if pseudorandom("toga_jokersrb2kart") > G.GAME.probabilities.normal * (card.ability.extra.maxchance - card.ability.extra.toexactchance) / card.ability.extra.maxchance then
				card.ability.extra.Xmult_current = card.ability.extra.Xmult_current * card.ability.extra.shortcutfailmult
				if card.ability.extra.Xmult_current < 1 then
					play_sound('tarot1')
					if not silent and togabalatro.config.SFXWhenTriggered then play_sound('toga_ssb64crowdohh') end -- Eliminated!
					card:start_dissolve()
					return true
				else
					G.E_MANAGER:add_event(Event({func = function()
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Ouch!", colour = G.C.RED});
						return true
					end}))
				end
			else
				card.ability.extra.Xmult_current = card.ability.extra.Xmult_current + card.ability.extra.addshortcut
				G.E_MANAGER:add_event(Event({func = function()
					card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')});
					return true
				end}))
			end
		end
	end,
	update = function(self, card, context)
		if card.ability.extra.Xmult_current < 1 then -- Catch.
			play_sound('tarot1')
			if not silent and togabalatro.config.SFXWhenTriggered then play_sound('toga_ssb64crowdohh') end -- Eliminated!
			card:start_dissolve()
		end
	end,
}

SMODS.Joker{
	key = 'whatisthis',
	loc_txt = {
		name = '???',
		text = {
			"{X:dark_edition,C:white}???^^#1#{}"
		}
	},
	config = { extra = { part = 1.05 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.part } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 2 },
	soul_pos = { x = 4, y = 2 },
	cost = 97,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.sell_cost = 0
		if context.joker_main and not context.repetition and not context.repetition_only then
			return {
				EEmult_mod = card.ability.extra.part,
				message = "^^"..card.ability.extra.part.." Mult",
				colour = G.C.DARK_EDITION
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_ie31")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_access97")
		end
	end,
	update = function(self, card, context)
		card.sell_cost = 0
	end
}

SMODS.Joker{
	key = 'quacksoft',
	loc_txt = {
		name = 'Duck',
		text = {
			"{X:dark_edition,C:white}Quack^#1#{}"
		}
	},
	config = { extra = { part = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.part } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	cost = 69,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.sell_cost = 0
		if context.joker_main and not context.repetition and not context.repetition_only then
			return {
				Echip_mod = card.ability.extra.part,
				message = "^"..card.ability.extra.part.." Chips",
				colour = G.C.DARK_EDITION
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_duck")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_kcud")
		end
	end,
	update = function(self, card, context)
		card.sell_cost = 0
	end
}