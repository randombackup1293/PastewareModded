repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary

local function run(func)
	local suc, err = pcall(function()
		func()
	end)
	if err then warn("[VW687224481.lua Module Error]: "..tostring(debug.traceback(err))) end
end
local GuiLibrary = shared.GuiLibrary
local store = shared.GlobalStore
local bedwars = shared.GlobalBedwars
local playersService = game:GetService("Players")
if (not shared.GlobalBedwars) or (shared.GlobalBedwars and type(shared.GlobalBedwars) ~= "table") or (not shared.GlobalStore) or (shared.GlobalStore and type(shared.GlobalStore) ~= "table") then
	errorNotification("VW-BEDWARS", "Critical! Important connection is missing! Please report this bug to erchodev#0", 10)
	pcall(function()
		GuiLibrary.SaveSettings = function() warningNotification("GuiLibrary.SaveSettings", "Profiles saving is disabled due to error in the code!") end
	end)
	local delfile = delfile or function(file) writefile(file, "") end
	if isfile('vape/CustomModules/6872274481.lua') then delfile('vape/CustomModules/6872274481.lua') end
end
local entityLibrary = shared.vapeentity
local RunLoops = shared.RunLoops
local VoidwareStore = {
	bedtable = {},
	Tweening = false
}

VoidwareFunctions.GlobaliseObject("lplr", game:GetService("Players").LocalPlayer)
VoidwareFunctions.LoadFunctions("Bedwars")

local function BedwarsInfoNotification(mes)
    local bedwars = shared.GlobalBedwars
	local NotificationController = bedwars.NotificationController
	NotificationController:sendInfoNotification({
		message = tostring(mes),
		image = "rbxassetid://18518244636"
	});
end
getgenv().BedwarsInfoNotification = BedwarsInfoNotification
local function BedwarsErrorNotification(mes)
    local bedwars = shared.GlobalBedwars
	local NotificationController = bedwars.NotificationController
	NotificationController:sendErrorNotification({
		message = tostring(mes),
		image = "rbxassetid://18518244636"
	});
end
getgenv().BedwarsErrorNotification = BedwarsErrorNotification

local gameCamera = game.Workspace.CurrentCamera

local lplr = game:GetService("Players").LocalPlayer

local btext = function(text)
	return text..' '
end
local void = function() end
local runservice = game:GetService("RunService")
local newcolor = function() return {Hue = 0, Sat = 0, Value = 0} end
function safearray()
    local array = {}
    local mt = {}
    function mt:__index(index)
        if type(index) == "number" and (index < 1 or index > #array) then
            return nil
        end
        return array[index]
    end
    function mt:__newindex(index, value)
        if type(index) == "number" and index > 0 then
            array[index] = value
        else
            error("Invalid index for safearray", 2)
        end
    end
    function mt:insert(value)
        table.insert(array, value)
    end
    function mt:remove(index)
        if type(index) == "number" and index > 0 and index <= #array then
            table.remove(array, index)
        else
            error("Invalid index for safearray removal", 2)
        end
    end
    function mt:length()
        return #array
	end
    setmetatable(array, mt)
    return array
end
function getrandomvalue(list)
    local count = #list
    if count == 0 then
        return ''
    end
    local randomIndex = math.random(1, count)
    return list[randomIndex]
end

local vapeConnections
if shared.vapeConnections and type(shared.vapeConnections) == "table" then vapeConnections = shared.vapeConnections else vapeConnections = {} shared.vapeConnections = vapeConnections end

GuiLibrary.SelfDestructEvent.Event:Connect(function()
	for i, v in pairs(vapeConnections) do
		if v.Disconnect then pcall(function() v:Disconnect() end) continue end
		if v.disconnect then pcall(function() v:disconnect() end) continue end
	end
end)
local whitelist = shared.vapewhitelist

task.spawn(function()
    pcall(function()
        local lplr = game:GetService("Players").LocalPlayer
        local char = lplr.Character or lplr.CharacterAdded:wait()
        local displayName = char:WaitForChild("Head"):WaitForChild("Nametag"):WaitForChild("DisplayNameContainer"):WaitForChild("DisplayName")
        repeat task.wait() until shared.vapewhitelist
        repeat task.wait() until shared.vapewhitelist.loaded
        local tag = shared.vapewhitelist:tag(lplr, "", true)
        if displayName.ClassName == "TextLabel" then
            if not displayName.RichText then displayName.RichText = true end
            displayName.Text = tag..lplr.Name
        end
        displayName:GetPropertyChangedSignal("Text"):Connect(function()
            if displayName.Text ~= tag..lplr.Name then
                displayName.Text = tag..lplr.Name
            end
        end)
    end)
end)

local GetEnumItems = function() return {} end
	GetEnumItems = function(enum)
		local fonts = {}
		for i,v in next, Enum[enum]:GetEnumItems() do 
			table.insert(fonts, v.Name) 
		end
		return fonts
	end

run(function()
	local QueueCardMods = {}
	local QueueCardGradientToggle = {}
	local QueueCardGradient = {Hue = 0, Sat = 0, Value = 0}
	local QueueCardGradient2 = {Hue = 0, Sat = 0, Value = 0}
	local function patchQueueCard()
		if lplr.PlayerGui:FindFirstChild('QueueApp') then 
			if lplr.PlayerGui.QueueApp:WaitForChild('1'):IsA('Frame') then 
                if shared.RiseMode and GuiLibrary.MainColor then
                    lplr.PlayerGui.QueueApp['1'].BackgroundColor3 = GuiLibrary.MainColor
                else
				    lplr.PlayerGui.QueueApp['1'].BackgroundColor3 = Color3.fromHSV(QueueCardGradient.Hue, QueueCardGradient.Sat, QueueCardGradient.Value)
                end
			end
            for i = 1, 3 do
                if QueueCardGradientToggle.Enabled then 
                    lplr.PlayerGui.QueueApp['1'].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    local gradient = (lplr.PlayerGui.QueueApp['1']:FindFirstChildWhichIsA('UIGradient') or Instance.new('UIGradient', lplr.PlayerGui.QueueApp['1']))
                    if shared.RiseMode and GuiLibrary.MainColor and GuiLibrary.SecondaryColor then
                        local v = {GuiLibrary.MainColor, GuiLibrary.SecondaryColor, GuiLibrary.ThirdColor}
                        print(encode(v))
                        if v[3] then 
                            gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, v[1]), ColorSequenceKeypoint.new(0.5, v[2]), ColorSequenceKeypoint.new(1, v[3])})
                        else
                            gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, v[1]), ColorSequenceKeypoint.new(1, v[2])})
                        end
                    else
                        gradient.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromHSV(QueueCardGradient.Hue, QueueCardGradient.Sat, QueueCardGradient.Value)), 
                            ColorSequenceKeypoint.new(1, Color3.fromHSV(QueueCardGradient2.Hue, QueueCardGradient2.Sat, QueueCardGradient2.Value))
                        })
                    end
                end
                task.wait()
            end
		end
	end
	QueueCardMods = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'QueueCardMods',
		HoverText = 'Mods the QueueApp at the end of the game.',
		Function = function(calling) 
			if calling then 
				patchQueueCard()
				table.insert(QueueCardMods.Connections, lplr.PlayerGui.ChildAdded:Connect(patchQueueCard))
			end
		end
	})
    QueueCardGradientToggle = QueueCardMods.CreateToggle({
        Name = 'Gradient',
        Function = function(calling)
            pcall(function() QueueCardGradient2.Object.Visible = calling end) 
        end
    })
    if (not shared.RiseMode) and not GuiLibrary.MainColor and not GuiLibrary.SecondaryColor then
        QueueCardGradient = QueueCardMods.CreateColorSlider({
            Name = 'Color',
            Function = function()
                pcall(patchQueueCard)
            end
        })
        QueueCardGradient2 = QueueCardMods.CreateColorSlider({
            Name = 'Color 2',
            Function = function()
                pcall(patchQueueCard)
            end
        })
    else
		if shared.RiseMode then
			pcall(function()
				GuiLibrary.GUIColorChanged.Event:Connect(function()
					pcall(patchQueueCard)
				end)
			end)
		end
    end
end)

run(function()
    local tppos2 = nil
    local TweenSpeed = 0.7
    local HeightOffset = 5
    local BedTP = {}

    local function teleportWithTween(char, destination)
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            destination = destination + Vector3.new(0, HeightOffset, 0)
            local currentPosition = root.Position
            if (destination - currentPosition).Magnitude > 0.5 then
                local tweenInfo = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local goal = {CFrame = CFrame.new(destination)}
                local tween = TweenService:Create(root, tweenInfo, goal)
                tween:Play()
                tween.Completed:Wait()
				BedTP.ToggleButton(false)
            end
        end
    end

    local function killPlayer(player)
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end

    local function getEnemyBed(range)
        range = range or math.huge
        local bed = nil
        local player = lplr

        if not isAlive(player, true) then 
            return nil 
        end

        local localPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.zero
        local playerTeam = player:GetAttribute('Team')
        local beds = collectionService:GetTagged('bed')

        for _, v in ipairs(beds) do 
            if v:GetAttribute('PlacedByUserId') == 0 then
                local bedTeam = v:GetAttribute('id'):sub(1, 1)
                if bedTeam ~= playerTeam then 
                    local bedPosition = v.Position
                    local bedDistance = (localPos - bedPosition).Magnitude
                    if bedDistance < range then 
                        bed = v
                        range = bedDistance
                    end
                end
            end
        end

        if not bed then 
            warningNotification("BedTP", 'No enemy beds found. Total beds: '..#beds, 5)
        else
            --warningNotification("BedTP", 'Teleporting to bed at position: '..tostring(bed.Position), 3)
			warningNotification("BedTP", 'Teleporting to bed at position: '..tostring(bed.Position), 3)
        end

        return bed
    end

    BedTP = GuiLibrary["ObjectsThatCanBeSaved"]["TPWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "BedTP",
        ["Function"] = function(callback)
            if callback then
				task.spawn(function()
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled and GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("BedTP", "Please turn off the Invisibility and GamingChair module!", 3)
						BedTP.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled then
						errorNotification("BedTP", "Please turn off the Invisibility module!", 3)
						BedTP.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("BedTP", "Please turn off the GamingChair module!", 3)
						BedTP.ToggleButton()
						return
					end
					table.insert(BedTP.Connections, lplr.CharacterAdded:Connect(function(char)
						if tppos2 then 
							task.spawn(function()
								local root = char:WaitForChild("HumanoidRootPart", 9000000000)
								if root and tppos2 then 
									teleportWithTween(char, tppos2)
									tppos2 = nil
								end
							end)
						end
					end))
					local bed = getEnemyBed()
					if bed then 
						tppos2 = bed.Position
						killPlayer(lplr)
					else
						BedTP.ToggleButton(false)
					end
				end)
            end
        end
    })
end)

