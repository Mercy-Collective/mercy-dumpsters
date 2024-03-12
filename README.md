# mercy-dumpsters

This resource is made for the **Mercy Framework**, if you need any help please join our [discord server](https://dsc.gg/mercy-coll) for support.

## DEPENDENCY
- [Mercy Framework](https://github.com/Mercy-Collective/mercy-framework)

## Credits
This resource has been created by **Mercy Collective**.


## REQUIREMENTS

# Disable following code in mercy-jobs/client/jobcenter/cl_sanitation.lua 
```lua
    for k, v in pairs(Dumpsters) do
        exports['mercy-ui']:AddEyeEntry(GetHashKey(v), {
            Type = 'Model',
            Model = v,
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
                }
            }
        })
    end
```