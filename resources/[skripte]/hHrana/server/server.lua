ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('devcore_needs:client:UpdateStatus')
AddEventHandler('devcore_needs:client:UpdateStatus', function(type, count)
	
	TriggerClientEvent('esx_status:add', source, type, count)

end)


-- Food
for i=1, #Config.Food, 1 do

	ESX.RegisterUsableItem(Config.Food[i].Item, function(source)
		src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local item     = Config.Food[i].Item
		local label     = Config.Food[i].Label
		local g     = Config.Food[i].g
		local prop     = Config.Food[i].Prop
		local proppos1 = Config.Food[i].Pos1
		local proppos2 = Config.Food[i].Pos2
		local proppos3 = Config.Food[i].Pos3
		local proppos4 = Config.Food[i].Pos4
		local proppos5 = Config.Food[i].Pos5
		local proppos6 = Config.Food[i].Pos6
		local hunger = Config.Food[i].StatusHunger
	
		TriggerClientEvent('devcore_needs:client:StartEat', src, item, label, g, prop, hunger, proppos1, proppos2, proppos3, proppos4, proppos5, proppos6)
			--xPlayer.removeInventoryItem(item, 1)
			end)
	end

--Drink
	for i=1, #Config.Drink, 1 do

		ESX.RegisterUsableItem(Config.Drink[i].Item, function(source)
			src = source
			local xPlayer = ESX.GetPlayerFromId(src)
			local item     = Config.Drink[i].Item
			local cleanupitem     = Config.Drink[i].CleanUpItem
			local ml     = Config.Drink[i].ml
			local prop     = Config.Drink[i].Prop
			local proppos1 = Config.Drink[i].Pos1
			local proppos2 = Config.Drink[i].Pos2
			local proppos3 = Config.Drink[i].Pos3
			local proppos4 = Config.Drink[i].Pos4
			local proppos5 = Config.Drink[i].Pos5
			local proppos6 = Config.Drink[i].Pos6
			local alcohol = Config.Drink[i].Alcohol
			local split = Config.Drink[i].Shots
			local drinkstatus =	Config.Drink[i].StatusDrink
		
			TriggerClientEvent('devcore_needs:client:StartDrink', src, item, cleanupitem, ml, prop, alcohol, split, drinkstatus, proppos1, proppos2, proppos3, proppos4, proppos5, proppos6)
				--xPlayer.removeInventoryItem(item, 1)
				end)
		end


		--DrinkShot
	for i=1, #Config.DrinkShot, 1 do

		ESX.RegisterUsableItem(Config.DrinkShot[i].Item, function(source)
			src = source
			local xPlayer = ESX.GetPlayerFromId(src)
			local item     = Config.DrinkShot[i].Item
			local label     = Config.DrinkShot[i].Label
			local mlshot     = Config.DrinkShot[i].mlshot
			local alcohol = Config.DrinkShot[i].Alcohol
			local drinkstatus = Config.DrinkShot[i].StatusDrink
		
			TriggerClientEvent('devcore_needs:client:DrinkShot', src, item, label, shotml, alcohol, drinkstatus)
				--xPlayer.removeInventoryItem(item, 1)
				end)
		end

--Wine
for i=1, #Config.Wine, 1 do

	ESX.RegisterUsableItem(Config.Wine[i].Item, function(source)
		src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local item     = Config.Wine[i].Item
		local item2     = Config.Wine[i].CleanUpItem
		local ml     = Config.Wine[i].ml
		local prop     = Config.Wine[i].Prop
		local proppos1 = Config.Wine[i].Pos1
		local proppos2 = Config.Wine[i].Pos2
		local proppos3 = Config.Wine[i].Pos3
		local proppos4 = Config.Wine[i].Pos4
		local proppos5 = Config.Wine[i].Pos5
		local proppos6 = Config.Wine[i].Pos6
		local alcohol = Config.Wine[i].Alcohol
		local drinkstatus = Config.Wine[i].StatusDrink
	
		TriggerClientEvent('devcore_needs:client:StartDrinkWine', src, item, item2, ml, prop, alcohol, drinkstatus, proppos1, proppos2, proppos3, proppos4, proppos5, proppos6)
			--xPlayer.removeInventoryItem(item, 1)
			end)
	end

			--WineGlass
for i=1, #Config.WineGlass, 1 do

	ESX.RegisterUsableItem(Config.WineGlass[i].Item, function(source)
		src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local item     = Config.WineGlass[i].Item
		local label     = Config.WineGlass[i].Label
		local mlwine     = Config.WineGlass[i].mlwine
		local alcohol = Config.WineGlass[i].Alcohol
		local drinkstatus = Config.WineGlass[i].StatusDrink
				
		TriggerClientEvent('devcore_needs:client:WineGlass', src, item, label, mlwine, alcohol, drinkstatus)
			--xPlayer.removeInventoryItem(item, 1)
			end)
		end