run(function()
	local TweenService = game:GetService("TweenService")
	local playersService = game:GetService("Players")
	local lplr = playersService.LocalPlayer
	
	local tppos2
	local deathtpmod = {["Enabled"] = false}
	local TweenSpeed = 0.7
	local HeightOffset = 5

	local function teleportWithTween(char, destination)
		local root = char:FindFirstChild("HumanoidRootPart")
		if root then
			destination = destination + Vector3.new(0, HeightOffset, 0)
			local currentPosition = root.Position
			if (destination - currentPosition).Magnitude > 0.5 then
				local tweenInfo = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local goal = {CFrame = CFrame.new(destination)}
				local tween = TweenService:Create(root, tweenInfo, goal)
				tween:Play()
				tween.Completed:Wait()
			end
		end
	end

	local function killPlayer(player)
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end
	end

	local function onCharacterAdded(char)
		if tppos2 then 
			task.spawn(function()
				local root = char:WaitForChild("HumanoidRootPart", 9000000000)
				if root and tppos2 then 
					teleportWithTween(char, tppos2)
					tppos2 = nil
				end
			end)
		end
	end

	vapeConnections[#vapeConnections + 1] = lplr.CharacterAdded:Connect(onCharacterAdded)

	local function setTeleportPosition()
		local UserInputService = game:GetService("UserInputService")
		local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

		if isMobile then
			warningNotification("DeathTP", "Please tap on the screen to set TP position.", 3)
			local connection
			connection = UserInputService.TouchTapInWorld:Connect(function(inputPosition, processedByUI)
				if not processedByUI then
					local mousepos = lplr:GetMouse().UnitRay
					local rayparams = RaycastParams.new()
					rayparams.FilterDescendantsInstances = {game.Workspace.Map, game.Workspace:FindFirstChild("SpectatorPlatform")}
					rayparams.FilterType = Enum.RaycastFilterType.Whitelist
					local ray = game.Workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
					if ray then 
						tppos2 = ray.Position 
						warningNotification("DeathTP", "Set TP Position. Resetting to teleport...", 3)
						killPlayer(lplr)
					end
					connection:Disconnect()
					deathtpmod["ToggleButton"](false)
				end
			end)
		else
			local mousepos = lplr:GetMouse().UnitRay
			local rayparams = RaycastParams.new()
			rayparams.FilterDescendantsInstances = {game.Workspace.Map, game.Workspace:FindFirstChild("SpectatorPlatform")}
			rayparams.FilterType = Enum.RaycastFilterType.Whitelist
			local ray = game.Workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
			if ray then 
				tppos2 = ray.Position 
				warningNotification("DeathTP", "Set TP Position. Resetting to teleport...", 3)
				killPlayer(lplr)
			end
			deathtpmod["ToggleButton"](false)
		end
	end

	deathtpmod = GuiLibrary["ObjectsThatCanBeSaved"]["TPWindow"]["Api"].CreateOptionsButton({
		["Name"] = "DeathTP",
		["Function"] = function(calling)
			if calling then
				task.spawn(function()
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled and GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("DeathTP", "Please turn off the Invisibility and GamingChair module!", 3)
						deathtpmod.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled then
						errorNotification("DeathTP", "Please turn off the Invisibility module!", 3)
						deathtpmod.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("DeathTP", "Please turn off the GamingChair module!", 3)
						deathtpmod.ToggleButton()
						return
					end
					local canRespawn = function() end
					canRespawn = function()
						local success, response = pcall(function() 
							return lplr.leaderstats.Bed.Value == '✅' 
						end)
						return success and response 
					end
					if not canRespawn() then 
						warningNotification("DeathTP", "Unable to use DeathTP without bed!", 5)
						deathtpmod.ToggleButton()
					else
						setTeleportPosition()
					end
				end)
			end
		end
	})
end)

run(function()
	local PlayerTP = {}
	local PlayerTPTeleport = {Value = 'Respawn'}
	local PlayerTPSort = {Value = 'Distance'}
	local PlayerTPMethod = {Value = 'Linear'}
	local PlayerTPAutoSpeed = {}
	local PlayerTPSpeed = {Value = 200}
	local PlayerTPTarget = {Value = ''}
	local playertween
	local oldmovefunc
	local bypassmethods = {
		Respawn = function() 
			if isEnabled('InfiniteFly') then 
				return 
			end
			if not canRespawn() then 
				return 
			end
			for i = 1, 30 do 
				if isAlive(lplr, true) and lplr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
					lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
					lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
				end
			end
			lplr.CharacterAdded:Wait()
			repeat task.wait() until isAlive(lplr, true) 
			task.wait(0.1)
			local target = GetTarget(nil, PlayerTPSort.Value == 'Health', true)
			if target.RootPart == nil or not PlayerTP.Enabled then 
				return
			end
			local localposition = lplr.Character.HumanoidRootPart.Position
			local tweenspeed = (PlayerTPAutoSpeed.Enabled and ((target.RootPart.Position - localposition).Magnitude / 470) + 0.001 * 2 or (PlayerTPSpeed.Value / 1000) + 0.1)
			local tweenstyle = (PlayerTPAutoSpeed.Enabled and Enum.EasingStyle.Linear or Enum.EasingStyle[PlayerTPMethod.Value])
			playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(tweenspeed, tweenstyle), {CFrame = target.RootPart.CFrame}) 
			playertween:Play() 
			playertween.Completed:Wait()
		end,
		Instant = function() 
			local target = GetTarget(nil, PlayerTPSort.Value == 'Health', true)
			if target.RootPart == nil then 
				return PlayerTP.ToggleButton()
			end
			lplr.Character.HumanoidRootPart.CFrame = (target.RootPart.CFrame + Vector3.new(0, 5, 0)) 
			PlayerTP.ToggleButton()
		end,
		Recall = function()
			if not isAlive(lplr, true) or lplr.Character.Humanoid.FloorMaterial == Enum.Material.Air then 
				errorNotification('PlayerTP', 'Recall ability not available.', 7)
				return 
			end
			if not bedwars.AbilityController:canUseAbility('recall') then 
				errorNotification('PlayerTP', 'Recall ability not available.', 7)
				return
			end
			pcall(function()
				oldmovefunc = require(lplr.PlayerScripts.PlayerModule).controls.moveFunction 
				require(lplr.PlayerScripts.PlayerModule).controls.moveFunction = function() end
			end)
			bedwars.AbilityController:useAbility('recall')
			local teleported
			table.insert(PlayerTP.Connections, lplr:GetAttributeChangedSignal('LastTeleported'):Connect(function() teleported = true end))
			repeat task.wait() until teleported or not PlayerTP.Enabled or not isAlive(lplr, true) 
			task.wait()
			local target = GetTarget(nil, PlayerTPSort.Value == 'Health', true)
			if target.RootPart == nil or not isAlive(lplr, true) or not PlayerTP.Enabled then 
				return
			end
			local localposition = lplr.Character.HumanoidRootPart.Position
			local tweenspeed = (PlayerTPAutoSpeed.Enabled and ((target.RootPart.Position - localposition).Magnitude / 1000) + 0.001 or (PlayerTPSpeed.Value / 1000) + 0.1)
			local tweenstyle = (PlayerTPAutoSpeed.Enabled and Enum.EasingStyle.Linear or Enum.EasingStyle[PlayerTPMethod.Value])
			playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(tweenspeed, tweenstyle), {CFrame = target.RootPart.CFrame}) 
			playertween:Play() 
			playertween.Completed:Wait()
		end
	}
	PlayerTP = GuiLibrary.ObjectsThatCanBeSaved.TPWindow.Api.CreateOptionsButton({
		Name = 'PlayerTP',
		HoverText = 'Tweens you to a nearby target.',
		Function = function(calling)
			if calling then 
				task.spawn(function()
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled and GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("PlayerTP", "Please turn off the Invisibility and GamingChair module!", 3)
						PlayerTP.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled then
						errorNotification("PlayerTP", "Please turn off the Invisibility module!", 3)
						PlayerTP.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("PlayerTP", "Please turn off the GamingChair module!", 3)
						PlayerTP.ToggleButton()
						return
					end
					if GetTarget(nil, PlayerTPSort.Value == 'Health', true).RootPart and shared.VapeFullyLoaded then 
						bypassmethods[isAlive() and PlayerTPTeleport.Value or 'Respawn']() 
					else
						InfoNotification("PlayerTP", "No player/s found!", 3)
					end
					if PlayerTP.Enabled then 
						PlayerTP.ToggleButton()
					end
				end)
			else
				pcall(function() playertween:Disconnect() end)
				if oldmovefunc then 
					pcall(function() require(lplr.PlayerScripts.PlayerModule).controls.moveFunction = oldmovefunc end)
				end
				oldmovefunc = nil
			end
		end
	})
	PlayerTPTeleport = PlayerTP.CreateDropdown({
		Name = 'Teleport Method',
		List = {'Respawn', 'Recall'},
		Function = function() end
	})
	PlayerTPAutoSpeed = PlayerTP.CreateToggle({
		Name = 'Auto Speed',
		HoverText = 'Automatically uses a "good" tween speed.',
		Default = true,
		Function = function(calling) 
			if calling then 
				pcall(function() PlayerTPSpeed.Object.Visible = false end) 
			else 
				pcall(function() PlayerTPSpeed.Object.Visible = true end) 
			end
		end
	})
	PlayerTPSpeed = PlayerTP.CreateSlider({
		Name = 'Tween Speed',
		Min = 20, 
		Max = 350,
		Default = 200,
		Function = function() end
	})
	PlayerTPMethod = PlayerTP.CreateDropdown({
		Name = 'Teleport Method',
		List = GetEnumItems('EasingStyle'),
		Function = function() end
	})
	PlayerTPSpeed.Object.Visible = false
end)

