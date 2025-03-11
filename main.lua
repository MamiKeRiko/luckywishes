-- load all files

--globals
assert(SMODS.load_file('globals.lua'))()
assert(SMODS.load_file('sounds.lua'))()

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
        name = 'Wish Card', 
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