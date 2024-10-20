--- STEAMODDED HEADER
--- MOD_NAME: Happy Birthday!
--- MOD_ID: BirthdayCardMod
--- MOD_AUTHOR: [TheLemon27]
--- MOD_DESCRIPTION: Adds the "Birthday" Joker to the game. Happy birthday mom!
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: c7638f
--- PREFIX: birth
----------------------------------------------
------------MOD CODE -------------------------

--[[
------------------------------Basic Table of Contents------------------------------
Line 27, Atlas ---------------- Explains the parts of the atlas.
Line 39, Joker 2 -------------- Explains the basic structure of a joker
Line 98, Runner 2 ------------ Uses a bit more complex contexts, and shows how to scale a value.
Line 147, Golden Joker 2 ------ Shows off a specific function that's used to add money at the end of a round.
Line 173, Merry Andy 2 -------- Shows how to use add_to_deck and remove_from_deck.
Line 217, Sock and Buskin 2 --- Shows how you can retrigger cards and check for faces
Line 250, Perkeo 2 ------------ Shows how to use the event manager, eval_status_text, randomness, and soul_pos.
Line 295, Walkie Talkie 2 ----- Shows how to look for multiple specific ranks, and explains returning multiple values
Line 329, Gros Michel 2 ------- Shows the no_pool_flag, sets a pool flag, another way to use randomness, and end of round stuff.
Line 403, Cavendish 2 --------- Shows yes_pool_flag, has X Mult, mainly to go with Gros Michel 2.
]]

--Creates an atlas for cards to use
SMODS.Atlas {
  -- Key for code to find it with
  key = "BirthdayCard",
  -- The name of the file, for the code to pull the atlas from
  path = "BirthdayCard.png",
  -- Width of each sprite in 1x size
  px = 71,
  -- Height of each sprite in 1x size
  py = 95
}
SMODS.Atlas {
  -- Key for code to find it with
  key = "BirthdayCardBack",
  -- The name of the file, for the code to pull the atlas from
  path = "BirthdayCardBack.png",
  -- Width of each sprite in 1x size
  px = 71,
  -- Height of each sprite in 1x size
  py = 95
}



SMODS.Joker {
  key = 'birthday_card',
  loc_txt = {
    name = 'Birthday',
    text = {
      "Each played {C:clubs}Clubs{} card",
      "gives {C:chips}+#1#{} Chips and",
      "{C:mult}+#2#{} Mult when scored"
    }
  },
  config = { extra = { chips = 10, mult = 6 } },
  rarity = 2,
  blueprint_compat = true,
  discovered = false,
  atlas = 'BirthdayCard',
  pos = { x = 0, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit("Clubs") then
							G.E_MANAGER:add_event(Event({
								func = function()
									card:juice_up(1, 1)
									return true
								end
							})) 
        return {
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
          card = self
        }
      end
    end
  end
}


    table.insert(G.CHALLENGES, {
        name = 'Happy Birthday!',
        id = 'c_happy_birthday',
        rules = {
            custom = {
            },
            modifiers = {
            }
        },
        jokers = {
            {id = 'birthday_card', eternal = true},
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            type = 'Challenge Deck'
        },
        restrictions = {
            banned_cards = {
            },
            banned_tags = {
            },
            banned_other = {
            }
        }
    })
	
	--SMODS.Back{
	--name = "Birthday Deck",
	--key = "d_birthday",
	--pos = {x = 0, y = 0},
	--atlas = "BirthdayCardBack",
	--config = {polyglass = true},
	--loc_txt = {
	--	name = "Birthday Deck",
	--	text ={
	--		"Start with an eternal {C:attention}Birthday{} Joker."
	--	},
    --},
	--apply = function()
	--	G.E_MANAGER:add_event(Event({
	--		func = function()
	--			local n_card = create_card(nil,G.jokers, nil, nil, nil, nil, 'birthday_card')
	--			n_card:add_to_deck()
	--			G.jokers:emplace(n_card)
	--			return true
	--		end
	--	}))
	--end
--}
----------------------------------------------
------------MOD CODE END----------------------