run(function()
	local HotbarMods = {}
	local HotbarRounding = {}
	local HotbarHighlight = {}
	local HotbarColorToggle = {}
	local HotbarHideSlotIcons = {}
	local HotbarSlotNumberColorToggle = {}
	local HotbarRoundRadius = {Value = 8}
	local HotbarColor = {Hue = 0, Sat = 0, Value = 0}
	local HotbarHighlightColor = {Hue = 0, Sat = 0, Value = 0}
	local HotbarSlotNumberColor = {Hue = 0, Sat = 0, Value = 0}
	local hotbarsloticons = {}
	local hotbarobjects = {}
	local hotbarcoloricons = {}
	local HotbarModsGradient = {}
	local hotbarslotgradients = {}
	local GuiSync = {Enabled = false}
	local HotbarModsGradientColor = {Hue = 0, Sat = 0, Value = 0}
	local HotbarModsGradientColor2 = {Hue = 0, Sat = 0, Value = 0}
	local function hotbarFunction()
		local inventoryicons = ({pcall(function() return lplr.PlayerGui.hotbar['1'].ItemsHotbar end)})[2]
		if inventoryicons and type(inventoryicons) == 'userdata' then
			for i,v in next, inventoryicons:GetChildren() do 
				local sloticon = ({pcall(function() return v:FindFirstChildWhichIsA('ImageButton'):FindFirstChildWhichIsA('TextLabel') end)})[2]
				if type(sloticon) ~= 'userdata' then 
					continue
				end
				if HotbarColorToggle.Enabled and not HotbarModsGradient.Enabled then 
					sloticon.Parent.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value)
					table.insert(hotbarcoloricons, sloticon.Parent) 
				end
				if GuiSync.Enabled then 
					if shared.RiseMode and GuiLibrary.GUICoreColor and GuiLibrary.GUICoreColorChanged then
						sloticon.Parent.BackgroundColor3 = GuiLibrary.GUICoreColor
						GuiLibrary.GUICoreColorChanged.Event:Connect(function()
							pcall(function()
								sloticon.Parent.BackgroundColor3 = GuiLibrary.GUICoreColor
							end)
						end)
					else
						local color = GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api
						sloticon.Parent.BackgroundColor3 = Color3.fromHSV(color.Hue, color.Sat, color.Value)
						VoidwareFunctions.Connections:register(VoidwareFunctions.Controllers:get("UpdateUI").UIUpdate.Event:Connect(function(h,s,v)
							color = {Hue = h, Sat = s, Value = v}
							sloticon.Parent.BackgroundColor3 = Color3.fromHSV(color.Hue, color.Sat, color.Value)
						end))
					end
				end
				if HotbarModsGradient.Enabled and not GuiSync.Enabled then 
					sloticon.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					if sloticon.Parent:FindFirstChildWhichIsA('UIGradient') == nil then 
						local gradient = Instance.new('UIGradient') 
						local color = Color3.fromHSV(HotbarModsGradientColor.Hue, HotbarModsGradientColor.Sat, HotbarModsGradientColor.Value)
						local color2 = Color3.fromHSV(HotbarModsGradientColor2.Hue, HotbarModsGradientColor2.Sat, HotbarModsGradientColor2.Value)
						gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color), ColorSequenceKeypoint.new(1, color2)})
						gradient.Parent = sloticon.Parent
						table.insert(hotbarslotgradients, gradient)
						table.insert(hotbarcoloricons, sloticon.Parent) 
					end
				end
				if HotbarRounding.Enabled then 
					local uicorner = Instance.new('UICorner')
					uicorner.Parent = sloticon.Parent
					uicorner.CornerRadius = UDim.new(0, HotbarRoundRadius.Value)
					table.insert(hotbarobjects, uicorner)
				end
				if HotbarHighlight.Enabled then
					local highlight = Instance.new('UIStroke')
					if GuiSync.Enabled then
						if shared.RiseMode and GuiLibrary.GUICoreColor and GuiLibrary.GUICoreColorChanged then
							highlight.Color = GuiLibrary.GUICoreColor
							GuiLibrary.GUICoreColorChanged.Event:Connect(function()
								highlight.Color = GuiLibrary.GUICoreColor
							end)
						else
							local color = GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api
							highlight.Color = Color3.fromHSV(color.Hue, color.Sat, color.Value)
							VoidwareFunctions.Connections:register(VoidwareFunctions.Controllers:get("UpdateUI").UIUpdate.Event:Connect(function(h,s,v)
								color = {Hue = h, Sat = s, Value = v}
								highlight.Color = Color3.fromHSV(color.Hue, color.Sat, color.Value)
							end))
						end
					else
						highlight.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value)
					end
					highlight.Thickness = 1.3 
					highlight.Parent = sloticon.Parent
					table.insert(hotbarobjects, highlight)
				end
				if HotbarHideSlotIcons.Enabled then 
					sloticon.Visible = false 
				end
				table.insert(hotbarsloticons, sloticon)
			end 
		end
	end
	HotbarMods = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'HotbarVisuals',
		HoverText = 'Add customization to your hotbar.',
		Function = function(calling)
			if calling then 
				task.spawn(function()
					table.insert(HotbarMods.Connections, lplr.PlayerGui.DescendantAdded:Connect(function(v)
						if v.Name == 'hotbar' then
							hotbarFunction()
						end
					end))
					hotbarFunction()
				end)
			else
				for i,v in hotbarsloticons do 
					pcall(function() v.Visible = true end)
				end
				for i,v in hotbarcoloricons do 
					pcall(function() v.BackgroundColor3 = Color3.fromRGB(29, 36, 46) end)
				end
				for i,v in hotbarobjects do
					pcall(function() v:Destroy() end)
				end
				for i,v in next, hotbarslotgradients do 
					pcall(function() v:Destroy() end)
				end
				table.clear(hotbarobjects)
				table.clear(hotbarsloticons)
				table.clear(hotbarcoloricons)
			end
		end
	})
	GuiSync = HotbarMods.CreateToggle({
		Name = "Sync with GUI Color",
		Function = function()
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarColorToggle = HotbarMods.CreateToggle({
		Name = 'Slot Color',
		Function = function(calling)
			pcall(function() HotbarColor.Object.Visible = calling end)
			pcall(function() HotbarColorToggle.Object.Visible = calling end)
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarModsGradient = HotbarMods.CreateToggle({
		Name = 'Gradient Slot Color',
		Function = function(calling)
			pcall(function() HotbarModsGradientColor.Object.Visible = calling end)
			pcall(function() HotbarModsGradientColor2.Object.Visible = calling end)
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarModsGradientColor = HotbarMods.CreateColorSlider({
		Name = 'Gradient Color',
		Function = function(h, s, v)
			for i,v in next, hotbarslotgradients do 
				pcall(function() v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(HotbarModsGradientColor.Hue, HotbarModsGradientColor.Sat, HotbarModsGradientColor.Value)), ColorSequenceKeypoint.new(1, Color3.fromHSV(HotbarModsGradientColor2.Hue, HotbarModsGradientColor2.Sat, HotbarModsGradientColor2.Value))}) end)
			end
		end
	})
	HotbarModsGradientColor2 = HotbarMods.CreateColorSlider({
		Name = 'Gradient Color 2',
		Function = function(h, s, v)
			for i,v in next, hotbarslotgradients do 
				pcall(function() v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(HotbarModsGradientColor.Hue, HotbarModsGradientColor.Sat, HotbarModsGradientColor.Value)), ColorSequenceKeypoint.new(1, Color3.fromHSV(HotbarModsGradientColor2.Hue, HotbarModsGradientColor2.Sat, HotbarModsGradientColor2.Value))}) end)
			end
		end
	})
	HotbarColor = HotbarMods.CreateColorSlider({
		Name = 'Slot Color',
		Function = function(h, s, v)
			for i,v in next, hotbarcoloricons do
				if HotbarColorToggle.Enabled then
					pcall(function() v.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value) end) -- for some reason the 'h, s, v' didn't work :(
				end
			end
		end
	})
	HotbarRounding = HotbarMods.CreateToggle({
		Name = 'Rounding',
		Function = function(calling)
			pcall(function() HotbarRoundRadius.Object.Visible = calling end)
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarRoundRadius = HotbarMods.CreateSlider({
		Name = 'Corner Radius',
		Min = 1,
		Max = 20,
		Function = function(calling)
			for i,v in next, hotbarobjects do 
				pcall(function() v.CornerRadius = UDim.new(0, calling) end)
			end
		end
	})
	HotbarHighlight = HotbarMods.CreateToggle({
		Name = 'Outline Highlight',
		Function = function(calling)
			pcall(function() HotbarHighlightColor.Object.Visible = calling end)
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarHighlightColor = HotbarMods.CreateColorSlider({
		Name = 'Highlight Color',
		Function = function(h, s, v)
			for i,v in next, hotbarobjects do 
				if v:IsA('UIStroke') and HotbarHighlight.Enabled then 
					pcall(function() v.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value) end)
				end
			end
		end
	})
	HotbarHideSlotIcons = HotbarMods.CreateToggle({
		Name = 'No Slot Numbers',
		Function = function()
			if HotbarMods.Enabled then 
				HotbarMods.ToggleButton(false)
				HotbarMods.ToggleButton(false)
			end
		end
	})
	HotbarColor.Object.Visible = false
	HotbarRoundRadius.Object.Visible = false
	HotbarHighlightColor.Object.Visible = false
end)

run(function()
	local HealthbarVisuals = {};
	local HealthbarRound = {};
	local HealthbarColorToggle = {};
	local HealthbarGradientToggle = {};
	local HealthbarGradientColor = {};
	local HealthbarHighlight = {};
	local HealthbarHighlightColor = newcolor();
	local HealthbarGradientRotation = {Value = 0};
	local HealthbarTextToggle = {};
	local HealthbarFontToggle = {};
	local HealthbarTextColorToggle = {};
	local HealthbarBackgroundToggle = {};
	local HealthbarText = {ObjectList = {}};
	local HealthbarInvis = {Value = 0};
	local HealthbarRoundSize = {Value = 4};
	local HealthbarFont = {value = 'LuckiestGuy'};
	local HealthbarColor = newcolor();
	local HealthbarBackground = newcolor();
	local HealthbarTextColor = newcolor();
	local healthbarobjects = safearray();
	local oldhealthbar;
	local healthbarhighlight;
	local textconnection;
	local function healthbarFunction()
		if not HealthbarVisuals.Enabled then 
			return 
		end
		local healthbar = ({pcall(function() return lplr.PlayerGui.hotbar['1'].HotbarHealthbarContainer.HealthbarProgressWrapper['1'] end)})[2]
		if healthbar and type(healthbar) == 'userdata' then 
			oldhealthbar = healthbar;
			healthbar.Transparency = (0.1 * HealthbarInvis.Value);
			healthbar.BackgroundColor3 = (HealthbarColorToggle.Enabled and Color3.fromHSV(HealthbarColor.Hue, HealthbarColor.Sat, HealthbarColor.Value) or healthbar.BackgroundColor3)
			if HealthbarGradientToggle.Enabled then 
				healthbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				local gradient = (healthbar:FindFirstChildWhichIsA('UIGradient') or Instance.new('UIGradient', healthbar))
				gradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHSV(HealthbarColor.Hue, HealthbarColor.Sat, HealthbarColor.Value)), 
					ColorSequenceKeypoint.new(1, Color3.fromHSV(HealthbarGradientColor.Hue, HealthbarGradientColor.Sat, HealthbarGradientColor.Value))
				})
				gradient.Rotation = HealthbarGradientRotation.Value
				table.insert(healthbarobjects, gradient)
			end
			for i,v in healthbar.Parent:GetChildren() do 
				if v:IsA('Frame') and v:FindFirstChildWhichIsA('UICorner') == nil and HealthbarRound.Enabled then
					local corner = Instance.new('UICorner', v);
					corner.CornerRadius = UDim.new(0, HealthbarRoundSize.Value);
					table.insert(healthbarobjects, corner)
				end
			end
			local healthbarbackground = ({pcall(function() return healthbar.Parent.Parent end)})[2]
			if healthbarbackground and type(healthbarbackground) == 'userdata' then
				healthbar.Transparency = (0.1 * HealthbarInvis.Value);
				if HealthbarHighlight.Enabled then 
					local highlight = Instance.new('UIStroke', healthbarbackground);
					highlight.Color = Color3.fromHSV(HealthbarHighlightColor.Hue, HealthbarHighlightColor.Sat, HealthbarHighlightColor.Value);
					highlight.Thickness = 1.6; 
					healthbarhighlight = highlight
				end
				if healthbar.Parent.Parent:FindFirstChildWhichIsA('UICorner') == nil and HealthbarRound.Enabled then 
					local corner = Instance.new('UICorner', healthbar.Parent.Parent);
					corner.CornerRadius = UDim.new(0, HealthbarRoundSize.Value);
					table.insert(healthbarobjects, corner)
				end 
				if HealthbarBackgroundToggle.Enabled then
					healthbarbackground.BackgroundColor3 = Color3.fromHSV(HealthbarBackground.Hue, HealthbarBackground.Sat, HealthbarBackground.Value)
				end
			end
			local healthbartext = ({pcall(function() return healthbar.Parent.Parent['1'] end)})[2]
			if healthbartext and type(healthbartext) == 'userdata' then 
				local randomtext = getrandomvalue(HealthbarText.ObjectList)
				if HealthbarTextColorToggle.Enabled then
					healthbartext.TextColor3 = Color3.fromHSV(HealthbarTextColor.Hue, HealthbarTextColor.Sat, HealthbarTextColor.Value)
				end
				if HealthbarFontToggle.Enabled then 
					healthbartext.Font = Enum.Font[HealthbarFont.Value]
				end
				if randomtext ~= '' and HealthbarTextToggle.Enabled then 
					healthbartext.Text = randomtext:gsub('<health>', isAlive(lplr, true) and tostring(math.round(lplr.Character:GetAttribute('Health') or 0)) or '0')
				else
					pcall(function() healthbartext.Text = tostring(lplr.Character:GetAttribute('Health')) end)
				end
				if not textconnection then 
					textconnection = healthbartext:GetPropertyChangedSignal('Text'):Connect(function()
						local randomtext = getrandomvalue(HealthbarText.ObjectList)
						if randomtext ~= '' then 
							healthbartext.Text = randomtext:gsub('<health>', isAlive() and tostring(math.floor(lplr.Character:GetAttribute('Health') or 0)) or '0')
						else
							pcall(function() healthbartext.Text = tostring(math.floor(lplr.Character:GetAttribute('Health'))) end)
						end
					end)
				end
			end
		end
	end
	HealthbarVisuals = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'HealthbarVisuals',
		HoverText = 'Customize the color of your healthbar.\nAdd \'<health>\' to your custom text dropdown (if custom text enabled) to insert your health.',
		Function = function(calling)
			if calling then 
				task.spawn(function()
					table.insert(HealthbarVisuals.Connections, lplr.PlayerGui.DescendantAdded:Connect(function(v)
						if v.Name == 'HotbarHealthbarContainer' and v.Parent and v.Parent.Parent and v.Parent.Parent.Name == 'hotbar' then
							healthbarFunction()
						end
					end))
					healthbarFunction()
				end)
			else
				pcall(function() textconnection:Disconnect() end)
				pcall(function() oldhealthbar.Parent.Parent.BackgroundColor3 = Color3.fromRGB(41, 51, 65) end)
				pcall(function() oldhealthbar.BackgroundColor3 = Color3.fromRGB(203, 54, 36) end)
				pcall(function() oldhealthbar.Parent.Parent['1'].Text = tostring(lplr.Character:GetAttribute('Health')) end)
				pcall(function() oldhealthbar.Parent.Parent['1'].TextColor3 = Color3.fromRGB(255, 255, 255) end)
				pcall(function() oldhealthbar.Parent.Parent['1'].Font = Enum.Font.LuckiestGuy end)
				oldhealthbar = nil
				textconnection = nil
				for i,v in healthbarobjects do 
					pcall(function() v:Destroy() end)
				end
				table.clear(healthbarobjects);
				pcall(function() healthbarhighlight:Destroy() end);
				healthbarhighlight = nil;
			end
		end
	})
	HealthbarColorToggle = HealthbarVisuals.CreateToggle({
		Name = 'Main Color',
		Default = true,
		Function = function(calling)
			pcall(function() HealthbarColor.Object.Visible = calling end)
			pcall(function() HealthbarGradientToggle.Object.Visible = calling end)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end 
	})
	HealthbarGradientToggle = HealthbarVisuals.CreateToggle({
		Name = 'Gradient',
		Function = function(calling)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end
	})
	HealthbarColor = HealthbarVisuals.CreateColorSlider({
		Name = 'Main Color',
		Function = function()
			task.spawn(healthbarFunction)
		end
	})
	HealthbarGradientColor = HealthbarVisuals.CreateColorSlider({
		Name = 'Secondary Color',
		Function = function(calling)
			if HealthbarGradientToggle.Enabled then 
				task.spawn(healthbarFunction)
			end
		end
	})
	HealthbarBackgroundToggle = HealthbarVisuals.CreateToggle({
		Name = 'Background Color',
		Function = function(calling)
			pcall(function() HealthbarBackground.Object.Visible = calling end)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end 
	})
	HealthbarBackground = HealthbarVisuals.CreateColorSlider({
		Name = 'Background Color',
		Function = function() 
			task.spawn(healthbarFunction)
		end
	})
	HealthbarTextToggle = HealthbarVisuals.CreateToggle({
		Name = 'Text',
		Function = function(calling)
			pcall(function() HealthbarText.Object.Visible = calling end)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end 
	})
	HealthbarText = HealthbarVisuals.CreateTextList({
		Name = 'Text',
		TempText = 'Healthbar Text',
		AddFunction = function()
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end,
		RemoveFunction = function()
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end
	})
	HealthbarTextColorToggle = HealthbarVisuals.CreateToggle({
		Name = 'Text Color',
		Function = function(calling)
			pcall(function() HealthbarTextColor.Object.Visible = calling end)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end 
	})
	HealthbarTextColor = HealthbarVisuals.CreateColorSlider({
		Name = 'Text Color',
		Function = function() 
			task.spawn(healthbarFunction)
		end
	})
	HealthbarFontToggle = HealthbarVisuals.CreateToggle({
		Name = 'Text Font',
		Function = function(calling)
			pcall(function() HealthbarFont.Object.Visible = calling end)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end 
	})
	HealthbarFont = HealthbarVisuals.CreateDropdown({
		Name = 'Text Font',
		List = GetEnumItems('Font'),
		Function = function(calling)
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end
	})
	HealthbarRound = HealthbarVisuals.CreateToggle({
		Name = 'Round',
		Function = function(calling)
			pcall(function() HealthbarRoundSize.Object.Visible = calling end);
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end
	})
	HealthbarRoundSize = HealthbarVisuals.CreateSlider({
		Name = 'Corner Size',
		Min = 1,
		Max = 20,
		Default = 5,
		Function = function(value)
			if HealthbarVisuals.Enabled then 
				pcall(function() 
					oldhealthbar.Parent:FindFirstChildOfClass('UICorner').CornerRadius = UDim.new(0, value);
					oldhealthbar.Parent.Parent:FindFirstChildOfClass('UICorner').CornerRadius = UDim.new(0, value)  
				end)
			end
		end
	})
	HealthbarHighlight = HealthbarVisuals.CreateToggle({
		Name = 'Highlight',
		Function = function(calling)
			pcall(function() HealthbarHighlightColor.Object.Visible = calling end);
			if HealthbarVisuals.Enabled then
				HealthbarVisuals.ToggleButton(false)
				HealthbarVisuals.ToggleButton(false)
			end
		end
	})
	HealthbarHighlightColor = HealthbarVisuals.CreateColorSlider({
		Name = 'Highlight Color',
		Function = function()
			if HealthbarVisuals.Enabled then 
				pcall(function() healthbarhighlight.Color = Color3.fromHSV(HealthbarHighlightColor.Hue, HealthbarHighlightColor.Sat, HealthbarHighlightColor.Value) end)
			end
		end
	})
	HealthbarInvis = HealthbarVisuals.CreateSlider({
		Name = 'Invisibility',
		Min = 0,
		Max = 10,
		Function = function(value)
			pcall(function() 
				oldhealthbar.Transparency = (0.1 * value);
				oldhealthbar.Parent.Parent.Transparency = (0.1 * HealthbarInvis.Value); 
			end)
		end
	})
	HealthbarBackground.Object.Visible = false;
	HealthbarText.Object.Visible = false;
	HealthbarTextColor.Object.Visible = false;
	HealthbarFont.Object.Visible = false;
	HealthbarRoundSize.Object.Visible = false;
	HealthbarHighlightColor.Object.Visible = false;