--alcotester
		ESX.RegisterUsableItem(Config.ItemTester, function(source)
			src = source
			local xPlayer = ESX.GetPlayerFromId(src)
					
			TriggerClientEvent('devcore_needs:client:alcotester', src)

		end)

			RegisterServerEvent('devcore_needs:server:AlcoTest')
		AddEventHandler('devcore_needs:server:AlcoTest', function(ID, targetID)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source

			TriggerClientEvent('devcore_needs:client:ShowAlco', _source)
		end)

		RegisterServerEvent('devcore_needs:server:ReceiverFood')
		AddEventHandler('devcore_needs:server:ReceiverFood', function(ID, targetID, item, label, g, prop, hunger, p1, p2, p3, p4, p5, p6)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source

			TriggerClientEvent('devcore_needs:client:StartReceiverEat', _source, item, label, g, prop, hunger, p1 , p2 , p3, p4 , p5 , p6)
		end)
		
		RegisterServerEvent('devcore_needs:server:ReceiverDrink')
		AddEventHandler('devcore_needs:server:ReceiverDrink', function(ID, targetID, item, item2, ml, propdrink, alcohol, split, drinkstatus, p1, p2, p3, p4, p5, p6)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source

			TriggerClientEvent('devcore_needs:client:StartReceiverDrink', _source, item, item2, ml, propdrink, alcohol, split, drinkstatus, p1, p2, p3, p4, p5, p6)
		end)

		RegisterServerEvent('devcore_needs:server:ReceiverDrinkShot')
		AddEventHandler('devcore_needs:server:ReceiverDrinkShot', function(ID, targetID, item, item2, mlshot, alcohol, drinkstatus)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source
			
			TriggerClientEvent('devcore_needs:client:ReceiverDrinkShot', _source, item, item2, mlshot, alcohol, drinkstatus)
		end)

		RegisterServerEvent('devcore_needs:server:ReceiverDrinkWine')
		AddEventHandler('devcore_needs:server:ReceiverDrinkWine', function(ID, targetID, item, label, ml, propw, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source

			TriggerClientEvent('devcore_needs:client:ReceiverDrinkGlass', _source, item, label, ml, propw, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
		end)

		RegisterServerEvent('devcore_needs:server:ReceiverDrinkSplitWine')
		AddEventHandler('devcore_needs:server:ReceiverDrinkSplitWine', function(ID, targetID, item, item2, ml, propw, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source

			TriggerClientEvent('devcore_needs:client:ReceiverDrinkSplitWine', _source, item, item2, ml, propw, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
		end)

		RegisterServerEvent('devcore_needs:server:ReceiverDrinkGlass')
		AddEventHandler('devcore_needs:server:ReceiverDrinkGlass', function(ID, targetID, item, item2, mlwine, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
			local identifier = ESX.GetPlayerFromId(ID).identifier
			local _source 	 = ESX.GetPlayerFromId(targetID).source
			
			TriggerClientEvent('devcore_needs:client:ReceiverDrinkGlass', _source, item, item2, mlwine, alcohol, drinkstatus, p1, p2, p3, p4, p5, p6)
		end)

	RegisterServerEvent('devcore_needs:server:RemoveItem')
AddEventHandler('devcore_needs:server:RemoveItem', function(item)
	src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('devcore_needs:server:AddItem')
AddEventHandler('devcore_needs:server:AddItem', function(item)
	src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addInventoryItem(item, 1)
end)

RegisterCommand("heal", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() ~= "user" then
	  if xPlayer.proveriDuznost() == true then
	  if args[1] ~= nil then
	  if GetPlayerName(tonumber(args[1])) ~= nil then
	  TriggerClientEvent('esx_basicneeds:healPlayer', tonumber(args[1]))
	  TriggerClientEvent('dark:client:notify', source, "Heal si igraca " .. GetPlayerName(tonumber(args[1])), 3)
	  heal("**HEAL**", GetPlayerName(source) .. " je heal coveka " .. GetPlayerName(tonumber(args[1])))
	  end
  else
	  TriggerClientEvent('esx_basicneeds:healPlayer', source)
	  TriggerClientEvent('dark:client:notify', source, "Heal si se", 3)
	  heal("**HEAL**", GetPlayerName(source) .. " se heal" )
  end
  else
	TriggerClientEvent('dark:client:notify', source, "Nisi na admin duznosti", 2)
	end
	else
		TriggerClientEvent('dark:client:notify', source, "Nemate dozvolu za ovu komandu", 2)
	end
  end)

  function heal(name, message)
    local poruka = {
        {
            ["color"] = 16711680,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "HUB | Heal",
            },
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/990252847398518835/e03KwwvqkKVM7YPgKagTBIFZHtcImAnxFiFzcOB3xLSOYUyZAh5HJ563N0UQpsnuwdq1", function(err, text, headers) end, 'POST', json.encode({username = "HUB | Markeri Logovi ????", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end
