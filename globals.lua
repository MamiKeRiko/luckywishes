-- set custom globals
L6W = {
    C = {
        main =  HEX('6E3AA6'),
        secondary = HEX('a36be8')
    },

    funcs = {
        
        flip_unflip = function (card, i, context, amount, t, func)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = (i - 1) * t,
                blockable = false,
                func = function() 
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3, 0.3)
                    return true
                end 
            }))
    
            G.E_MANAGER:add_event(Event({
                func = function()
                    func()
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = ((i - 1) * t) + (amount * t),
                blockable = false,
                func = function()
                    if not context.individual and not context.cardarea == G.play and not context.other_card == card then return false end
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        trigger = 'after',
                        delay = 0.35,
                        func = function() 
                            card:flip()
                            play_sound('tarot2')
                            card:juice_up(0.3, 0.3)
                            return true 
                        end 
                    }))
                    return true
                end
            }))
        end
    
    }
}