end)

run(function()
	local ClanDetector = {Enabled = false}
	local alreadyclanchecked = {}
	local blacklistedclans = {}
	local function detectblacklistedclan(plr)
		if not plr:GetAttribute("LobbyConnected") then repeat task.wait() until plr:GetAttribute("LobbyConnected") end
		for i2, v2 in pairs(blacklistedclans.ObjectList) do
			if GetClanTag(plr) == v2 and alreadyclanchecked[plr] == nil then
				warningNotification("ClanDetector", plr.DisplayName.. " is in the "..v2.." clan!", 15)
				alreadyclanchecked[plr] = true
			end
		end
	end
	ClanDetector = GuiLibrary.ObjectsThatCanBeSaved.VoidwareWindow.Api.CreateOptionsButton({
		Name = "ClanDetector",
		Approved = true,
		Function = function(callback)
			if callback then
				task.spawn(function()
				for i,v in pairs(playersService:GetPlayers()) do
					task.spawn(function()
					 if v ~= lplr then
						 task.spawn(detectblacklistedclan, v)
					 end
					end)
				end
				table.insert(ClanDetector.Connections, playersService.PlayerAdded:Connect(function(v)
					task.spawn(detectblacklistedclan, v)
				end))
			end)
			end
		end,
		HoverText = "detect players in certain clans (customizable)"
	})
	blacklistedclans = ClanDetector.CreateTextList({
		Name = "Clans",
		TempText = "clans to detect",
		AddFunction = function() 
			if ClanDetector.Enabled then
				ClanDetector.ToggleButton(false)
				ClanDetector.ToggleButton(false)
			end
		end
	})
end)

run(function()
    local antiDeath = {}
    local antiDeathConfig = {
        Mode = {},
        BoostMode = {},
        SongId = {},
        Health = {},
        Velocity = {},
        CFrame = {},
        TweenPower = {},
        TweenDuration = {},
        SkyPosition = {},
        AutoDisable = {},
        Sound = {},
        Notify = {}
    }
    local antiDeathState = {}
    local handlers = {}

    function handlers.new()
        local self = {
            boost = false,
            inf = false,
            notify = false,
            id = false,
            hrp = entityLibrary.character.HumanoidRootPart,
            hasNotified = false
        }
        setmetatable(self, { __index = handlers })
        return self
    end

    function handlers:enable()
        RunLoops:BindToHeartbeat('antiDeath', function()
            if not isAlive(lplr, true) then
                self:disable()
                return
            end

            if getHealth() <= antiDeathConfig.Health.Value and getHealth() > 0 then
                if not self.boost then
                    self:activateMode()
                    if not self.hasNotified and antiDeathConfig.Notify.Enabled then
                        self:sendNotification()
                    end
                    self:playNotificationSound()
                    self.boost = true
                end
            else
                self:resetMode()
                self.hrp.Anchored = false
                self.boost = false

                if self.hasNotified then
                    self.hasNotified = false
                end
            end
        end)
    end

    function handlers:disable()
        RunLoops:UnbindFromHeartbeat('antiDeath')
    end

    function handlers:activateMode()
        local modeActions = {
            Infinite = function() self:enableInfiniteMode() end,
            Boost = function() self:applyBoost() end,
            Sky = function() self:moveToSky() end
        }
        modeActions[antiDeathConfig.Mode.Value]()
    end

    function handlers:enableInfiniteMode()
        if not GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.Enabled then
            GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.ToggleButton(true)
            self.inf = true
        end
    end

    function handlers:applyBoost()
        local boostActions = {
            Velocity = function() self.hrp.Velocity += vec3(0, antiDeathConfig.Velocity.Value, 0) end,
            CFrame = function() self.hrp.CFrame += vec3(0, antiDeathConfig.CFrame.Value, 0) end,
            Tween = function()
                tweenService:Create(self.hrp, twinfo(antiDeathConfig.TweenDuration.Value / 10), {
                    CFrame = self.hrp.CFrame + vec3(0, antiDeathConfig.TweenPower.Value, 0)
                }):Play()
            end
        }
        boostActions[antiDeathConfig.BoostMode.Value]()
    end

    function handlers:moveToSky()
        self.hrp.CFrame += vec3(0, antiDeathConfig.SkyPosition.Value, 0)
        self.hrp.Anchored = true
    end

    function handlers:sendNotification()
        InfoNotification('AntiDeath', 'Prevented death. Health is lower than ' .. antiDeathConfig.Health.Value ..
            '. (Current health: ' .. math.floor(getHealth() + 0.5) .. ')', 5)
        self.hasNotified = true
    end

    function handlers:playNotificationSound()
        if antiDeathConfig.Sound.Enabled then
            local soundId = antiDeathConfig.SongId.Value ~= '' and antiDeathConfig.SongId.Value or '7396762708'
            playSound(soundId, false)
        end
    end

    function handlers:resetMode()
        if self.inf then
            if antiDeathConfig.AutoDisable.Enabled then
                if GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.Enabled then
                    GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.ToggleButton(false)
                end
            end
            self.inf = false
            self.hasNotified = false
        end
    end

    local antiDeathStatus = handlers.new()

    antiDeath = GuiLibrary.ObjectsThatCanBeSaved.VoidwareWindow.Api.CreateOptionsButton({
        Name = 'AntiDeath',
        Function = function(callback)
            if callback then
                coroutine.wrap(function()
                    antiDeathStatus:enable()
                end)()
            else
                pcall(function()
                    antiDeathStatus:disable()
                end)
            end
        end,
        Default = false,
        HoverText = btext('Prevents you from dying.'),
        ExtraText = function()
            return antiDeathConfig.Mode.Value
        end
    })

    antiDeathConfig.Mode = antiDeath.CreateDropdown({
        Name = 'Mode',
        List = {'Infinite', 'Boost', 'Sky' },
        Default = 'Infinite',
        HoverText = btext('Mode to prevent death.'),
        Function = function(val)
            antiDeathConfig.BoostMode.Object.Visible = val == 'Boost'
            antiDeathConfig.SkyPosition.Object.Visible = val == 'Sky'
            antiDeathConfig.AutoDisable.Object.Visible = val == 'Infinite'
            antiDeathConfig.Velocity.Object.Visible = false
            antiDeathConfig.CFrame.Object.Visible = false
            antiDeathConfig.TweenPower.Object.Visible = false
            antiDeathConfig.TweenDuration.Object.Visible = false
        end
    })

    antiDeathConfig.BoostMode = antiDeath.CreateDropdown({
        Name = 'Boost',
        List = { 'Velocity', 'CFrame', 'Tween' },
        Default = 'Velocity',
        HoverText = btext('Mode to boost your character.'),
        Function = function(val)
            antiDeathConfig.Velocity.Object.Visible = val == 'Velocity'
            antiDeathConfig.CFrame.Object.Visible = val == 'CFrame'
            antiDeathConfig.TweenPower.Object.Visible = val == 'Tween'
            antiDeathConfig.TweenDuration.Object.Visible = val == 'Tween'
        end
    })
    antiDeathConfig.BoostMode.Object.Visible = false

    antiDeathConfig.SongId = antiDeath.CreateTextBox({
        Name = 'SongID',
        TempText = 'Song ID',
        HoverText = 'ID to play the song.',
        FocusLost = function()
            if antiDeath.Enabled then
                antiDeath.ToggleButton()
                antiDeath.ToggleButton()
            end
        end
    })
    antiDeathConfig.SongId.Object.Visible = false

    antiDeathConfig.Health = antiDeath.CreateSlider({
        Name = 'Health Trigger',
        Min = 10,
        Max = 90,
        HoverText = btext('Health at which AntiDeath will perform its actions.'),
        Default = 50,
        Function = function(val) end
    })

    antiDeathConfig.Velocity = antiDeath.CreateSlider({
        Name = 'Velocity Boost',
        Min = 100,
        Max = 600,
        HoverText = btext('Power to get boosted in the air.'),
        Default = 600,
        Function = function(val) end
    })
    antiDeathConfig.Velocity.Object.Visible = false

    antiDeathConfig.CFrame = antiDeath.CreateSlider({
        Name = 'CFrame Boost',
        Min = 100,
        Max = 1000,
        HoverText = btext('Power to get boosted in the air.'),
        Default = 1000,
        Function = function(val) end
    })
    antiDeathConfig.CFrame.Object.Visible = false

    antiDeathConfig.TweenPower = antiDeath.CreateSlider({
        Name = 'Tween Boost',
        Min = 100,
        Max = 1300,
        HoverText = btext('Power to get boosted in the air.'),
        Default = 1000,
        Function = function(val) end
    })
    antiDeathConfig.TweenPower.Object.Visible = false

    antiDeathConfig.TweenDuration = antiDeath.CreateSlider({
        Name = 'Tween Duration',
        Min = 1,
        Max = 10,
        HoverText = btext('Duration of the tweening process.'),
        Default = 4,
        Function = function(val) end
    })
    antiDeathConfig.TweenDuration.Object.Visible = false

    antiDeathConfig.SkyPosition = antiDeath.CreateSlider({
        Name = 'Sky Position',
        Min = 100,
        Max = 1000,
        HoverText = btext('Position to TP in the sky.'),
        Default = 1000,
        Function = function(val) end
    })
    antiDeathConfig.SkyPosition.Object.Visible = false

    antiDeathConfig.AutoDisable = antiDeath.CreateToggle({
        Name = 'Auto Disable',
        HoverText = btext('Automatically disables InfiniteFly after healing.'),
        Function = function(val) end,
        Default = true
    })
    antiDeathConfig.AutoDisable.Object.Visible = false

    antiDeathConfig.Sound = antiDeath.CreateToggle({
        Name = 'Sound',
        HoverText = btext('Plays a sound after preventing death.'),
        Function = function(callback)
            antiDeathConfig.SongId.Object.Visible = callback
        end,
        Default = true
    })

    antiDeathConfig.Notify = antiDeath.CreateToggle({
        Name = 'Notification',
        HoverText = btext('Notifies you when AntiDeath actioned.'),
        Default = true,
        Function = function(callback) end
    })
end)

