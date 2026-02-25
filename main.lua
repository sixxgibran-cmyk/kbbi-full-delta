-- Load UI
loadstring(game:HttpGet(
"https://raw.githubusercontent.com/sixxgibran-cmyk/REPO/main/ui.lua"
))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

local BASE = "https://raw.githubusercontent.com/USERNAME/REPO/main/kbbi/"
local KAMUS, USED = {}, {}

-- Load huruf
local function loadHuruf(h)
    if KAMUS[h] then return end
    KAMUS[h] = {}

    local ok, data = pcall(function()
        return game:HttpGet(BASE .. h .. ".txt")
    end)

    if ok then
        for k in string.gmatch(data, "[^\r\n]+") do
            table.insert(KAMUS[h], k)
        end
    end
end

-- SMART PICK (kata agak panjang & jarang)
local function ambilKata(h)
    loadHuruf(h)

    local kandidat = {}
    for _, kata in ipairs(KAMUS[h]) do
        if not USED[kata] and #kata >= 5 then
            table.insert(kandidat, kata)
        end
    end

    if #kandidat > 0 then
        local pilih = kandidat[math.random(#kandidat)]
        USED[pilih] = true
        return pilih
    end
end

-- Auto ketik
local function ketik(teks)
    task.wait(math.random(20,40)/100)
    for i = 1, #teks do
        VIM:SendKeyEvent(true, teks:sub(i,i), false, game)
        task.wait(math.random(30,60)/1000)
    end
    VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
end

-- ===== LOGIKA GAME =====
local last = ""

while task.wait(1) do
    if not _G.BOT_ENABLED then continue end

    local lastWord = workspace:FindFirstChild("LastWord", true)
    local myTurn = player:FindFirstChild("MyTurn")

    if lastWord and myTurn and myTurn.Value then
        local kata = lastWord.Value:lower()
        if kata ~= last then
            last = kata
            USED[kata] = true

            local h = kata:sub(-1)
            local jawab = ambilKata(h)
            if jawab then
                ketik(jawab)
            end
        end
    end
end
