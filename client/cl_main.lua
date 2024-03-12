local RequestedModules = { 'Events', 'Callback', }
local Modules = {}

local _Ready = false
AddEventHandler('Modules/client/ready', function()
    if not _Ready then
        _Ready = true
    end
    TriggerEvent('Modules/client/request-dependencies', RequestedModules, function(Succeeded)
        if not Succeeded then return end
        for _, Module in pairs(RequestedModules) do
            Modules[Module] = exports['mercy-base']:FetchModule(Module)
        end
    end)
end)

-- [ Code ] --

RegisterNetEvent('mercy-base/client/on-login', function()
    SetTimeout(350, function()
        InitDumpsters()
    end)
end)

-- [ Functions ] --

function InitDumpsters()
    for k, DModel in pairs(Config.Dumpsters) do
        exports['mercy-ui']:AddEyeEntry(GetHashKey(DModel), {
            Type = 'Model',
            Model = DModel,
            SpriteDistance = 3.0,
            Options = {
                {
                    Name = 'sanitation_pickup_trash',
                    Icon = 'fas fa-circle',
                    Label = 'Pickup Trash',
                    EventType = 'Client',
                    EventName = 'mercy-jobs/client/sanitation/pickup-trash',
                    EventParams = '',
                    Enabled = function(Entity)
                        return (exports['mercy-phone']:IsJobCenterTaskActive('sanitation', 4) or exports['mercy-phone']:IsJobCenterTaskActive('sanitation', 6))
                    end,
                },
                {
                    Name = 'search_dumpster',
                    Icon = 'fas fa-trash-alt',
                    Label = 'Search',
                    EventType = 'Client',
                    EventName = 'mercy-dumpsters/client/search-dumpster',
                    EventParams = {['Model'] = DModel},
                    Enabled = function(Entity)
                        return true
                    end,
                },
            }
        })
    end
    DebugPrint('Dumpsters Initialized..')
end

function DebugPrint(Text)
    if Config.Debug then
        print('^1[DEBUG]^7 ' .. Text)
    end
end

-- [ Events ] --

RegisterNetEvent("mercy-dumpsters/client/search-dumpster", function(Data, Entity)
    local IsSearched = Modules.Callback.SendCallback('mercy-dumpsters/server/is-dumpster-searched', ObjToNet(Entity))
    DebugPrint('Already Searched: ' .. tostring(IsSearched))
    local Type = string.find(Data.Model, 'binbag') and 'bag' or string.find(Data.Model, 'bin') and 'bin' or 'dumpster'
    if IsSearched then
        return exports['mercy-ui']:Notify('already-searched', 'This '..Type..' is empty..', 'error')
    end
    exports['mercy-inventory']:SetBusyState(true)
    exports['mercy-ui']:ProgressBar('Searching '..Type..'...', Config.SearchTime, {
        ['AnimDict'] = 'mini@repair',
        ['AnimName'] = 'fixing_a_ped',
        ['AnimFlag'] = 0,
    }, false, true, false, function(DidComplete)
        exports['mercy-inventory']:SetBusyState(false)
        DebugPrint('Did Complete: ' .. tostring(DidComplete))
        if DidComplete then
            DebugPrint('Searching completed.. giving reward..')
            Modules.Events.TriggerServer('mercy-dumpsters/server/search-dumpster', ObjToNet(Entity))
        end
        SetTimeout(250, function()
            StopAnimTask(PlayerPedId(), "mini@repair" ,"fixing_a_ped", 1.0)
            ClearPedTasks(PlayerPedId())
        end)
    end)
end)

-- [ Cleanup ] --

AddEventHandler('onResourceStop', function(Resource)
    if Resource ~= GetCurrentResourceName() then return end
    DebugPrint('Stopping resource.. removing eye entries..')
    for _, DModel in pairs(Config.Dumpsters) do
        exports['mercy-ui']:RemoveEyeEntry(GetHashKey(DModel), 'Model')
    end
end)