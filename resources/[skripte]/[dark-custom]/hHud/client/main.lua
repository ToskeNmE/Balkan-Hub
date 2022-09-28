ESX = nil
local igracucitan = false

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
       
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    SetBigmapActive(false, false)
    ESX.PlayerData = ESX.GetPlayerData()
        igracucitan = true

        Citizen.Wait(1000)
        SendNUIMessage(
            {
                type = "pokazi",
                value = true
            }
        )
    end
)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if igracucitan and not IsPauseMenuActive() then
            local moneyTable = {
                bank = 0,
                money = 0,
                black_money = 0
            }

            SetBigmapActive(false, false)
            for i=1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'bank' then
                    moneyTable.bank = ESX.PlayerData.accounts[i].money
                elseif ESX.PlayerData.accounts[i].name == 'black_money' then
                    moneyTable.black_money = ESX.PlayerData.accounts[i].money
                elseif ESX.PlayerData.accounts[i].name == 'money' then
                    moneyTable.money = ESX.PlayerData.accounts[i].money
                end
            end
            SendNUIMessage({action = 'setMoney', value = moneyTable})
            SendNUIMessage({action = 'job', value =  ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label})
            ESX.TriggerServerCallback("hub_hud:nesto", function(online)
                SendNUIMessage(
                    {
                        type = "update",
                        online = online or 0,
                        id = GetPlayerServerId(PlayerId()) or 0,
                    }
                )
            end)
        else
            SendNUIMessage(
                {
                    type = "pokazi",
                    value = false
                }
            )
        end
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for i=1, #ESX.PlayerData.accounts, 1 do
        if ESX.PlayerData.accounts[i].name == account.name then
            ESX.PlayerData.accounts[i] = account
            break
        end
    end
end)

------- REFRESH FUNKCIJE

RegisterCommand('ui', function()
	if not toggleui then
        SendNUIMessage({action = 'neprikazi'})
        DisplayRadar(false)
	else

        DisplayRadar(not display)
        SendNUIMessage({action = 'show'})
	end

	toggleui = not toggleui
end)

RegisterNetEvent("hub_hud2:skloni")
AddEventHandler("hub_hud2:skloni", function()
    SendNUIMessage({action = 'neprikazi'})
end)

RegisterNetEvent("hub_hud2:pokazi")
AddEventHandler("hub_hud2:pokazi", function()
    SendNUIMessage({action = 'show'})
end)