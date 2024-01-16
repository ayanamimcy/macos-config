-- 自定义快捷键标准组合
local hyper = { "cmd", "alt", "ctrl"}

-- reload config
hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

-- 检测网络状态
function pingResult(object, message, seqnum, error)
    -- hs.alert.show(message)
    if message == "didFinish" then
        avg = tonumber(string.match(object:summary(), '/(%d+.%d+)/'))
        return avg
    elseif message == "sendPacketFailed" or message == "didFail" then
        return 0.0
    end
end

hs.application.enableSpotlightForNameSearches(true)
-- 对shareMouse进行处理
function openShareMouse(object, message, seqnum, error)
    local result =  pingResult(object, message, seqnum, error)
    if not(result) then return end
    local app = "ShareMouse"
    local shareMouse = hs.application.get(app) ~= nil
    if result > 0.0 then
      if not(shareMouse) then
         hs.notify.new({title="Hammerspoon", informativeText="(".. app ..") is opened, please check"}):send()
         hs.application.launchOrFocus(app)
      end
    else
        if shareMouse then
           hs.notify.new({title="Hammerspoon", informativeText="(".. app ..") is close, please check"}):send()
           hs.application.get(app):kill()
        end
    end
end

-- 定时任务，检查网络状态
--timmer = hs.timer.doEvery(20, function()
--    local hostname = "MacBook-Pro"
--    hs.network.ping.ping(hostname, 1, 0.01, 1.0, "any", openShareMouse)
--end)
--timmer:start()

local maximizeApps = {
    --"/Applications/iTerm.app",
    "/usr/local/Cellar/emacs-mac/emacs-29.1-mac-10.0/Emacs.app",
    "/Applications/Emacs.app",
    "/usr/local/opt/emacs-plus@29/Emacs.app"
    --"/System/Library/CoreServices/Finder.app",
}

local windowCreateFilter = hs.window.filter.new():setDefaultFilter()
windowCreateFilter:subscribe(
    hs.window.filter.windowCreated,
    function (win, ttl, last)
        for index, value in ipairs(maximizeApps) do
            if win:application():path() == value then
                win:maximize()
                return true
            end
        end
end)

-- 处理电源监听事件，如果是电源就开启睿频 否则关闭睿频
function powerWatch()
    local powerSorce = hs.battery.powerSource()
    if powerSorce == "AC Power" then
      os.execute("/Users/chenyangm/Library/CustomLibs/bin/voltageshift turbo 1")
    elseif powerSorce == "Battery Power" then
      os.execute("/Users/chenyangm/Library/CustomLibs/bin/voltageshift turbo 0")
    end
    os.execute("/Users/chenyangm/Library/CustomLibs/bin/voltageshift offset -100 -0 -0")
    return
end

watcher = hs.battery.watcher.new(powerWatch)
watcher:start()
-- 定时任务
hs.timer.new(30, powerWatch):start()
