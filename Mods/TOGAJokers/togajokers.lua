--- STEAMODDED HEADER
--- MOD_NAME: TOGA's Jokers
--- MOD_ID: TOGAJoker
--- MOD_AUTHOR: [TheOneGoofAli]
--- MOD_DESCRIPTION: Just some things.
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d, Talisman>=2.0.0-beta9]
--- BADGE_COLOR: fd9712
--- PREFIX: toga
--- VERSION: 0.95.0-DeveloperPreview
----------------------------------------------
------------MOD CODE -------------------------

-- Define thy map.
SMODS.Atlas{key = "TOGAJokersMain", path = "togajokers.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersOther", path = "togajokersother.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersWindows", path = "togajokerswinos.png", px = 78, py = 100}
SMODS.Atlas({key = "modicon", path = "togaicon.png", px = 32, py = 32}):register()

-- Hear me scream!
SMODS.Sound({key = "win95start", path = "win95start.ogg"}) -- The Microsoft Sound
SMODS.Sound({key = "win95shutdown", path = "win95shutdown.ogg"}) -- tada.wav (pre-98)

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
        }}
	}}
end

-- Unused.
--function toga_getselfpos(card)
--	for i = 1, #G.jokers.cards do
--    if G.jokers.cards[i] == card then return i end
--  end
--end

-- Count steel card amount in full deck and round up the returned result.
function toga_gettotalsteelcount()
	local allsteel = 0
	if G.playing_cards then
		for k, v in pairs(G.playing_cards) do
			if v.config.center == G.P_CENTERS.m_steel then allsteel = allsteel+1 end
		end
	end
	return math.floor(allsteel/4)
end

-- Update variable for Iron Will.
function toga_updatesteelrepeat(target)
	return toga_gettotalsteelcount()*target.ability.extra.repetitions
end

-- Check for 2 and King.
function toga_y2kcheck(context)
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

-- Random text.
function toga_randomruntext()
	local stringtable = { 'Run!', 'Again!', 'Again?', 'One more!', 'Another one!', 'Thread!' }
	return stringtable[math.random(#stringtable)]
end

SMODS.Joker{
	key = 'ironwill',
	loc_txt = {
		name = 'Iron Will',
		text = {
		"Retrigger a scoring card",
		"#1# time(s) per {C:attention}4 Steel Cards{}",
		"in your {C:important}full deck{}.",
		"{C:inactive}(Currently #2#){}"
		--"Still doing {C:attention}things{}...",
		--"{C:inactive,s:0.8}Feeling old yet?{}"
		}
	},
	config = { extra = { repetitions = 1, totalrepetitions = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, toga_updatesteelrepeat(card) } }
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 0 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
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
			"{C:inactive,s:0.8}An Office regular.{}"
		}
	},
	config = { extra = { h_size = 3, chips = 100 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_size, card.ability.extra.chips } }
	end,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips
			}
		end
	end
}

SMODS.Joker{
	key = 'win95toga',
	loc_txt = {
		name = 'Windows 95',
		text = {
			"{C:chips}+#1#{} hand(s) & {C:red}+#2#{} discard(s)",
			"upon selecting a {C:attention}Blind{}.",
			"Earn {C:money}$#3#{} at end of round.",
			"If there are #5# or fewer Jokers,",
			"get {X:money,C:white} X#4# {} the amount."
		}
	},
	config = { extra = { hands = 1, discards = 1, money = 4, Xmoney = 2, slots = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.discards, card.ability.extra.money, card.ability.extra.Xmoney, card.ability.extra.slots } }
	end,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 0 },
	cost = 8,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
			ease_hands_played(card.ability.extra.hands)
		end
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
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
		if not from_debuff and togabalatro.config.SFXWhenAdding then
			play_sound("toga_win95start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving then
			play_sound("toga_win95shutdown")
		end
	end,
}