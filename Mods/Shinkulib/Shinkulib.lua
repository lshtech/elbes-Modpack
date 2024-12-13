--- STEAMODDED HEADER
--- MOD_NAME: ShinkuLib
--- MOD_ID: ShinkuLib
--- MOD_AUTHOR: [Crimson Heart, MathIsFun]
--- MOD_DESCRIPTION: Required for any mods that are in current/future mods, along with a resource dependency. 
--- VERSION: 1.0
----------------------------------------------
------------MOD CODE -------------------------

--[[
If you're looking in here, Hello! This is to credit stuff and thanks.

Thanks Mathguy and MathIsFun for helping me in trying to make the planet cards work for Archvied.
Thank you MathIsFun as well for setting me up with a modified Universum code to make it so that the planet cards work as intended. That is why you're part of the Mod Author section. 
]]--


-- Tier 3 Vouchers --


T3Voucher = 0
TestPlanet = 1


if TestPlanet == 1 then

    SMODS.Atlas({
        key = "TestPlanet",
        path = "TestPlanet.png",
        px = 71,
        py = 95,
    }):register() 

    SMODS.Consumable{
        key = 'TestPlanet',
        set = 'Planet',
        pos = {x = 0, y = 0},
        config = {hand_type = 'High Card', extra = {planet_chips = 1, planet_mult = 1 }}, -- planet_chip/mult can be decimals and negative. 
        cost = 3,
        discorvered = true,
        unlocked = true,
        order = 1,
        atlas = 'TestPlanet',
        loc_txt = {
          name = 'Test Planet',
          text = { 
            "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
            "{C:attention}#1#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
        },
          can_use = function(self, card)
              return true
          end,
      
        loc_vars = function(self, info_queue, center)
          local planetlevel = G.GAME.hands['High Card'].level or 1
          local planetcolor = G.C.HAND_LEVELS[math.min(planetlevel, 7)]
          if planetlevel == 1 then
              planetcolor = G.C.UI.TEXT_DARK
          end
          return {
          vars = {
            localize("High Card", "poker_hands"),
            G.GAME.hands['High Card'].level,
            self.config.extra.planet_mult,
            self.config.extra.planet_chips,
            colours = { planetcolor },
          },
          }
        end,
        use = function(self, card, area, copier)
          update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level})
          Shinku_LUH(
            card, 
            card.ability.hand_type, 
            nil,  
            1 --[[Number of times it repeats/level up by. You will have to divide Chip/Mult by this number if you want a specific one. Example +1C/+1M for 5 Levels, you have to put 0.2 for both planet_chips and planet_mult]])
          update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end,
      }
end


-- T3Vouchers do not work yet
if T3Voucher == 1 then
    SMODS.Atlas({
        key = "Tier3Vouchers",
        path = "T3_Vouchers.png",
        px = 71,
        py = 95,
    }):register()

    SMODS.Voucher({
        key = "overstock_three",
        config = {},
        pos = {x = 0, y = 0},
        loc_txt = {
            name = 'Overflowing Stock',
            text = {
                '{C:attention}+1{} card slot',
                'available in shop'}
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {'v_overstock_plus'},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "money_mint",
        config = {extra = 75},
        pos = {x = 3, y = 0},
        loc_txt = {
            name = "Money Minting",
            text = {
                "All cards and packs in",
                "shop are {C:attention}75%{} off"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_liquidation"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "reroll_addict",
        config = {extra = 1},
        pos = {x = 0, y = 1},
        loc_txt = {
            name = "Reroll Addiction",
            text = {
                "Rerolls cost",
                "{C:money}$1{} less"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_reroll_glut"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "glow_in_dark",
        config = {extra = 6},
        pos = {x = 4, y = 0},
        loc_txt = {
            name = "Glow in the Dark",
            text = {
                "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and",
                "{C:dark_edition}Polychrome{} cards",
                "appear {C:attention}6X{} more often"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_glow_up"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "happy_accident",
        config = {extra = 6},
        pos = {x = 7, y = 1},
        loc_txt = {
            name = "Happy Little Accident",
            text = {
                "{C:attention}+1{} hand size"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_palette"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "applause",
        config = {extra = 1},
        pos = {x = 5, y = 0},
        loc_txt = {
            name = "Round of Applause",
            text = {
                "Permanently",
                "gain {C:blue}+1{} hand",
                "per round"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_nacho_tong"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "down_to_zero",
        config = {extra = 1},
        pos = {x = 6, y = 0},
        loc_txt = {
            name = "Down to Zero",
            text = {
                "Permanently",
                "gain {C:red}+1{} discard",
                "per round"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_recyclomancy"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "in_the_beginning",
        config = {extra = 1},
        pos = {x = 5, y = 1},
        loc_txt = {
            name = "In the Beginning...",
            text = {
                "{C:attention}-1{} Ante,",
                "{C:blue}-1{} hand and",
                "{C:red}-1{} discard",
                "each round"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_petroglyph"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "money_forest",
        config = {extra = 200},
        pos = {x = 1, y = 1},
        loc_txt = {
            name = "Money Forest",
            text = {
                "Raise the cap on",
                "interest earned",
                "per round to {C:money}$40{}"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_money_tree"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "tarot_factory",
        config = {extra = 64/4, extra_disp = 8},
        pos = {x = 1, y = 0},
        loc_txt = {
            name = "Tarot Factory",
            text = {
                "{C:tarot}Tarot{} cards appear",
                "{C:attention}8X{} more frequently",
                "in the shop"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_tarot_tycoon"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "planet_factory",
        config = {extra = 64/4, extra_disp = 8},
        pos = {x = 2, y = 0},
        loc_txt = {
            name = "Planet Factory",
            text = {
                "{C:planet}Planet{} cards appear",
                "{C:attention}8X{} more frequently",
                "in the shop"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_planet_tycoon"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "neutral_particle",
        config = {},
        pos = {x = 7, y = 0},
        loc_txt = {
            name = "Neutral Particle",
            text = {
                "{C:dark_edition}+1{} Joker Slot"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_antimatter"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "gaff_deck",
        config = {extra = 8},
        pos = {x = 4, y = 1},
        loc_txt = {
            name = "Gaff Deck",
            text = {
                "{C:attention}Playing Cards{} appear {C:attention}2X{}",
                "more frequently in the shop,",
                "{C:attention}Playing Cards{} are now {C:green}FREE{}"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_illusion"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "reboot",
        config = {},
        pos = {x = 6, y = 1},
        loc_txt = {
            name = "Reboot",
            text = {
                "{C:green}1 in 5{} chance to",
                "{C:money}REFUND{} Boss Reroll,"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_retcon"},
        atlas = "Tier3Vouchers",
    })
    
    SMODS.Voucher({
        key = "reboot",
        config = {},
        pos = {x = 6, y = 1},
        loc_txt = {
            name = "Reboot",
            text = {
                "{C:green}1 in 5{} chance to",
                "{C:money}REFUND{} Boss Reroll,"
            }
        },
        cost = 10,
        unlocked = true,
        discovered = true,
        available = true,
        requires = {"v_retcon"},
        atlas = "Tier3Vouchers",
    })


    
end     


----------------------------------------------
------------MOD CODE END----------------------