run(function()
    local AdetundeExploit = {}
    local AdetundeExploit_List = { Value = "Shield" }

    local adetunde_remotes = {
        ["Shield"] = function()
            local args = { [1] = "shield" }
            local returning = game:GetService("ReplicatedStorage")
                :WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("UpgradeFrostyHammer")
                :InvokeServer(unpack(args))
            return returning
        end,

        ["Speed"] = function()
            local args = { [1] = "speed" }
            local returning = game:GetService("ReplicatedStorage")
                :WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("UpgradeFrostyHammer")
                :InvokeServer(unpack(args))
            return returning
        end,

        ["Strength"] = function()
            local args = { [1] = "strength" }
            local returning = game:GetService("ReplicatedStorage")
                :WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("UpgradeFrostyHammer")
                :InvokeServer(unpack(args))
            return returning
        end
    }

    local current_upgrador = "Shield"
    local hasnt_upgraded_everything = true
    local testing = 1

    AdetundeExploit = GuiLibrary.ObjectsThatCanBeSaved.ExploitsWindow.Api.CreateOptionsButton({
        Name = 'AdetundeExploit',
        Function = function(calling)
            if calling then 
                -- Check if in testing mode or equipped kit
                -- if tostring(store.queueType) == "training_room" or store.equippedKit == "adetunde" then
                --     AdetundeExploit["ToggleButton"](false) 
                --     current_upgrador = AdetundeExploit_List.Value
                task.spawn(function()
                    repeat
                        local returning_table = adetunde_remotes[current_upgrador]()
                        
                        if type(returning_table) == "table" then
                            local Speed = returning_table["speed"]
                            local Strength = returning_table["strength"]
                            local Shield = returning_table["shield"]

                            print("Speed: " .. tostring(Speed))
                            print("Strength: " .. tostring(Strength))
                            print("Shield: " .. tostring(Shield))
                            print("Current Upgrador: " .. tostring(current_upgrador))

                            if returning_table[string.lower(current_upgrador)] == 3 then
                                if Strength and Shield and Speed then
                                    if Strength == 3 or Speed == 3 or Shield == 3 then
                                        if (Strength == 3 and Speed == 2 and Shield == 2) or
                                           (Strength == 2 and Speed == 3 and Shield == 2) or
                                           (Strength == 2 and Speed == 2 and Shield == 3) then
                                            warningNotification("AdetundeExploit", "Fully upgraded everything possible!", 7)
                                            hasnt_upgraded_everything = false
                                        else
                                            local things = {}
                                            for i, v in pairs(adetunde_remotes) do
                                                table.insert(things, i)
                                            end
                                            for i, v in pairs(things) do
                                                if things[i] == current_upgrador then
                                                    table.remove(things, i)
                                                end
                                            end
                                            local random = things[math.random(1, #things)]
                                            current_upgrador = random
                                        end
                                    end
                                end
                            end
                        else
                            local things = {}
                            for i, v in pairs(adetunde_remotes) do
                                table.insert(things, i)
                            end
                            for i, v in pairs(things) do
                                if things[i] == current_upgrador then
                                    table.remove(things, i)
                                end
                            end
                            local random = things[math.random(1, #things)]
                            current_upgrador = random
                        end
                        task.wait(0.1)
                    until not AdetundeExploit.Enabled or not hasnt_upgraded_everything
                end)
                -- else
                --     AdetundeExploit["ToggleButton"](false)
                --     warningNotification("AdetundeExploit", "Kit required or you need to be in testing mode", 5)
                -- end
            end
        end
    })

    local real_list = {}
    for i, v in pairs(adetunde_remotes) do
        table.insert(real_list, i)
    end

    AdetundeExploit_List = AdetundeExploit.CreateDropdown({
        Name = 'Preferred Upgrade',
        List = real_list,
        Function = function() end,
        Default = "Shield"
    })
end)

run(function()
	function IsAlive(plr)
		plr = plr or lplr
		if not plr.Character then return false end
		if not plr.Character:FindFirstChild("Head") then return false end
		if not plr.Character:FindFirstChild("Humanoid") then return false end
		if plr.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
		return true
	end
	local GodMode = {Enabled = false}
	GodMode = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = "AntiHit/Godmode",
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat task.wait()
						pcall(function()
							if (not GuiLibrary.ObjectsThatCanBeSaved.FlyOptionsButton.Api.Enabled) and (not GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.Enabled) then
								for i, v in pairs(game:GetService("Players"):GetChildren()) do
									if v.Team ~= lplr.Team and IsAlive(v) and IsAlive(lplr) then
										if v and v ~= lplr then
											local TargetDistance = lplr:DistanceFromCharacter(v.Character:FindFirstChild("HumanoidRootPart").CFrame.p)
											if TargetDistance < 25 then
												if not lplr.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity") then
													repeat task.wait() until shared.GlobalStore.matchState ~= 0
													if not (v.Character.HumanoidRootPart.Velocity.Y < -10*5) then
														lplr.Character.Archivable = true
				
														local Clone = lplr.Character:Clone()
														Clone.Parent = game.Workspace
														Clone.Head:ClearAllChildren()
														gameCamera.CameraSubject = Clone:FindFirstChild("Humanoid")
					
														for i,v in pairs(Clone:GetChildren()) do
															if string.lower(v.ClassName):find("part") and v.Name ~= "HumanoidRootPart" then
																v.Transparency = 1
															end
															if v:IsA("Accessory") then
																v:FindFirstChild("Handle").Transparency = 1
															end
														end
					
														lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0,100000,0)
					
														game:GetService("RunService").RenderStepped:Connect(function()
															if Clone ~= nil and Clone:FindFirstChild("HumanoidRootPart") then
																Clone.HumanoidRootPart.Position = Vector3.new(lplr.Character.HumanoidRootPart.Position.X, Clone.HumanoidRootPart.Position.Y, lplr.Character.HumanoidRootPart.Position.Z)
															end
														end)
					
														task.wait(0.3)
														lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, -1, lplr.Character.HumanoidRootPart.Velocity.Z)
														lplr.Character.HumanoidRootPart.CFrame = Clone.HumanoidRootPart.CFrame
														gameCamera.CameraSubject = lplr.Character:FindFirstChild("Humanoid")
														Clone:Destroy()
														task.wait(0.15)
													end
												end
											end
										end
									end
								end
							end
						end)
					until (not GodMode.Enabled)
				end)
			end
		end
	})
end)

task.spawn(function()
    local tweenmodules = {"BedTP", "EmeraldTP", "DiamondTP", "MiddleTP", "Autowin", "PlayerTP"}
    local tweening = false
    repeat
    for i,v in pairs(tweenmodules) do
        pcall(function()
        if GuiLibrary.ObjectsThatCanBeSaved[v.."OptionsButton"].Api.Enabled then
            tweening = true
        end
        end)
    end
    VoidwareStore.Tweening = tweening
    tweening = false
    task.wait()
  until not vapeInjected
end)
local vapeAssert = function(argument, title, text, duration, hault, moduledisable, module) 
	if not argument then
    local suc, res = pcall(function()
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    if moduledisable and (module and GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.Enabled) then GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.ToggleButton(false) end
    end)
    if hault then while true do task.wait() end end end
end
local function GetMagnitudeOf2Objects(part, part2, bypass)
	local magnitude, partcount = 0, 0
	if not bypass then 
		local suc, res = pcall(function() return part.Position end)
		partcount = suc and partcount + 1 or partcount
		suc, res = pcall(function() return part2.Position end)
		partcount = suc and partcount + 1 or partcount
	end
	if partcount > 1 or bypass then 
		magnitude = bypass and (part - part2).magnitude or (part.Position - part2.Position).magnitude
	end
	return magnitude
end
local function GetTopBlock(position, smart, raycast, customvector)
	position = position or isAlive(lplr, true) and lplr.Character.HumanoidRootPart.Position
	if not position then 
		return nil 
	end
	if raycast and not game.Workspace:Raycast(position, Vector3.new(0, -2000, 0), store.blockRaycast) then
	    return nil
    end
	local lastblock = nil
	for i = 1, 500 do 
		local newray = game.Workspace:Raycast(lastblock and lastblock.Position or position, customvector or Vector3.new(0.55, 999999, 0.55), store.blockRaycast)
		local smartest = newray and smart and game.Workspace:Raycast(lastblock and lastblock.Position or position, Vector3.new(0, 5.5, 0), store.blockRaycast) or not smart
		if newray and smartest then
			lastblock = newray
		else
			break
		end
	end
	return lastblock
end
local function FindEnemyBed(maxdistance, highest)
	local target = nil
	local distance = maxdistance or math.huge
	local whitelistuserteams = {}
	local badbeds = {}
	if not lplr:GetAttribute("Team") then return nil end
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr then
			local type, attackable = shared.vapewhitelist:get(v)
			if not attackable then
				whitelistuserteams[v:GetAttribute("Team")] = true
			end
		end
	end
	for i,v in pairs(collectionService:GetTagged("bed")) do
			local bedteamstring = string.split(v:GetAttribute("id"), "_")[1]
			if whitelistuserteams[bedteamstring] ~= nil then
			   badbeds[v] = true
		    end
	    end
	for i,v in pairs(collectionService:GetTagged("bed")) do
		if v:GetAttribute("id") and v:GetAttribute("id") ~= lplr:GetAttribute("Team").."_bed" and badbeds[v] == nil and lplr.Character and lplr.Character.PrimaryPart then
			if v:GetAttribute("NoBreak") or v:GetAttribute("PlacedByUserId") and v:GetAttribute("PlacedByUserId") ~= 0 then continue end
			local magdist = GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, v)
			if magdist < distance then
				target = v
				distance = magdist
			end
		end
	end
	local coveredblock = highest and target and GetTopBlock(target.Position, true)
	if coveredblock then
		target = coveredblock.Instance
	end
	return target
end
local function FindTeamBed()
	local bedstate, res = pcall(function()
		return lplr.leaderstats.Bed.Value
	end)
	return bedstate and res and res ~= nil and res == "✅"
end
local function FindItemDrop(item)
	local itemdist = nil
	local dist = math.huge
	local function abletocalculate() return lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") end
    for i,v in pairs(collectionService:GetTagged("ItemDrop")) do
		if v and v.Name == item and abletocalculate() then
			local itemdistance = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v)
			if itemdistance < dist then
			itemdist = v
			dist = itemdistance
		end
		end
	end
	return itemdist
end
local function FindTarget(dist, blockRaycast, includemobs, healthmethod)
	local whitelist = shared.vapewhitelist
	local sort, entity = healthmethod and math.huge or dist or math.huge, {}
	local function abletocalculate() return lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") end
	local sortmethods = {Normal = function(entityroot, entityhealth) return abletocalculate() and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, entityroot) < sort end, Health = function(entityroot, entityhealth) return abletocalculate() and entityhealth < sort end}
	local sortmethod = healthmethod and "Health" or "Normal"
	local function raycasted(entityroot) return abletocalculate() and blockRaycast and game.Workspace:Raycast(entityroot.Position, Vector3.new(0, -2000, 0), store.blockRaycast) or not blockRaycast and true or false end
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and abletocalculate() and isAlive(v) and v.Team ~= lplr.Team then
			if not ({whitelist:get(v)})[2] then 
				continue
			end
			if sortmethods[sortmethod](v.Character.HumanoidRootPart, v.Character:GetAttribute("Health") or v.Character.Humanoid.Health) and raycasted(v.Character.HumanoidRootPart) then
				sort = healthmethod and v.Character.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.Character.HumanoidRootPart)
				entity.Player = v
				entity.Human = true 
				entity.RootPart = v.Character.HumanoidRootPart
				entity.Humanoid = v.Character.Humanoid
			end
		end
	end
	if includemobs then
		local maxdistance = dist or math.huge
		for i,v in pairs(store.pots) do
			if abletocalculate() and v.PrimaryPart and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart) < maxdistance then
			entity.Player = {Character = v, Name = "PotEntity", DisplayName = "PotEntity", UserId = 1}
			entity.Human = false
			entity.RootPart = v.PrimaryPart
			entity.Humanoid = {Health = 1, MaxHealth = 1}
			end
		end
		for i,v in pairs(collectionService:GetTagged("DiamondGuardian")) do 
			if v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health and abletocalculate() then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "DiamondGuardian", DisplayName = "DiamondGuardian", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("GolemBoss")) do
			if v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health and abletocalculate() then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "Titan", DisplayName = "Titan", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("Drone")) do
			local plr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
			if plr and plr ~= lplr and plr.Team and lplr.Team and plr.Team ~= lplr.Team and ({VoidwareFunctions:GetPlayerType(plr)})[2] and abletocalculate() and v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
					sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
					entity.Player = {Character = v, Name = "Drone", DisplayName = "Drone", UserId = 1}
					entity.Human = false
					entity.RootPart = v.PrimaryPart
					entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("Monster")) do
			if v:GetAttribute("Team") ~= lplr:GetAttribute("Team") and abletocalculate() and v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "Monster", DisplayName = "Monster", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
			end
		end
	end
    end
    return entity
end
run(function()
	local Autowin = {Enabled = false}
	local AutowinNotification = {Enabled = true}
	local bedtween
	local playertween
	Autowin = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = "Autowin",
		ExtraText = function() return shared.GlobalStore and shared.GlobalStore.queueType:find("5v5") and "BedShield" or "Normal" end,
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton
					repeat task.wait() until GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled and GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("Autowin", "Please turn off the Invisibility and GamingChair module!", 3)
						Autowin.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.InvisibilityOptionsButton.Api.Enabled then
						errorNotification("Autowin", "Please turn off the Invisibility module!", 3)
						Autowin.ToggleButton()
						return
					end
					if GuiLibrary.ObjectsThatCanBeSaved.GamingChairOptionsButton.Api.Enabled then
						errorNotification("Autowin", "Please turn off the GamingChair module!", 3)
						Autowin.ToggleButton()
						return
					end
					task.spawn(function()
						if store.matchState == 0 then repeat task.wait() until store.matchState ~= 0 or not Autowin.Enabled end
						if not shared.VapeFullyLoaded then repeat task.wait() until shared.VapeFullyLoaded or not Autowin.Enabled end
						if not Autowin.Enabled then return end
						vapeAssert(not store.queueType:find("skywars"), "Autowin", "Skywars not supported.", 7, true, true, "Autowin")
						if isAlive(lplr, true) then
							lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
						end
						table.insert(Autowin.Connections, runService.Heartbeat:Connect(function()
							pcall(function()
							if not isnetworkowner(lplr.Character.HumanoidRootPart) and (FindEnemyBed() and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, FindEnemyBed()) > 75 or not FindEnemyBed()) then
								if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled and store.matchState < 2 then
									lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
								end
							end
						end)
						end))
						table.insert(Autowin.Connections, lplr.CharacterAdded:Connect(function()
							if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
							local bed = FindEnemyBed()
							if bed and (bed:GetAttribute("BedShieldEndTime") and bed:GetAttribute("BedShieldEndTime") < game.Workspace:GetServerTimeNow() or not bed:GetAttribute("BedShieldEndTime")) then
							bedtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {CFrame = CFrame.new(bed.Position) + Vector3.new(0, 10, 0)})
							task.wait(0.1)
							bedtween:Play()
							bedtween.Completed:Wait()
							task.spawn(function()
							task.wait(1.5)
							if lplr.Character:FindFirstChild("HumanoidRootPart") then
								local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, bed)
								if magnitude >= 50 and FindTeamBed() and Autowin.Enabled then
									lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
									lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
								end
							end
							end)
							if AutowinNotification.Enabled then
								local function get_bed_team(id)
									local teamName = "Unknown"
									for i,v in pairs(game:GetService("Players"):GetPlayers()) do
										if v ~= game:GetService("Players").LocalPlayer then
											if v:GetAttribute("Team") and tostring(v:GetAttribute("Team")) == tostring(id) then
												teamName = tostring(v.Team)
											end
										end
									end
									return false, teamName
								end
								local suc, bedname = get_bed_team(bed:GetAttribute("TeamId"))
								task.spawn(InfoNotification, "Autowin", "Destroying "..bedname:lower().." team's bed", 5)
							end
							if not isEnabled("Nuker") then
								--GuiLibrary.ObjectsThatCanBeSaved.NukerOptionsButton.Api.ToggleButton(false)
							end
							repeat task.wait() until FindEnemyBed() ~= bed or not isAlive()
							if EntityNearPosition(45) and EntityNearPosition(45).RootPart and isAlive() then
								if AutowinNotification.Enabled then
									local team = VoidwareStore.bedtable[bed] or "unknown"
									task.spawn(InfoNotification, "Autowin", "Killing "..team:lower().." team's teamates", 5)
								end
								repeat
								local target = EntityNearPosition(45)
								if not target.RootPart then break end
								playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.75), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
								playertween:Play()
								task.wait()
								until not (EntityNearPosition(45) and EntityNearPosition(45).RootPart) or not Autowin.Enabled or not isAlive()
							end
							if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled then
								lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
								lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							end
							elseif EntityNearPosition(45) and EntityNearPosition(45).RootPart then
								local target = EntityNearPosition(45)
								playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
								playertween:Play()
								if AutowinNotification.Enabled then
									task.spawn(InfoNotification, "Autowin", "Killing "..target.Player.DisplayName.." ("..(target.Player.Team and target.Player.Team.Name or "neutral").." Team)", 5)
								end
								playertween.Completed:Wait()
								if not Autowin.Enabled then return end
									if EntityNearPosition(50).RootPart and isAlive() then
										repeat
										target = EntityNearPosition(50)
										if not target.RootPart or not isAlive() then break end
										playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.75), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
										playertween:Play()
										task.wait()
										until not (EntityNearPosition(45) and EntityNearPosition(45).RootPart) or not Autowin.Enabled or not isAlive()
									end
								if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled then
									lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
									lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
								end
							else
							if VoidwareStore.GameFinished then return end
							lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							end
						end))
						table.insert(Autowin.Connections, lplr.CharacterAdded:Connect(function()
							if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
							if not VoidwareStore.GameFinished then return end
							local oldpos = lplr.Character.HumanoidRootPart.CFrame
							repeat 
							lplr.Character.HumanoidRootPart.CFrame = oldpos
							task.wait()
							until not isAlive(lplr, true) or not Autowin.Enabled
						end))
					end)
				end)
			else
				pcall(function() playertween:Cancel() end)
				pcall(function() bedtween:Cancel() end)
			end
		end,
		HoverText = "best paid autowin 2023!1!!! rel11!11!1"
	})
