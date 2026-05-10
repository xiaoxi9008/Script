-- 自动回复脚本
-- 监听聊天消息并自动回复对应脚本

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- 配置区域
local prefix = ""  -- 命令前缀，留空表示直接匹配关键词
local menuCommand = "菜单"  -- 触发菜单的关键词

-- 定义关键词和对应脚本的映射表
local scripts = {
    ["Ohio"] = 'loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d9e39de0725774072bbd0eb79cf424af6e84fd7bf741bd2b8779ac81c03f6907/download"))()',
    ["俄亥俄州"] = 'loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d9e39de0725774072bbd0eb79cf424af6e84fd7bf741bd2b8779ac81c03f6907/download"))()',
    ["墨水游戏"] = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))()',
}

-- 显示菜单函数
local function showMenu()
    local menuText = [[
——XIAOXI脚本查询——
1. Ohio
2. 墨水游戏
]]
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(menuText, "All")
    print(menuText)
end

-- 执行脚本函数
local function executeScript(key)
    local scriptCode = scripts[key]
    if scriptCode then
        -- 发送执行提示
        local msg = "[自动执行] 正在加载: " .. key
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        
        -- 执行脚本
        local success, err = pcall(function()
            loadstring(scriptCode)()
        end)
        
        if not success then
            warn("脚本执行失败: " .. tostring(err))
        end
    end
end

-- 监听聊天消息
local function onChatMessage(message, speaker)
    if speaker ~= Player.Name then  -- 只检测自己发的消息
        return
    end
    
    local msg = string.lower(message)
    
    -- 检查是否是菜单命令
    if msg == string.lower(menuCommand) then
        showMenu()
        return
    end
    
    -- 遍历匹配关键词
    for key, _ in pairs(scripts) do
        if msg == string.lower(key) then
            executeScript(key)
            return
        end
    end
end

-- 连接聊天事件
Player.Chatted:Connect(onChatMessage)

print("自动回复脚本已加载！")
print("发送 '菜单' 查看可用脚本")
print("发送对应关键词自动执行脚本")