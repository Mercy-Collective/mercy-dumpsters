local RequestedModules = { 'Events', 'Callback', 'Player' }
local Modules = {}

local _Ready = false
AddEventHandler('Modules/server/ready', function()
    TriggerEvent('Modules/server/request-dependencies', RequestedModules, function(Succeeded)
        if not Succeeded then return end
        for _, Module in pairs(RequestedModules) do
            Modules[Module] = exports['mercy-base']:FetchModule(Module)
        end
        _Ready = true
    end)
end)

-- [ Code ] --

CreateThread(function() 
    while not _Ready do 
        Wait(4) 
    end 

    Modules.Callback.CreateCallback('mercy-dumpsters/server/is-dumpster-searched', function(Source, Cb, NetId)
        Cb(ServerConfig.OpenedDumpsters[NetId] ~= nil and ServerConfig.OpenedDumpsters[NetId] or false)
    end)

    Modules.Events.RegisterServer("mercy-dumpsters/server/search-dumpster", function(Source, NetId)
        local Player = Modules.Player.GetPlayerBySource(Source)
        if not Player then return end

        local RandomChance = math.random(1, 100) -- 1-100
        local RandomAmount = math.random(1, 10) -- 1-10
        local RandomItem = ServerConfig.DumpsterItems[math.random(1, #ServerConfig.DumpsterItems)]

        -- Loot chances
        if RandomChance <= 55 then
            Player.Functions.AddItem(RandomItem, RandomAmount, false, {}, true)
        elseif RandomChance >= 87 and RandomChance <= 89 then
            -- Change to Rare item?
            Player.Functions.AddItem(RandomItem, RandomAmount, false, {}, true)
        else
            Player.Functions.Notify('no-item', 'You did not find anything..', 'error')
        end

        -- Set the dumpster as searched
        ServerConfig.OpenedDumpsters[NetId] = true
        SetTimeout((60 * 1000) * ServerConfig.ResetTime, function() -- Reset after x minutes
            ServerConfig.OpenedDumpsters[NetId] = nil
        end)
    end)
end)