end)

run(function()
	local HackerDetector = {}
	local HackerDetectorInfFly = {}
	local HackerDetectorTeleport = {}
	local HackerDetectorNuker = {}
	local HackerDetectorFunny = {}
	local HackerDetectorInvis = {}
	local HackerDetectorName = {}
	local HackerDetectorSpeed = {}
	local HackerDetectorFileCache = {}
	local pastesploit
	local detectedusers = {
		InfiniteFly = {},
		Teleport = {},
		Nuker = {},
		AnticheatBypass = {},
		Invisibility = {},
		Speed = {},
		Name = {},
		Cache = {}
	}
	local distances = {
		windwalker = 80
	}
	local function cachedetection(player, detection)
		if not HackerDetectorFileCache.Enabled then 
			return 
		end
		if type(response) ~= 'table' then 
			response = {}
		end
		if response[player.Name] then 
			if table.find(response[player.Name], detection) == nil then 
				table.insert(response[player.Name].Detections, detection) 
			end
		else
			response[player.Name] = {DisplayName = player.DisplayName, UserId = tostring(player.DisplayName), Detections = {detection}}
		end
	end
	local detectionmethods = {
		Teleport = function(plr)
			if table.find(detectedusers.Teleport, plr) then 
				return 
			end
			if store.queueType:find('bedwars') == nil or plr:GetAttribute('Spectator') then 
				return 
			end
			local lastbwteleport = plr:GetAttribute('LastTeleported')
			table.insert(HackerDetector.Connections, plr:GetAttributeChangedSignal('LastTeleported'):Connect(function() lastbwteleport = plr:GetAttribute('LastTeleported') end))
			table.insert(HackerDetector.Connections, plr.CharacterAdded:Connect(function()
				oldpos = Vector3.zero
				if table.find(detectedusers.Teleport, plr) then 
					return 
				end
				 repeat task.wait() until isAlive(plr, true)
				 local oldpos2 = plr.Character.HumanoidRootPart.Position 
				 task.delay(2, function()
					if isAlive(plr, true) then 
						local newdistance = (plr.Character.HumanoidRootPart.Position - oldpos2).Magnitude 
						if newdistance >= 400 and (plr:GetAttribute('LastTeleported') - lastbwteleport) == 0 then 
							InfoNotification('HackerDetector', plr.DisplayName..' is using Teleport Exploit!', 100) 
							table.insert(detectedusers.Teleport, plr)
							cachedetection(plr, 'Teleport')
							whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
							--[[if RenderFunctions.playerTags[plr] == nil then 
								RenderFunctions:CreatePlayerTag(plr, 'SCRIPT KIDDIE', 'FF0000') 
							end--]]
						end 
					end
				 end)
			end))
		end,
		Speed = function(plr) 
			repeat task.wait() until (store.matchState ~= 0 or not HackerDetector.Enabled or not HackerDetectorSpeed.Enabled)
			if table.find(detectedusers.Speed, plr) then 
				return 
			end
			local lastbwteleport = plr:GetAttribute('LastTeleported')
			local oldpos = Vector3.zero 
			table.insert(HackerDetector.Connections, plr:GetAttributeChangedSignal('LastTeleported'):Connect(function() lastbwteleport = plr:GetAttribute('LastTeleported') end)) 
			table.insert(HackerDetector.Connections, plr.CharacterAdded:Connect(function() oldpos = Vector3.zero end))
			repeat 
				if isAlive(plr, true) then 
					local magnitude = (plr.Character.HumanoidRootPart.Position - oldpos).Magnitude
					if (plr:GetAttribute('LastTeleported') - lastbwteleport) ~= 0 and magnitude >= ((distances[plr:GetAttribute('PlayingAsKit') or ''] or 25) + (playerRaycasted(plr, Vector3.new(0, -15, 0)) and 0 or 40)) then 
						InfoNotification('HackerDetector', plr.DisplayName..' is using speed!', 60)
						whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
					end
					oldpos = plr.Character.HumanoidRootPart.Position
					task.wait(2.5)
					lastbwteleport = plr:GetAttribute('LastTeleported')
				end
			until not task.wait() or table.find(detectedusers.Speed, plr) or (not HackerDetector.Enabled or not HackerDetectorSpeed.Enabled)
		end,
		InfiniteFly = function(plr) 
			pcall(function()
				repeat 
					if isAlive(plr, true) then 
						local magnitude = (lplr.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
						if magnitude >= 10000 and playerRaycast(plr) == nil and playerRaycast({Character = {PrimaryPart = {Position = lplr.Character.HumanoidRootPart.Position}}}) then 
							InfoNotification('HackerDetector', plr.DisplayName..' is using InfiniteFly!', 60) 
							cachedetection(plr, 'InfiniteFly')
							table.insert(detectedusers.InfiniteFly, plr)
							whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
						end
						task.wait(2.5)
					end
				until not task.wait() or table.find(detectedusers.InfiniteFly, plr) or (not HackerDetector.Enabled or not HackerDetectorInfFly.Enabled)
			end)
		end,
		Invisibility = function(plr) 
			pcall(function()
				if table.find(detectedusers.Invisibility, plr) then 
					return 
				end
				repeat 
					for i,v in next, (isAlive(plr, true) and plr.Character.Humanoid:GetPlayingAnimationTracks() or {}) do 
						if v.Animation.AnimationId == 'http://www.roblox.com/asset/?id=11335949902' or v.Animation.AnimationId == 'rbxassetid://11335949902' then 
							InfoNotification('HackerDetector', plr.DisplayName..' is using Invisibility!', 60) 
							table.insert(detectedusers.Invisibility, plr)
							cachedetection(plr, 'Invisibility')
							whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
						end
					end
					task.wait(0.5)
				until table.find(detectedusers.Invisibility, plr) or (not HackerDetector.Enabled or not HackerDetectorInvis.Enabled)
			end)
		end,
		Name = function(plr) 
			pcall(function()
				repeat task.wait() until pastesploit 
				local lines = pastesploit:split('\n') 
				for i,v in next, lines do 
					if v:find('local Owner = ') then 
						local name = lines[i]:gsub('local Owner =', ''):gsub('"', ''):gsub("'", '') 
						if plr.Name == name then 
							InfoNotification('HackerDetector', plr.DisplayName..' is the owner of Godsploit! They\'re is most likely cheating.', 60) 
							cachedetection(plr, 'Name')
							whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
						end
					end
				end
				for i,v in next, ({'godsploit', 'alsploit', 'renderintents'}) do 
					local user = plr.Name:lower():find(v) 
					local display = plr.DisplayName:lower():find(v)
					if user or display then 
						InfoNotification('HackerDetector', plr.DisplayName..' has "'..v..'" in their '..(user and 'username' or 'display name')..'! They might be cheating.', 20)
						cachedetection(plr, 'Name') 
						return 
					end
				end
			end)
		end, 
		Cache = function(plr)
			local success, response = pcall(function()
				return httpService:JSONDecode(readfile('vape/Libraries/exploiters.json')) 
			end) 
			if type(response) == 'table' and response[plr.Name] then 
				InfoNotification('HackerDetector', plr.DisplayName..' is cached on the exploiter database!', 30)
				table.insert(detectedusers.Cached, plr)
				whitelist.customtags[plr.Name] = {{text = 'VAPE USER', color = Color3.new(1, 1, 0)}}
			end
		end
	}
	local function bootdetections(player)
		local detectiontoggles = {InfiniteFly = HackerDetectorInfFly, Teleport = HackerDetectorTeleport, Nuker = HackerDetectorNuker, Invisibility = HackerDetectorInvis, Speed = HackerDetectorSpeed, Name = HackerDetectorName, Cache = HackerDetectorFileCache}
		for i, detection in next, detectionmethods do 
			if detectiontoggles[i].Enabled then
			   task.spawn(detection, player)
			end
		end
	end
	HackerDetector = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = 'HackerDetector',
		HoverText = 'Notify when someone is\nsuspected of using exploits.',
		ExtraText = function() return 'Vanilla' end,
		Function = function(calling) 
			if calling then 
				for i,v in next, playersService:GetPlayers() do 
					if v ~= lplr then 
						bootdetections(v) 
					end 
				end
				table.insert(HackerDetector.Connections, playersService.PlayerAdded:Connect(bootdetections))
			end
		end
	})
	HackerDetectorTeleport = HackerDetector.CreateToggle({
		Name = 'Teleport',
		Default = true,
		Function = function() end
	})
	HackerDetectorInfFly = HackerDetector.CreateToggle({
		Name = 'InfiniteFly',
		Default = true,
		Function = function() end
	})
	HackerDetectorInvis = HackerDetector.CreateToggle({
		Name = 'Invisibility',
		Default = true,
		Function = function() end
	})
	HackerDetectorNuker = HackerDetector.CreateToggle({
		Name = 'Nuker',
		Default = true,
		Function = function() end
	})
	HackerDetectorSpeed = HackerDetector.CreateToggle({
		Name = 'Speed',
		Default = true,
		Function = function() end
	})
	HackerDetectorName = HackerDetector.CreateToggle({
		Name = 'Name',
		Default = true,
		Function = function() end
	})
	HackerDetectorFileCache = HackerDetector.CreateToggle({
		Name = 'Cached detections',
		HoverText = 'Writes (vape/Libraries/exploiters.json)\neverytime someone is detected.',
		Default = true,
		Function = function() end
	})
end)

