ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local stash = {
	{
    	id = 'zmehanicar',
    	label = 'Mehanicar Sef',
    	slots = 150,
    	weight = 1000000,
	},
	{
    	id = 'pmehanicar',
    	label = 'Mehanicar Sef',
    	slots = 150,
    	weight = 1000000,
	}
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		for k,v in pairs(stash) do
        	exports.ox_inventory:RegisterStash(v.id, v.label, v.slots, v.weight)
		end
    end
end)