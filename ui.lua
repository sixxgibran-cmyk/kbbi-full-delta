local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Button.Parent = ScreenGui

Button.Size = UDim2.new(0,140,0,40)
Button.Position = UDim2.new(0,20,0,200)
Button.Text = "BOT : ON"
Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.Active = true
Button.Draggable = true

local enabled = true

Button.MouseButton1Click:Connect(function()
    enabled = not enabled
    Button.Text = enabled and "BOT : ON" or "BOT : OFF"
    _G.BOT_ENABLED = enabled
end)

_G.BOT_ENABLED = true