run(function()
    local GuiLibrary = shared.GuiLibrary
	local texture_pack = {};
	texture_pack = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'TexturePack',
		HoverText = 'Customizes your texture pack.',
		Function = function(callback)
			if callback then
				if not shared.VapeSwitchServers then
					warningNotification("TexturePack - Credits", "Credits to melo and star", 1.5)
				end
				if texture_pack_m.Value == 'Noboline' then
					local Players = game:GetService("Players")
					local ReplicatedStorage = game:GetService("ReplicatedStorage")
					local Workspace = game:GetService("Workspace")
					local objs = game:GetObjects("rbxassetid://13988978091")
					local import = objs[1]
					import.Parent = game:GetService("ReplicatedStorage")
					local index = {
						{
							name = "wood_sword",
							offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
							model = import:WaitForChild("Wood_Sword"),
						},
						{
							name = "stone_sword",
							offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
							model = import:WaitForChild("Stone_Sword"),
						},
						{
							name = "iron_sword",
							offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
							model = import:WaitForChild("Iron_Sword"),
						},
						{
							name = "diamond_sword",
							offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
							model = import:WaitForChild("Diamond_Sword"),
						},
						{
							name = "emerald_sword",
							offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
							model = import:WaitForChild("Emerald_Sword"),
						},
						{
							name = "wood_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
							model = import:WaitForChild("Wood_Pickaxe"),
						},
						{
							name = "stone_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
							model = import:WaitForChild("Stone_Pickaxe"),
						},
						{
							name = "iron_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
							model = import:WaitForChild("Iron_Pickaxe"),
						},
						{
							name = "diamond_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(80), math.rad(-95)),
							model = import:WaitForChild("Diamond_Pickaxe"),
						},
						{
							name = "wood_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Wood_Axe"),
						},
						{
							name = "stone_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Stone_Axe"),
						},
						{
							name = "iron_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Iron_Axe"),
						},
						{
							name = "diamond_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(-95)),
							model = import:WaitForChild("Diamond_Axe"),
						},
					}
					local func = Workspace.Camera.Viewmodel.ChildAdded:Connect(function(tool)
						if not tool:IsA("Accessory") then
							return
						end
						for _, v in ipairs(index) do
							if v.name == tool.Name then
								for _, part in ipairs(tool:GetDescendants()) do
									if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation") then
										part.Transparency = 1
									end
								end
								local model = v.model:Clone()
								model.CFrame = tool.Handle.CFrame * v.offset
								model.CFrame = model.CFrame * CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0))
								model.Parent = tool
								local weld = Instance.new("WeldConstraint")
								weld.Part0 = model
								weld.Part1 = tool.Handle
								weld.Parent = model
								local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
								for _, part in ipairs(tool2:GetDescendants()) do
									if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation") then
										part.Transparency = 1
										if part.Name == "Handle" then
											part.Transparency = 0
										end
									end
								end
							end
						end
					end)
				elseif texture_pack_m.Value == 'Aquarium' then
					local objs = game:GetObjects("rbxassetid://14217388022")
					local import = objs[1]
					
					import.Parent = game:GetService("ReplicatedStorage")
					
					local index = {
					
						{
							name = "wood_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Wood_Sword"),
						},
						
						{
							name = "stone_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Stone_Sword"),
						},
						
						{
							name = "iron_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Iron_Sword"),
						},
						
						{
							name = "diamond_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Diamond_Sword"),
						},
						
						{
							name = "emerald_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Diamond_Sword"),
						},
						
						{
							name = "Rageblade",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Diamond_Sword"),
						},
						
					}
					
					local func = Workspace:WaitForChild("Camera").Viewmodel.ChildAdded:Connect(function(tool)
						
						if(not tool:IsA("Accessory")) then return end
						
						for i,v in pairs(index) do
						
							if(v.name == tool.Name) then
							
								for i,v in pairs(tool:GetDescendants()) do
						
									if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
										
										v.Transparency = 1
										
									end
								
								end
							
								local model = v.model:Clone()
								model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
								model.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
								model.Parent = tool
								
								local weld = Instance.new("WeldConstraint",model)
								weld.Part0 = model
								weld.Part1 = tool:WaitForChild("Handle")
								
								local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
								
								for i,v in pairs(tool2:GetDescendants()) do
						
									if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
										
										v.Transparency = 1
										
									end
								
								end
								
								local model2 = v.model:Clone()
								model2.Anchored = false
								model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
								model2.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
								model2.CFrame *= CFrame.new(0.4,0,-.9)
								model2.Parent = tool2
								
								local weld2 = Instance.new("WeldConstraint",model)
								weld2.Part0 = model2
								weld2.Part1 = tool2:WaitForChild("Handle")
							
							end
						
						end
						
					end)
				else
					local Players = game:GetService("Players")
					local ReplicatedStorage = game:GetService("ReplicatedStorage")
					local Workspace = game:GetService("Workspace")
					local objs = game:GetObjects("rbxassetid://14356045010")
					local import = objs[1]
					import.Parent = game:GetService("ReplicatedStorage")
					index = {
						{
							name = "wood_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Wood_Sword"),
						},
						{
							name = "stone_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Stone_Sword"),
						},
						{
							name = "iron_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Iron_Sword"),
						},
						{
							name = "diamond_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Diamond_Sword"),
						},
						{
							name = "emerald_sword",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
							model = import:WaitForChild("Emerald_Sword"),
						}, 
						{
							name = "rageblade",
							offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(90)),
							model = import:WaitForChild("Rageblade"),
						}, 
						   {
							name = "fireball",
									offset = CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
							model = import:WaitForChild("Fireball"),
						}, 
						{
							name = "telepearl",
									offset = CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
							model = import:WaitForChild("Telepearl"),
						}, 
						{
							name = "wood_bow",
							offset = CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
							model = import:WaitForChild("Bow"),
						},
						{
							name = "wood_crossbow",
							offset = CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
							model = import:WaitForChild("Crossbow"),
						},
						{
							name = "tactical_crossbow",
							offset = CFrame.Angles(math.rad(0), math.rad(180), math.rad(-90)),
							model = import:WaitForChild("Crossbow"),
						},
							{
							name = "wood_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-180), math.rad(-95)),
							model = import:WaitForChild("Wood_Pickaxe"),
						},
						{
							name = "stone_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-180), math.rad(-95)),
							model = import:WaitForChild("Stone_Pickaxe"),
						},
						{
							name = "iron_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(-180), math.rad(-95)),
							model = import:WaitForChild("Iron_Pickaxe"),
						},
						{
							name = "diamond_pickaxe",
							offset = CFrame.Angles(math.rad(0), math.rad(80), math.rad(-95)),
							model = import:WaitForChild("Diamond_Pickaxe"),
						},
					   {
								  
							name = "wood_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Wood_Axe"),
						},
						{
							name = "stone_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Stone_Axe"),
						},
						{
							name = "iron_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
							model = import:WaitForChild("Iron_Axe"),
						 },
						 {
							name = "diamond_axe",
							offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-95)),
							model = import:WaitForChild("Diamond_Axe"),
						 },
					
					
					
					 }
					local func = Workspace:WaitForChild("Camera").Viewmodel.ChildAdded:Connect(function(tool)
						if(not tool:IsA("Accessory")) then return end
						for i,v in pairs(index) do
							if(v.name == tool.Name) then
								for i,v in pairs(tool:GetDescendants()) do
									if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
										v.Transparency = 1
									end
								end
								local model = v.model:Clone()
								model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
								model.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
								model.Parent = tool
								local weld = Instance.new("WeldConstraint",model)
								weld.Part0 = model
								weld.Part1 = tool:WaitForChild("Handle")
								local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
								for i,v in pairs(tool2:GetDescendants()) do
									if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
										v.Transparency = 1
									end
								end
								local model2 = v.model:Clone()
								model2.Anchored = false
								model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
								model2.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
								model2.CFrame *= CFrame.new(.7,0,-.8)
								model2.Parent = tool2
								local weld2 = Instance.new("WeldConstraint",model)
								weld2.Part0 = model2
								weld2.Part1 = tool2:WaitForChild("Handle")
							end
						end
					end)
				end
			end
		end
	})
	texture_pack_m = texture_pack.CreateDropdown({
		Name = 'Mode',
		List = {
			'Noboline',
			'Aquarium',
			'Ocean'
		},
		Default = 'Noboline',
		HoverText = 'Mode to render the texture pack.',
		Function = function() end;
	});
	local Credits
	Credits = texture_pack.CreateCredits({
        Name = 'CreditsButtonInstance',
        Credits = 'Melo and Star'
    })
end)

run(function()
    local GuiLibrary = shared.GuiLibrary
	local size_changer = {};
	local size_changer_d = {};
	local size_changer_h = {};
	local size_changer_v = {};
	size_changer = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'ToolSizeChanger',
		HoverText = 'Changes the size of the tools.',
		Function = function(callback) 
			if callback then
				pcall(function()
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', -(size_changer_d.Value / 10));
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', size_changer_h.Value / 10);
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', size_changer_v.Value / 10);
					bedwars.ViewmodelController:playAnimation((10 / 2) + 6);
				end)
			else
				pcall(function()
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', 0);
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', 0);
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', 0);
					bedwars.ViewmodelController:playAnimation((10 / 2) + 6);
					cam.Viewmodel.RightHand.RightWrist.C1 = cam.Viewmodel.RightHand.RightWrist.C1;
				end)
			end;
		end;
	});
	size_changer_d = size_changer.CreateSlider({
		Name = 'Depth',
		Min = 0,
		Max = 24,
		Function = function(val)
			if size_changer.Enabled then
				pcall(function()
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', -(val / 10));
				end)
			end;
		end,
		Default = 10;
	});
	size_changer_h = size_changer.CreateSlider({
		Name = 'Horizontal',
		Min = 0,
		Max = 24,
		Function = function(val)
			if size_changer.Enabled then
				pcall(function()
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', (val / 10));
				end)
			end;
		end,
		Default = 10;
	});
	size_changer_v = size_changer.CreateSlider({
		Name = 'Vertical',
		Min = 0,
		Max = 24,
		Function = function(val)
			if size_changer.Enabled then
				pcall(function()
					lplr.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', (val / 10));
				end)
			end;
		end,
		Default = 0;
	});
	local Credits
	Credits = size_changer.CreateCredits({
        Name = 'CreditsButtonInstance',
        Credits = 'Velocity'
    })
end)

run(function()
	local invis = {};
	local invisbaseparts = safearray();
	local invisroot = {};
	local invisrootcolor = newcolor();
	local invisanim = Instance.new('Animation');
	local invisrenderstep;
	local invistask;
	local invshumanim;
	local SpiderDisabled = false
	invis = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = 'Invisibility',
		HoverText = 'Plays an animation which makes it harder\nfor targets to see you.',
		Function = function(calling)
			local invisFunction = function()
				pcall(task.cancel, invistask);
				pcall(function() invisrenderstep:Disconnect() end);
				repeat task.wait() until isAlive(lplr, true);
				for i,v in lplr.Character:GetDescendants() do 
					pcall(function()
						if v.ClassName:lower():find('part') and v.CanCollide and v ~= lplr.Character:FindFirstChild('HumanoidRootPart') then 
							v.CanCollide = false;
							table.insert(invisbaseparts, v);
						end 
					end)
				end;
				table.insert(invis.Connections, lplr.Character.DescendantAdded:Connect(function(v)
					pcall(function()
						if v.ClassName:lower():find('part') and v.CanCollide and v ~= lplr.Character:FindFirstChild('HumanoidRootPart') then 
							v.CanCollide = false;
							table.insert(invisbaseparts, v);
						end
					end) 
				end));
				task.spawn(function()
					invisrenderstep = runservice.Stepped:Connect(function()
						for i,v in invisbaseparts do 
							v.CanCollide = false;
						end
					end);
					table.insert(invis.Connections, invisrenderstep);
				end)
				invisanim.AnimationId = 'rbxassetid://11335949902';
				local anim = lplr.Character.Humanoid.Animator:LoadAnimation(invisanim);
				invishumanim = anim;
				repeat 
					task.wait()
					if GuiLibrary.ObjectsThatCanBeSaved.AnimationPlayerOptionsButton.Api.Enabled then 
						GuiLibrary.ObjectsThatCanBeSaved.AnimationPlayerOptionsButton.Api.ToggleButton();
					end
					--if isAlive(lplr, true) == false or not isnetworkowner(lplr.Character.PrimaryPart) or not invis.Enabled then 
						pcall(function() 
							anim:AdjustSpeed(0);
							anim:Stop() 
						end)
					--end
					lplr.Character.PrimaryPart.Transparency = invisroot.Enabled and 0.6 or 1;
					lplr.Character.PrimaryPart.Color = Color3.fromHSV(invisrootcolor.Hue, invisrootcolor.Sat, invisrootcolor.Value);
					anim:Play(0.1, 9e9, 0.1);
				until (not invis.Enabled)
			end;
			if calling then
				--[[task.spawn(function()
					repeat task.wait() until shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton
					if shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton.Api.Enabled then
						shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton.Api.ToggleButton(false)
						SpiderDisabled = true
						repeat task.wait() until warningNotification
						warningNotification("Invisibility", "Spider disabled to prevent suffocating. \n Will be re-enabled when invisibility gets disabled!", 10)
					end
				end) --]]
				invistask = task.spawn(invisFunction);
				table.insert(invis.Connections, lplr.CharacterAdded:Connect(invisFunction))
			else 
				--[[task.spawn(function()
					if SpiderDisabled then
						repeat task.wait() until shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton
						if (not shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton.Api.Enabled) then
							shared.GuiLibrary.ObjectsThatCanBeSaved.SpiderOptionsButton.Api.ToggleButton(false)
							SpiderDisabled = false
							repeat task.wait() until warningNotification
							warningNotification("Invisibility", "Spider re-enabled!", 10)
						end
					end
				end)--]]
				pcall(function()
					invishumanim:AdjustSpeed(0);
					invishumanim:Stop();
				end);
				pcall(task.cancel, invistask)
			end
		end
	})
	invisroot = invis.CreateToggle({
		Name = 'Show Root',
		Default = true,
		Function = function(calling)
			pcall(function() invisrootcolor.Object.Visible = calling; end)
		end
	})
	invisrootcolor = invis.CreateColorSlider({
		Name = 'Root Color',
		Function = void
	})
end)

run(function()
	local damagehighlightvisuals = {};
	local highlightcolor = newcolor();
	local highlightinvis = {Value = 4}
	damagehighlightvisuals = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'HighlightVisuals',
		HoverText = 'Changes the color of the damage highlight.',
		Function = function(calling)
			if calling then 
				task.spawn(function()
					table.insert(damagehighlightvisuals.Connections, game.Workspace.DescendantAdded:Connect(function(indicator)
						if indicator.Name == '_DamageHighlight_' and indicator.ClassName == 'Highlight' then 
							repeat 
								indicator.FillColor = Color3.fromHSV(highlightcolor.Hue, highlightcolor.Sat, highlightcolor.Value);
								indicator.FillTransparency = (0.1 * highlightinvis.Value);
								task.wait()
							until (indicator.Parent == nil)
						end;
					end))
				end)
			end
		end
	})
	highlightcolor = damagehighlightvisuals.CreateColorSlider({
		Name = 'Color',
		Function = void
	})
	highlightinvis = damagehighlightvisuals.CreateSlider({
		Name = 'Invisibility',
		Min = 0,
		Max = 10,
		Default = 4,
		Function = void
	})
