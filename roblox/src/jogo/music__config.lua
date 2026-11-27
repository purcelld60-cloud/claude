--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL = __JSR.__ord, __JSR.__arrL
local ____exports = {}
window.DAROCA_MUSIC_CONFIG = __ord(
    {
        schema = 1,
        revision = 21,
        masterVolume = 0.7,
        defaultFadeMs = 1200,
        categories = __arrL(
            {
                __ord({id = "maps", name = "Cenários"}, "id,name"),
                __ord({id = "bosses", name = "Batalhas"}, "id,name"),
                __ord({id = "characters", name = "Personagens"}, "id,name"),
                __ord({id = "menus", name = "Menus"}, "id,name"),
                __ord({id = "events", name = "Eventos"}, "id,name"),
                __ord({id = "party", name = "Festa 3D"}, "id,name")
            },
            6
        ),
        tracks = __arrL(
            {
                __ord({
                    id = "1da1aa3f93b470e3349cb26aa519ac29c2c67717ad91eee1e34bfd01e06ec9df",
                    title = "Arthur cenário",
                    categoryId = "maps",
                    file = "music/1da1aa3f93b470e3349cb26aa519ac29c2c67717ad91eee1e34bfd01e06ec9df.mp3",
                    sha256 = "1da1aa3f93b470e3349cb26aa519ac29c2c67717ad91eee1e34bfd01e06ec9df",
                    bytes = 5352189,
                    duration = 238.184,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc",
                    title = "Igor e Kaique",
                    categoryId = "maps",
                    file = "music/eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc.mp3",
                    sha256 = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc",
                    bytes = 7332048,
                    duration = 183.301,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351",
                    title = "Marco luta",
                    categoryId = "maps",
                    file = "music/90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351.mp3",
                    sha256 = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351",
                    bytes = 7450050,
                    duration = 310.413,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff",
                    title = "Luta Nikolas",
                    categoryId = "maps",
                    file = "music/98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff.mp3",
                    sha256 = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff",
                    bytes = 3043660,
                    duration = 200.96,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45",
                    title = "Luta ollyan",
                    categoryId = "maps",
                    file = "music/2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45.mp3",
                    sha256 = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45",
                    bytes = 4729763,
                    duration = 197.068,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca",
                    title = "Arthur luta",
                    categoryId = "maps",
                    file = "music/f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca.mp3",
                    sha256 = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca",
                    bytes = 5270240,
                    duration = 241.711,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "53fcc5e82a1819460f146a588d360794941aaa882688071adb849e90a1cd3d09",
                    title = "112",
                    categoryId = "maps",
                    file = "music/53fcc5e82a1819460f146a588d360794941aaa882688071adb849e90a1cd3d09.mp3",
                    sha256 = "53fcc5e82a1819460f146a588d360794941aaa882688071adb849e90a1cd3d09",
                    bytes = 4680170,
                    duration = 256.993,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e",
                    title = "Roça",
                    categoryId = "maps",
                    file = "music/a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e.mp3",
                    sha256 = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e",
                    bytes = 4043892,
                    duration = 168.49,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1",
                    title = "Eu",
                    categoryId = "maps",
                    file = "music/f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1.mp3",
                    sha256 = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1",
                    bytes = 9502302,
                    duration = 237.558,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "cf49423f3ea70079d39027a3c19c5ad00c2f6de5e57a28aca79fea2647279bfe",
                    title = "Colosso 67",
                    categoryId = "maps",
                    file = "music/cf49423f3ea70079d39027a3c19c5ad00c2f6de5e57a28aca79fea2647279bfe.mp3",
                    sha256 = "cf49423f3ea70079d39027a3c19c5ad00c2f6de5e57a28aca79fea2647279bfe",
                    bytes = 7167092,
                    duration = 179.174,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "250c7d240fb1fb3ce9e7abdd10133b10060844cc5ac7b0eefe8d47a31ce9c05d",
                    title = "Geme Baixo - MC Jvila, Menor MC e G.A (DJ Dael, DJ Galdino, Honaiser e DJ João Pereira) - MC JVILA",
                    categoryId = "maps",
                    file = "music/250c7d240fb1fb3ce9e7abdd10133b10060844cc5ac7b0eefe8d47a31ce9c05d.mp3",
                    sha256 = "250c7d240fb1fb3ce9e7abdd10133b10060844cc5ac7b0eefe8d47a31ce9c05d",
                    bytes = 9607836,
                    duration = 240.196,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs"),
                __ord({
                    id = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c",
                    title = "Luta carvalho",
                    categoryId = "maps",
                    file = "music/9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c.mp3",
                    sha256 = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c",
                    bytes = 9633959,
                    duration = 240.849,
                    volume = 1,
                    loop = true,
                    fadeMs = 1200
                }, "id,title,categoryId,file,sha256,bytes,duration,volume,loop,fadeMs")
            },
            12
        ),
        bindings = __ord(
            {
                ["maps.roca"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.escola"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.academia"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.quadra"] = __ord({trackId = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1", enabled = true}, "trackId,enabled"),
                ["maps.camacan"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.campo"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.bigodon"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.patio"] = __ord({trackId = "1da1aa3f93b470e3349cb26aa519ac29c2c67717ad91eee1e34bfd01e06ec9df", enabled = true}, "trackId,enabled"),
                ["maps.rayssa"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["maps.baile"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["rooms.almiro"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["rooms.miqueias"] = __ord({trackId = "a0669394aabd2a7bf60a614075532655ba67f1b3f1b6c2f2efed34efcb9a9a0e", enabled = true}, "trackId,enabled"),
                ["battles.igor"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.kaique"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.marco"] = __ord({trackId = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351", enabled = true}, "trackId,enabled"),
                ["battles.giant"] = __ord({trackId = "cf49423f3ea70079d39027a3c19c5ad00c2f6de5e57a28aca79fea2647279bfe", enabled = true}, "trackId,enabled"),
                ["battles.menezes"] = __ord({trackId = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1", enabled = true}, "trackId,enabled"),
                ["battles.nikolas"] = __ord({trackId = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff", enabled = true}, "trackId,enabled"),
                ["battles.arthur"] = __ord({trackId = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca", enabled = true}, "trackId,enabled"),
                ["battles.ollyan"] = __ord({trackId = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45", enabled = true}, "trackId,enabled"),
                ["cutscenes.jorge_epilogue"] = __ord({trackId = "53fcc5e82a1819460f146a588d360794941aaa882688071adb849e90a1cd3d09", enabled = true, startSeconds = 112, delaySeconds = 0}, "trackId,enabled,startSeconds,delaySeconds"),
                ["battles.marco.phase1"] = __ord({trackId = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351", enabled = true}, "trackId,enabled"),
                ["battles.marco.phase2"] = __ord({trackId = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351", enabled = true}, "trackId,enabled"),
                ["battles.marco.phase3"] = __ord({trackId = "90a922b690277de277af116eeb85a50bb9dc10f6d9ed2e9a6b218dce6c011351", enabled = true}, "trackId,enabled"),
                ["battles.menezes.phase1"] = __ord({trackId = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1", enabled = true}, "trackId,enabled"),
                ["battles.menezes.phase2"] = __ord({trackId = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1", enabled = true}, "trackId,enabled"),
                ["battles.menezes.phase3"] = __ord({trackId = "f87d23638b73a746f74b8af7b8300ef8410734f31a79ac0ae5672068f7ac06c1", enabled = true}, "trackId,enabled"),
                ["battles.nikolas.phase1"] = __ord({trackId = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff", enabled = true}, "trackId,enabled"),
                ["battles.nikolas.phase2"] = __ord({trackId = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff", enabled = true}, "trackId,enabled"),
                ["battles.nikolas.phase3"] = __ord({trackId = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff", enabled = true}, "trackId,enabled"),
                ["battles.nikolas.phase4"] = __ord({trackId = "98ed4a372412aefaaf52cf98a1c40a05c109501a7f5e0aa04695cb33ccb6dbff", enabled = true}, "trackId,enabled"),
                ["maps.favela"] = __ord({trackId = "250c7d240fb1fb3ce9e7abdd10133b10060844cc5ac7b0eefe8d47a31ce9c05d", enabled = true}, "trackId,enabled"),
                ["battles.ollyan.phase1"] = __ord({trackId = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45", enabled = true}, "trackId,enabled"),
                ["battles.ollyan.phase2"] = __ord({trackId = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45", enabled = true}, "trackId,enabled"),
                ["battles.ollyan.phase3"] = __ord({trackId = "2b964f01ae004fcc00865035b27378716c07baa608f47018119f1728f71a5c45", enabled = true}, "trackId,enabled"),
                ["battles.arthur.phase1"] = __ord({trackId = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca", enabled = true}, "trackId,enabled"),
                ["battles.arthur.phase2"] = __ord({trackId = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca", enabled = true}, "trackId,enabled"),
                ["battles.arthur.phase3"] = __ord({trackId = "f5a76f9acf93dec4423298b9808573305128c424a21f3186c1b742dca62525ca", enabled = true}, "trackId,enabled"),
                ["battles.igor.phase1"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.igor.phase2"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.igor.phase3"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.kaique.phase1"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.kaique.phase2"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.kaique.phase3"] = __ord({trackId = "eb90836ce0745980da9dbb3e04f2352695b008e7af0238a71608d82245499fbc", enabled = true}, "trackId,enabled"),
                ["battles.nicolas.phase1"] = __ord({trackId = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c", enabled = true}, "trackId,enabled"),
                ["battles.nicolas.phase2"] = __ord({trackId = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c", enabled = true}, "trackId,enabled"),
                ["battles.nicolas.phase3"] = __ord({trackId = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c", enabled = true}, "trackId,enabled"),
                ["battles.nicolas"] = __ord({trackId = "9a25de9b7c751346410d78f558c5a103a3c162309722e613ecf851184aab626c", enabled = true}, "trackId,enabled")
            },
            "maps.roca,maps.escola,maps.academia,maps.quadra,maps.camacan,maps.campo,maps.bigodon,maps.patio,maps.rayssa,maps.baile,rooms.almiro,rooms.miqueias,battles.igor,battles.kaique,battles.marco,battles.giant,battles.menezes,battles.nikolas,battles.arthur,battles.ollyan,cutscenes.jorge_epilogue,battles.marco.phase1,battles.marco.phase2,battles.marco.phase3,battles.menezes.phase1,battles.menezes.phase2,battles.menezes.phase3,battles.nikolas.phase1,battles.nikolas.phase2,battles.nikolas.phase3,battles.nikolas.phase4,maps.favela,battles.ollyan.phase1,battles.ollyan.phase2,battles.ollyan.phase3,battles.arthur.phase1,battles.arthur.phase2,battles.arthur.phase3,battles.igor.phase1,battles.igor.phase2,battles.igor.phase3,battles.kaique.phase1,battles.kaique.phase2,battles.kaique.phase3,battles.nicolas.phase1,battles.nicolas.phase2,battles.nicolas.phase3,battles.nicolas"
        )
    },
    "schema,revision,masterVolume,defaultFadeMs,categories,tracks,bindings"
)
return ____exports
