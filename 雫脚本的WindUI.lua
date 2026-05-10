local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)

    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoxi9008/-UI/refs/heads/main/Wind.lua"))()
    end
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local function createUI()
    local Window = WindUI:CreateWindow({
        Title = "<font color='#E6F0FA'>雫</font><font color='#CCE0F5'>脚</font><font color='#B3D1F0'>本</font>",
        Folder = "ftgshub",
        NewElements = true,
        HideSearchBar = false,
        Size = UDim2.fromOffset(600, 450),
        Theme = "Dark",  
        UserEnabled = true,
        SideBarWidth = 135,
        HasOutline = true,
        Background = "https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/image_download_1776648555077.jpg",
        
        OpenButton = {
            Title = "<font color='#E6F0FA'>雫</font><font color='#CCE0F5'>脚</font><font color='#B3D1F0'>本</font>",
            CornerRadius = UDim.new(1,0),
            StrokeThickness = 1.5,
            Enabled = true,
            Draggable = true,
            OnlyMobile = false,
            Color = ColorSequence.new(
                Color3.fromHex("FFFFFF"), 
                Color3.fromHex("FFFFFF")
            )
        },
        Topbar = {
            Height = 44,
            ButtonsType = "Mac",
        }
    })

    Window:Tag({
        Title = "付费版",
        Radius = 4,
        Color = Color3.fromHex("#ffffff"),
    })

    Window:Tag({
        Title = "通用",
        Radius = 4,
        Color = Color3.fromHex("#ffffff"),
    })
    
    local AboutTab = Window:Tab({
        Title = "公告",
        Desc = "脚本信息", 
        Icon = "solar:info-square-bold",
        IconColor = Color3.fromRGB(179, 209, 240),
        IconShape = "Square",
        Border = true,
    })

    AboutTab:Paragraph({
        Title = "欢迎使用 <font color='#FFFFFF'>X</font><font color='#CCCCCC'>I</font><font color='#999999'>A</font><font color='#666666'>O</font><font color='#444444'>X</font><font color='#222222'>I</font> 脚本",
        Desc = "作者：小西｜通用脚本",
        ImageSize = 50,
        Thumbnail = "https://raw.githubusercontent.com/xiaoxi9008/Server./refs/heads/main/7fdb4ab15ea4447bc9566c7caf856f82fc31ae85362243f5f0dd837a41c9ea86.png",
        ThumbnailSize = 170
    })

    AboutTab:Divider()

    AboutTab:Button({
        Title = "显示欢迎通知",
        Icon = "bell",
        Color = Color3.fromRGB(179, 209, 240),
        Callback = function()
            WindUI:Notify({
                Title = "欢迎!",
                Content = "感谢使用XIAOXI付费版",
                Icon = "heart",
                Duration = 3
            })
        end
    })

    task.wait(0.5)

    -- 蓝白流动边框效果
    local function startBlueWhiteBorder()
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if not mainFrame then
            task.wait(0.2)
            mainFrame = Window.UIElements and Window.UIElements.Main
            if not mainFrame then
                warn("无法找到窗口主框架")
                return
            end
        end
        
        local oldStroke = mainFrame:FindFirstChild("BlueWhiteStroke")
        if oldStroke then oldStroke:Destroy() end
        
        local stroke = Instance.new("UIStroke")
        stroke.Name = "BlueWhiteStroke"
        stroke.Thickness = 2
        stroke.Color = Color3.fromHex("E6F0FA")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.LineJoinMode = Enum.LineJoinMode.Round
        stroke.Parent = mainFrame
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("E6F0FA")),
            ColorSequenceKeypoint.new(0.33, Color3.fromHex("CCE0F5")),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex("B3D1F0")),
            ColorSequenceKeypoint.new(0.67, Color3.fromHex("CCE0F5")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("E6F0FA"))
        })
        gradient.Rotation = 0
        gradient.Parent = stroke
        
        local angle = 0
        local animationConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not stroke or stroke.Parent == nil then
                animationConnection:Disconnect()
                return
            end
            angle = (angle + 120 * deltaTime) % 360
            gradient.Rotation = angle
        end)
    end

    -- 设置OpenButton的蓝白流动边框
    local function setupOpenButtonBorder()
        task.wait(0.3)
        
        local openButton = Window.UIElements and Window.UIElements.OpenButton
        if not openButton then
            openButton = Window.OpenButton
        end
        if not openButton then
            warn("无法找到OpenButton")
            return
        end
        
        local oldStroke = openButton:FindFirstChild("BlueWhiteStroke")
        if oldStroke then oldStroke:Destroy() end
        
        local stroke = Instance.new("UIStroke")
        stroke.Name = "BlueWhiteStroke"
        stroke.Thickness = 1.5
        stroke.Color = Color3.fromHex("E6F0FA")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.LineJoinMode = Enum.LineJoinMode.Round
        stroke.Parent = openButton
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("E6F0FA")),
            ColorSequenceKeypoint.new(0.33, Color3.fromHex("CCE0F5")),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex("B3D1F0")),
            ColorSequenceKeypoint.new(0.67, Color3.fromHex("CCE0F5")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("E6F0FA"))
        })
        gradient.Rotation = 0
        gradient.Parent = stroke
        
        local angle = 0
        local animationConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not stroke or stroke.Parent == nil then
                animationConnection:Disconnect()
                return
            end
            angle = (angle - 150 * deltaTime) % 360
            gradient.Rotation = angle
        end)
    end

    startBlueWhiteBorder()
    setupOpenButtonBorder()
end

WindUI:Popup({
    Title = "<font color='#E6F0FA'>雫</font><font color='#CCE0F5'>脚</font><font color='#B3D1F0'>本</font>",
    IconThemed = true,
    Content = "尊贵付费版用户" .. game.Players.LocalPlayer.Name .. "使用<font color='#E6F0FA'>雫</font><font color='#CCE0F5'>脚</font><font color='#B3D1F0'>本</font>付费版",
    Buttons = {
        {
            Title = "取消",
            Callback = function() 
                createUI()
            end,
            Variant = "Secondary",
        },
        {
            Title = "执行",
            Icon = "arrow-right",
            Callback = function() 
                createUI()
            end,
            Variant = "Primary",
        }
    }
})