end);

run(function()
	local DamageIndicator = {}
	local DamageIndicatorColorToggle = {}
	local DamageIndicatorColor = {Hue = 0, Sat = 0, Value = 0}
	local DamageIndicatorTextToggle = {}
	local DamageIndicatorText = {ObjectList = {}}
	local DamageIndicatorFontToggle = {}
	local DamageIndicatorFont = {Value = 'GothamBlack'}
	local DamageIndicatorTextObjects = {}
    local DamageMessages, OrigIndicator, OrgInd = {
		'Pow!',
		'Pop!',
		'Hit!',
		'Smack!',
		'Bang!',
		'Boom!',
		'Whoop!',
		'Damage!',
		'-9e9!',
		'Whack!',
		'Crash!',
		'Slam!',
		'Zap!',
		'Snap!',
		'Thump!'
	}, nil, OrigIndicator
	local RGBColors = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(255, 127, 0),
		Color3.fromRGB(255, 255, 0),
		Color3.fromRGB(0, 255, 0),
		Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(75, 0, 130),
		Color3.fromRGB(148, 0, 211)
	}
	local orgI, mz, vz = 1, 5, 10
    local DamageIndicatorMode = {Value = 'Rainbow'}
	local DamageIndicatorMode1 = {Value = 'Multiple'}
	local DamageIndicatorMode2 = {Value = 'Gradient'}
	local runService = game:GetService("RunService")
	DamageIndicator = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = 'DamageIndicator',
		Function = function(calling)
			if calling then
				task.spawn(function()
					table.insert(DamageIndicator.Connections, game.Workspace.DescendantAdded:Connect(function(v)
						pcall(function()
                            if v.Name ~= 'DamageIndicatorPart' then return end
							local indicatorobj = v:FindFirstChildWhichIsA('BillboardGui'):FindFirstChildWhichIsA('Frame'):FindFirstChildWhichIsA('TextLabel')
							if indicatorobj then
                                if DamageIndicatorColorToggle.Enabled then
                                    -- indicatorobj.TextColor3 = Color3.fromHSV(DamageIndicatorColor.Hue, DamageIndicatorColor.Sat, DamageIndicatorColor.Value)
                                    if DamageIndicatorMode.Value == 'Rainbow' then
                                        if DamageIndicatorMode2.Value == 'Gradient' then
                                            indicatorobj.TextColor3 = Color3.fromHSV(tick() % mz / mz, orgI, orgI)
                                        else
                                            runService.Stepped:Connect(function()
                                                orgI = (orgI % #RGBColors) + 1
                                                indicatorobj.TextColor3 = RGBColors[orgI]
                                            end)
                                        end
                                    elseif DamageIndicatorMode.Value == 'Custom' then
                                        indicatorobj.TextColor3 = Color3.fromHSV(
                                            DamageIndicatorColor.Hue, 
                                            DamageIndicatorColor.Sat, 
                                            DamageIndicatorColor.Value
                                        )
                                    else
                                        indicatorobj.TextColor3 = Color3.fromRGB(127, 0, 255)
                                    end
                                end
                                if DamageIndicatorTextToggle.Enabled then
                                    if DamageIndicatorMode1.Value == 'Custom' then
                                        indicatorobj.Text = getrandomvalue(DamageIndicatorText.ObjectList) ~= '' and getrandomvalue(DamageIndicatorText.ObjectList) or indicatorobject.Text
									elseif DamageIndicatorMode1.Value == 'Multiple' then
										indicatorobj.Text = DamageMessages[math.random(orgI, #DamageMessages)]
									else
										indicatorobj.Text = DamageIndicatorCustom.Value or 'VW on top!'
									end
								end
								indicatorobj.Font = DamageIndicatorFontToggle.Enabled and Enum.Font[DamageIndicatorFont.Value] or indicatorobject.Font
							end
						end)
					end))
				end)
			end
		end
	})
    DamageIndicatorMode = DamageIndicator.CreateDropdown({
		Name = 'Color Mode',
		List = {
			'Rainbow',
			'Custom',
			'Lunar'
		},
		HoverText = 'Mode to color the Damage Indicator',
		Value = 'Rainbow',
		Function = function() end
	})
	DamageIndicatorMode2 = DamageIndicator.CreateDropdown({
		Name = 'Rainbow Mode',
		List = {
			'Gradient',
			'Paint'
		},
		HoverText = 'Mode to color the Damage Indicator\nwith Rainbow Color Mode',
		Value = 'Gradient',
		Function = function() end
	})
    DamageIndicatorMode1 = DamageIndicator.CreateDropdown({
		Name = 'Text Mode',
		List = {
            'Custom',
			'Multiple',
			'Lunar'
		},
		HoverText = 'Mode to change the Damage Indicator Text',
		Value = 'Custom',
		Function = function() end
	})
	DamageIndicatorColorToggle = DamageIndicator.CreateToggle({
		Name = 'Custom Color',
		Function = function(calling) pcall(function() DamageIndicatorColor.Object.Visible = calling end) end
	})
	DamageIndicatorColor = DamageIndicator.CreateColorSlider({
		Name = 'Text Color',
		Function = function() end
	})
	DamageIndicatorTextToggle = DamageIndicator.CreateToggle({
		Name = 'Custom Text',
		HoverText = 'random messages for the indicator',
		Function = function(calling) pcall(function() DamageIndicatorText.Object.Visible = calling end) end
	})
	DamageIndicatorText = DamageIndicator.CreateTextList({
		Name = 'Text',
		TempText = 'Indicator Text',
		AddFunction = function() end
	})
	DamageIndicatorFontToggle = DamageIndicator.CreateToggle({
		Name = 'Custom Font',
		Function = function(calling) pcall(function() DamageIndicatorFont.Object.Visible = calling end) end
	})
	DamageIndicatorFont = DamageIndicator.CreateDropdown({
		Name = 'Font',
		List = GetEnumItems('Font'),
		Function = function() end
	})
	DamageIndicatorColor.Object.Visible = DamageIndicatorColorToggle.Enabled
	DamageIndicatorText.Object.Visible = DamageIndicatorTextToggle.Enabled
	DamageIndicatorFont.Object.Visible = DamageIndicatorFontToggle.Enabled
end)

	pcall(function()
	local StaffDetector = {Enabled = false}
	run(function()
		local TPService = game:GetService('TeleportService')
		local HTTPService = game:GetService("HttpService")
		local StaffDetector_Connections = {}
		local StaffDetector_Functions = {}
		local StaffDetector_Extra = {
			JoinNotifier = {Enabled = false}
		}
		local StaffDetector_Checks = {
			CustomBlacklist = {
				"chasemaser",
				"OrionYeets",
				"lIllllllllllIllIIlll",
				"AUW345678",
				"GhostWxstaken",
				"throughthewindow009",
				"YT_GoraPlays",
				"IllIIIIlllIlllIlIIII",
				"celisnix",
				"7SlyR",
				"DoordashRP",
				"IlIIIIIlIIIIIIIllI",
				"lIIlIlIllllllIIlI",
				"IllIIIIIIlllllIIlIlI",
				"asapzyzz",
				"WhyZev",
				"sworduserpro332",
				"Muscular_Gorilla",
				"Typhoon_Kang"
			}
		}
		local StaffDetector_Action = {
			DropdownValue = {Value = "Uninject"},
			FunctionsTable = {
				["Uninject"] = function() GuiLibrary.SelfDestruct() end, 
				["Panic"] = function() 
					task.spawn(function() coroutine.close(shared.saveSettingsLoop) end)
					GuiLibrary.SaveSettings()
					function GuiLibrary.SaveSettings() return warningNotification("GuiLibrary - SaveSettings", "Saving Settings has been prevented from staff detector!", 1.5) end
					warningNotification("StaffDetector", "Saving settings has been disabled!", 1.5)
					task.spawn(function()
						repeat task.wait() until shared.GuiLibrary.ObjectsThatCanBeSaved.PanicOptionsButton
						shared.GuiLibrary.ObjectsThatCanBeSaved.PanicOptionsButton.Api.ToggleButton(false)
					end)
				end,
				["Lobby"] = function() TPService:Teleport(6872265039) end
			},
		}
		function StaffDetector_Functions.SaveStaffData(staff, detection_type)
			local suc, res = pcall(function() return HTTPService:JSONDecode(readfile('vape/Libraries/StaffData.json')) end)
			local json = suc and res or {}
			table.insert(json, {StaffName = staff.DisplayName.."(@"..staff.Name..")", Time = os.time(), DetectionType = detection_type})
			if (not isfolder('vape/Libraries')) then makefolder('vape/Libraries') end
			writefile('vape/Libraries/StaffData.json', HTTPService:JSONEncode(json))
		end
		function StaffDetector_Functions.Notify(text)
			pcall(function()
				warningNotification("StaffDetector", tostring(text), 30)
				game:GetService('StarterGui'):SetCore('ChatMakeSystemMessage', {Text = text, Color = Color3.fromRGB(255, 0, 0), Font = Enum.Font.GothamBold, FontSize = Enum.FontSize.Size24})
			end)
		end
		function StaffDetector_Functions.Trigger(plr, det_type, addInfo)
			StaffDetector_Functions.SaveStaffData(plr, det_type)
			local text = plr.DisplayName.."(@"..plr.Name..") has been detected as staff via "..det_type.." detection type! "..StaffDetector_Action.DropdownValue.." action type will be used shortly."
			if addInfo then text = text.." Additonal Info: "..addInfo end
			StaffDetector_Functions.Notify(text)
			StaffDetector_Action.FunctionsTable[StaffDetector_Action.DropdownValue]()
		end
		function StaffDetector_Checks:groupCheck(plr)
			local suc, plrRank = pcall(function() plr:GetRankInGroup(5774246) end)
			if (not suc) then plrRank = 0 end
			local state, Type = false, nil
			local Rank_Table = {[79029254] = "AC MOD", [86172137] = "Lead AC MOD (chase :D)", [43926962] = "Developer", [37929139] = "Developer", [87049509] = "Owner", [37929138] = "Owner"}
			if StaffDetector_CustomBlacklist.YoutuberToggle.Enabled then Rank_Table[42378457] = "Youtuber/Famous" end
			if Rank_Table[plrRank] then state = true; Type = Rank_Table[plrRank] end
			if state then StaffDetector_Functions.Trigger(plr, "Group Check", "Rank: "..tostring(Type)) end
		end
		function StaffDetector_Checks:checkCustomBlacklist(plr) if table.find(self.CustomBlacklist, plr.Name) then StaffDetector_Functions.Trigger(plr, "CustomBlacklist") end end
		function StaffDetector_Checks:checkPermissions(plr)
			local KnitGotten, KnitClient
			repeat
				KnitGotten, KnitClient = pcall(function() return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6) end)
				if KnitGotten then break end
				task.wait()
			until KnitGotten
			repeat task.wait() until debug.getupvalue(KnitClient.Start, 1)
			local PermissionController = KnitClient.Controllers.PermissionController
			if KnitClient.Controllers.PermissionController:isStaffMember(plr) then StaffDetector_Functions.Trigger(plr, "PermissionController") end
		end
		function StaffDetector_Checks:check(plr)
			task.spawn(function() pcall(function() self:checkCustomBlacklist(plr) end) end)
			task.spawn(function() pcall(function() self:checkPermissions(plr) end) end)
			task.spawn(function() pcall(function() self:groupCheck(plr) end) end)
		end
		StaffDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
			Name = "StaffDetector [NEW]",
			Function = function(call)
				if call then
					for i,v in pairs(game:GetService("Players"):GetPlayers()) do if v ~= game:GetService("Players").LocalPlayer then StaffDetector_Checks:check(v) end end
					local con = game:GetService("Players").PlayerAdded:Connect(function(v)
						if StaffDetector.Enabled then 
							StaffDetector_Checks:check(v) 
							if StaffDetector_Extra.JoinNotifier.Enabled and store.matchState > 0 then warningNotification("StaffDetector", tostring(v.Name).." has joined!", 3) end
						end
					end)
					table.insert(StaffDetector_Connections, con)
				else for i, v in pairs(StaffDetector_Connections) do if v.Disconnect then pcall(function() v:Disconnect() end) continue end; if v.disconnect then pcall(function() v:disconnect() end) continue end end end
			end
		})
		StaffDetector.Restart = function() if StaffDetector.Enabled then StaffDetector.ToggleButton(false); StaffDetector.ToggleButton(false) end end
		local list = {}
		for i,v in pairs(StaffDetector_Action.FunctionsTable) do table.insert(list, i) end
		StaffDetector_Action.DropdownValue = StaffDetector.CreateDropdown({Name = 'Action', List = list, Function = function() end})
		StaffDetector_Extra.JoinNotifier = StaffDetector.CreateToggle({Name = "Illegal player notifier", Function = StaffDetector.Restart, Default = true})
	end)
	
	task.spawn(function()
		pcall(function()
			repeat task.wait() until shared.VapeFullyLoaded
			if (not StaffDetector.Enabled) then StaffDetector.ToggleButton(false) end
		end)
	end)
end)
