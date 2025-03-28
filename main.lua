-- load all files

--main files
assert(SMODS.load_file('globals.lua'))()
assert(SMODS.load_file('sounds.lua'))()
assert(SMODS.load_file('boosters.lua'))()

--items
for _, i in ipairs(NFS.getDirectoryItems(SMODS.current_mod.path..'items')) do
    assert(SMODS.load_file('items/'..i))()
end

-- card atlas
SMODS.Atlas {
    key = "L6Wish",
    path = "Wishes.png",
    px = 71,
    py = 95
}

-- type definition
SMODS.ConsumableType {
    key = 'wish',
    primary_colour = L6W.C.main,
    secondary_colour = L6W.C.secondary,
    collection_rows = {5, 5},
    loc_txt = {
        name = 'Wish', 
        collection = 'Wish Cards', 
        undiscovered = { 
            name = '???',
            text = 
            { 
                'Find this card during a run',
                'to learn its effects' 
            },
        },
    },
    default = 'c_l6w_void'
}

to_big = to_big or function (value) -- for talisman compat
    return value
end

-- set ability hook to check for applied enhancements
local setab = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    local old_center = self.config.center
    setab(self, center, initial, delay_sprites)

    if center ~= old_center and center ~= G.P_CENTERS.e_base then
        local effects
        SMODS.calculate_context({l6_enhancement_applied = center, other_card = self}, effects)
    end
end
