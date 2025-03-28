return {
    descriptions = {
        wish = {
            c_l6w_void = {
                name = 'Void',
                text = {
                    '{V:1}While held:{} destroys first {C:red}discard{}',
                    'of each round',
                    '{V:1}After #1# Rounds:{} use to {C:attention}clone{} last',
                    'destroyed {C:red}discard{}, add random',
                    '{C:attention}enhancements{} and draw to hand',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
            c_l6w_machine = {
                name = 'Machine',
                text = {
                    '{V:1}While held:{} scored card listed values',
                    'are {C:mult}multiplied{} by a number',
                    'between {X:mult,C:white}X#4#{} and {X:mult,C:white}X#5#{}',
                    '{V:1}After #1# Rounds:{} use to {C:mult}multiply{}',
                    'owned {C:attention}Joker{} values by {X:mult,C:white}X#6#{}',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
            c_l6w_priest = {
                name = 'Priest',
                text = {
                    '{V:1}While held:{} after hand is scored,',
                    'create a {C:dark_edition}Negative{} copy of its',
                    'corresponding {C:planet}Planet{} card',
                    '{V:1}After #1# Rounds:{} use to {C:attention}upgrade{}',
                    'most played hand by {C:attention}#4#{} levels',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
            c_l6w_warrior = {
                name = 'Warrior',
                text = {
                    '{V:1}While held:{} all scored cards',
                    'permanently gain {X:mult,C:white}X#4#{} Mult',
                    '{V:1}After #1# Rounds:{} use to create',
                    'a {C:dark_edition}Negative{} copy of {C:spectral}The Soul{}',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
            c_l6w_staff = {
                name = 'Staff',
                text = {
                    '{V:1}While held:{} creates a {C:dark_edition}Negative',
                    '{C:tarot}Tarot{} card after hand is played',
                    '{V:1}After #1# Rounds:{} use to add',
                    'the last applied {C:attention}Enhancement{}',
                    'to entire hand',
                    '{s:0.8}Currently {}{s:0.8,V:2}#4#{}',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
            c_l6w_spirit = {
                name = 'Spirit',
                text = {
                    '{V:1}While held:{} creates a {C:dark_edition}Negative',
                    '{V:1}Wish{} card when {C:attention}Boss Blind{}',
                    'is selected',
                    '{V:1}After #1# Rounds:{} use to...',
                    '{C:inactive}Do nothing?{}',
                    '{C:attention}Destroyed after #3# rounds',
                    '{C:inactive}Rounds: [#2#/#1#]'
                }
            },
        },
        Other = {
            p_l6w_wishes_s = {
                name = 'Wish Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{} {V:1}Wish{} cards to',
                    'add to deck'
                }
            },
            p_l6w_wishes_s2 = {
                name = 'Wish Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{} {V:1}Wish{} cards to',
                    'add to deck'
                }
            },
            p_l6w_wishes_m = {
                name = 'Jumbo Wish Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{} {V:1}Wish{} cards to',
                    'add to deck'
                }
            },
            p_l6w_wishes_l = {
                name = 'Mega Wish Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{} {V:1}Wish{} cards to',
                    'add to deck'
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_l6_wither = 'Withered...',
            k_l6w_wishespack = 'Wish Pack'
        }
    }
}