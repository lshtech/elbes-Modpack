--- STEAMODDED HEADER
--- MOD_NAME: Crimson's Ultimate Card Kollection
--- MOD_ID: CUCK
--- MOD_AUTHOR: [Crimson Heart]
--- MOD_DESCRIPTION: A collection of all of the mods by Crimson Heart. 
--- DISPLAY_NAME: Crimson Collection
--- BADGE_COLOUR: b20a2f
--- PREFIX: CUCK
----------------------------------------------
------------MOD CODE -------------------------

---------- Codes ---------------------------------------------------------------------------------------------------------------
local Backapply_to_run_Ref = Back.apply_to_run
function Back.apply_to_run(self)
    Backapply_to_run_Ref(self)
    if self.effect.config.all_eternal then
        G.GAME.modifiers.all_eternal = true
    else
        G.GAME.modifiers.all_eternal = false
    end
    
    if self.effect.config.no_shop_jokers then
        G.GAME.modifiers.no_shop_jokers = true
    end
    
    if self.effect.config.flipped_cards then
        G.GAME.modifiers.flipped_cards = 4
    else
        G.GAME.modifiers.flipped_cards = nil
    end

    if self.effect.config.debuff_played_cards then
        G.GAME.modifiers.debuff_played_cards = true
    else
        G.GAME.modifiers.debuff_played_cards = false
    end
    if self.effect.config.shop_eternals then
        G.GAME.modifiers.enable_eternals_in_shop = true
    else
        G.GAME.modifiers.enable_eternals_in_shop = false
    end

    if self.effect.config.rentals then
        G.GAME.modifiers.enable_rentals_in_shop = true
    else
        G.GAME.modifiers.enable_rentals_in_shop = false
    end

    if self.effect.config.perishables then
        G.GAME.modifiers.enable_perishables_in_shop = true
    else
        G.GAME.modifiers.enable_perishables_in_shop = false
    end

    if self.effect.config.no_blind_reward then
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
        G.GAME.modifiers.no_blind_reward.Big = true
    end
    
    if self.effect.config.jokers then
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.effect.config.jokers) do
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, v, 'deck')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
            return true
            end
        }))
    end

    if self.effect.config.AllSixes then
        G.E_MANAGER:add_event(Event({
            func = function()
                for iter_57_0 = #G.playing_cards, 1, -1 do
                    sendDebugMessage(G.playing_cards[iter_57_0].base.id)
                    if G.playing_cards[iter_57_0].base.id ~= 6 then
                        local suit = string.sub(G.playing_cards[iter_57_0].base.suit, 1, 1) .. "_"
                        local rank = "6"

                        G.playing_cards[iter_57_0]:set_base(G.P_CARDS[suit .. rank])
                    end
                end
                return true
            end
        }))
    end
end

---------- Decks ---------------------------------------------------------------------------------------------------------------
SMODS.Atlas({key = 'CUCKDecks', path = 'CUCKDecks.png', px = 71, py = 95, atlas_table = 'ASSET_ATLAS'})

SMODS.Back {
    name = "CUCK_PlainDeck",
    key = "CUCK_PlainDeck",
    config = {},
    pos = {x = 0, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Plain Deck",
        text = {
            "No Effect"
        }
    }
}

SMODS.Back {
    name = "CUCK_ExtremeDeck",
    key = "CUCK_ExtremeDeck",
    config = {hands = -3, discards = -2},
    pos = {x = 1, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Extreme Deck",
        text = {
            "{C:blue}1{} hand",
            "{C:red}1{} discard"
        }
    }
}

SMODS.Back {
    name = "CUCK_InsaneDeck",
    key = "CUCK_InsaneDeck",
    config = {shop_eternals = true, flipped_cards = true, debuff_played_cards = true},
    pos = {x = 2, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Insane Deck",
        text = {
            "{C:attention}Played{} cards become {C:attention}debuffed{} after scoring",
            "Jokers will spawn as Eternal regardless of stake",
            "{C:green}1 in 4{} cards are drawn face down",
        }
    }
}

SMODS.Back {
    name = "CUCK_ImpossibleDeck",
    key = "CUCK_ImpossibleDeck",
    config = {no_blind_reward = true, dollars = -14, shop_eternals = true, rentals = true, perishables = true, flipped_cards = true, debuff_played_cards = true},
    pos = {x = 5, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Impossible Deck",
        text = {
            "{C:attention}Played{} cards become {C:attention}debuffed{} after scoring",
            "Jokers will spawn as Eternal, perishable,",
            "and/or rental regardless of stake",
            "{C:green}1 in 4{} cards are drawn face down",
            "Small and Big Blind give no money",
            "Start with {C:money}$-10{}"
        }
    }
}

SMODS.Back {
    name = "CUCK_SixDeck",
    key = "CUCK_SixDeck",
    config = {AllSixes = 6},
    pos = {x = 3, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Six Deck",
        text = {
            "All cards are {C:green}Sixes{}"
        }
    }
}

SMODS.Back {
    name = "Murphy Subathon Deck",
    key = "CUCK_SubathonDeck",
    config = {jokers = {'j_gros_michel', 'j_cavendish'}},
    pos = {x = 4, y = 0},
    atlas = "CUCKDecks",
    loc_txt = {
        name = "Murphy Subathon Deck",
        text = {
            "Start with {C:attention}Gros Michel{}",
            "and {C:attention}Cavendish{}"
        }
    }
}


------------  0.8.6  -------------------------





----------------------------------------------
------------MOD CODE END----------------------
