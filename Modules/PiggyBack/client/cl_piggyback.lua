ESX = exports["es_extended"]:getSharedObject()

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end
function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(1, 194, true)) -- The button to display
    ButtonMessage("Arréter de porter") -- the message to display next to it
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local piggyback = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personPiggybacking = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_a",
		flag = 49,
	},
	personBeingPiggybacked = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_b",
		attachX = 0.0,
		attachY = -0.07,
		attachZ = 0.45,
		flag = 33,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

RegisterCommand("porter",function(source, args)
	if not piggyback.InProgress then
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer --[[and not IsEntityDead(GetPlayerPed(closestPlayer))]] then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				piggyback.InProgress = true
				piggyback.targetSrc = targetSrc
				TriggerServerEvent("Piggyback:sync",targetSrc)
				ensureAnimDict(piggyback.personPiggybacking.animDict)
				piggyback.type = "piggybacking"
			else
				drawNativeNotification("~r~Personne à proximité pour porter !")
			end
		else
			drawNativeNotification("~r~Personne à proximité pour porter !")
		end
	else
		piggyback.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("Piggyback:stop",piggyback.targetSrc)
		piggyback.targetSrc = 0
	end
end,false)

Citizen.CreateThread(function()
	while true do
		if IsControlJustPressed(1, 73) then
			piggyback.InProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("Piggyback:stop",piggyback.targetSrc)
			piggyback.targetSrc = 0
		end
		Wait(0)
	end
end)

RegisterNetEvent("Piggyback:syncTarget")
AddEventHandler("Piggyback:syncTarget", function(targetSrc)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	piggyback.InProgress = true
	ensureAnimDict(piggyback.personBeingPiggybacked.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, piggyback.personBeingPiggybacked.attachX, piggyback.personBeingPiggybacked.attachY, piggyback.personBeingPiggybacked.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	piggyback.type = "beingPiggybacked"
end)

RegisterNetEvent("Piggyback:cl_stop")
AddEventHandler("Piggyback:cl_stop", function()
	piggyback.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if piggyback.InProgress then
			if piggyback.type == "beingPiggybacked" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 8.0, -8.0, 100000, piggyback.personBeingPiggybacked.flag, 0, false, false, false)
				end
			elseif piggyback.type == "piggybacking" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 8.0, -8.0, 100000, piggyback.personPiggybacking.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if piggyback.InProgress then
			buttons = setupScaleform("instructional_buttons")
			DrawScaleformMovieFullscreen(buttons)
			setupScaleform("instructional_buttons")
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 56, true) -- F9
		--	DisableControlAction(0, 21, true)
--			DisableControlAction(0, 75, true)
			DisableControlAction(0, 145, true)
--			DisableControlAction(0, 185, true)
--			DisableControlAction(0, 49, true)
--			DisableControlAction(1, 75, true)
			DisableControlAction(1, 145, true)
--			DisableControlAction(1, 185, true)
--			DisableControlAction(1, 49, true)
			DisableControlAction(0, 232, true)
			DisableControlAction(0, 236, true)
			--DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 29, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 113, true)
			DisableControlAction(0, 183, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 79, true)
			DisableControlAction(0, 253, true)
			DisableControlAction(0, 324, true)
--			DisableControlAction(0, 144, true)
			DisableControlAction(0, 145, true)
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover	 
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 289, true) -- F2
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 167, true) -- F6
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 38, true) -- Disable clearing animation
			DisableControlAction(1, 38, true) -- Disable pause screen
			DisableControlAction(2, 38, true) -- Disable clearing animation

			DisableControlAction(0, 51, true) -- Disable clearing animation
			DisableControlAction(1, 51, true) -- Disable pause screen
			DisableControlAction(2, 51, true) -- Disable clearing animation

		--	DisableControlAction(0, 75, true) -- Disable pause screen
		end
		Wait(0)
	end
end)