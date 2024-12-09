repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary
repeat task.wait() until shared.GlobalBedwars

local GuiLibrary = shared.GuiLibrary

local vapeConnections
if shared.vapeConnections and type(shared.vapeConnections) == "table" then vapeConnections = shared.vapeConnections else vapeConnections = {}; shared.vapeConnections = vapeConnections; end
GuiLibrary.SelfDestructEvent.Event:Connect(function()
	for i, v in pairs(vapeConnections) do
		if v.Disconnect then pcall(function() v:Disconnect() end) continue end
		if v.disconnect then pcall(function() v:disconnect() end) continue end
	end
end)

local function run(func)
	local suc, err = pcall(function()
		func()
	end)
	if err then warn("[VW6872265039.lua Module Error]: "..tostring(debug.traceback(err))) end
end

local lplr = game:GetService("Players").LocalPlayer

local bedwars = shared.GlobalBedwars

local function BedwarsInfoNotification(mes)
    local bedwars = shared.GlobalBedwars
	local NotificationController = bedwars.NotificationController
	NotificationController:sendInfoNotification({
		message = tostring(mes),
		image = "rbxassetid://18518244636"
	});
end
VoidwareFunctions.GlobaliseObject("BedwarsInfoNotification", BedwarsInfoNotification)
local function BedwarsErrorNotification(mes)
    local bedwars = shared.GlobalBedwars
	local NotificationController = bedwars.NotificationController
	NotificationController:sendErrorNotification({
		message = tostring(mes),
		image = "rbxassetid://18518244636"
	});
end
VoidwareFunctions.GlobaliseObject("BedwarsErrorNotification", BedwarsErrorNotification)

local function queue()
	local args = {
		[1] = {
			["queueType"] = "bedwars_duels"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"):WaitForChild("joinQueue"):FireServer(unpack(args))
end

if shared.TeleportExploitAutowinEnabled then
	local interactable_buttons_table = {
		[1] = {
			["Name"] = "Yes",
			["Function"] = function()
				shared.MadeChoice = true
				shared.TeleportExploitAutowinEnabled = nil
				queue()
			end
		},
		[2] = {
			["Name"] = "No",
			["Function"] = function()
				shared.TeleportExploitAutowinEnabled = nil
				shared.MadeChoice = true 
			end
		}
	}
	local function InfoNotification2(title, text, delay, button_table)
		local suc, res = pcall(function()
			local frame = GuiLibrary.CreateInteractableNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/InfoNotification.png", button_table)
			return frame
		end)
		return (suc and res)
	end
	InfoNotification2("EmptyGameTP - AutowinMode", "An error might have happened while auto-queueing. Would you like to \n join back to the queue?", 10000000, interactable_buttons_table)
	task.wait(3)
	if (not shared.MadeChoice) then queue() end
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
	local AutoCrate = {Enabled = false}
	local aut = 0
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local rbxts_include = replicatedStorage:WaitForChild("rbxts_include")
	local net = rbxts_include:WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged")

	local function openCrate(crateType, altarId, crateName)
		local spawnArgs = {
			[1] = {
				["crateType"] = crateType,
				["altarId"] = altarId
			}
		}
		net:WaitForChild("RewardCrate/SpawnRewardCrate"):FireServer(unpack(spawnArgs))

		local crateAltar = game.Workspace:FindFirstChild("CrateAltar_" .. altarId)
		if crateAltar and crateAltar:FindFirstChild(crateName) then
			local openArgs = {
				[1] = {
					["crateId"] = tostring(crateAltar:FindFirstChild(crateName):GetAttribute("crateId"))
				}
			}
			net:WaitForChild("RewardCrate/OpenRewardCrate"):FireServer(unpack(openArgs))
		end
	end

	AutoCrate = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = "AutoCrate",
		HoverText = "Automatically open crates if you have any.",
		Function = function(callback)
			if callback then
			    task.spawn(function()
			        repeat task.wait()
			        aut = aut + 1
					if aut >= 45 then
						openCrate("level_up_crate", 0, "RewardCrate")
						openCrate("level_up_crate", 1, "RewardCrate")
						openCrate("diamond_lucky_crate", 0, "DiamondLuckyCrate")
						openCrate("diamond_lucky_crate", 1, "DiamondLuckyCrate")
						aut = 0
					end
			        until not AutoCrate.Enabled
			    end)
				--RunLoops:BindToStepped("crate", 1, function()
				--end)
			else
				--RunLoops:UnbindFromStepped("crate")
			end
		end
	})
end)

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
        table.insert(vapeConnections, displayName:GetPropertyChangedSignal("Text"):Connect(function()
            if displayName.Text ~= tag..lplr.Name then
                displayName.Text = tag..lplr.Name
            end
        end))
    end)
end)

local GuiLibrary = shared.GuiLibrary
shared.slowmode = 0
run(function() 
    local function resetSlowmode()
        task.spawn(function()
            repeat shared.slowmode = shared.slowmode - 1 task.wait(1) until shared.slowmode < 1
            shared.slowmode = 0
        end)
    end
    local HS = game:GetService("HttpService")
    local StaffDetector = {}
    local StaffDetector_Games = {Value = "Bedwars"}
    local Custom_Group = {Enabled = false}
	local IgnoreOnlineStaff = {Enabled = false}
	local AutoCheck = {Enabled = false}
    local Roles_List = {ObjectList = {}}
    local Custom_GroupId = {Value = ""}
    local Staff_Members_Limit = {Value = 50}
    local Games_StaffTable = {
        ["Bedwars"] = {
            ["groupid"] = 5774246,
            ["roles"] = {
                79029254,
                86172137,
                43926962,
                37929139,
                87049509,
                37929138
            }
        },
		["PS99"] = {
			["groupid"] = 5060810,
			["roles"] = {
				33738740,
				33738765
			}
		}
    }
    local function getUsersInRole(groupId, roleId, cursor)
        local limit = Staff_Members_Limit.Value or 100
        local url = "https://groups.roblox.com/v1/groups/"..groupId.."/roles/"..roleId.."/users?limit="..limit
        if cursor then
            url = url .. "&cursor=" .. cursor
        end
    
        local response = request({
            Url = url,
            Method = "GET"
        })
    
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    local function getUserPresence(userIds)
        local url = "https://presence.roblox.com/v1/presence/users"
        local requestBody = game:GetService("HttpService"):JSONEncode({userIds = userIds})
    
        local response = request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = requestBody
        })
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    local function getUsersInRoleWithPresence(groupId, roleId)
        local users = {}
        local cursor = nil
        local userIds = {}
        repeat
            local data = getUsersInRole(groupId, roleId, cursor)
            for _, user in pairs(data.data) do
                table.insert(users, user)
                table.insert(userIds, user.userId)
            end
            cursor = data.nextPageCursor
        until not cursor
        local presenceData = getUserPresence(userIds)
        for _, user in pairs(users) do
            for _, presence in pairs(presenceData.userPresences) do
                if user.userId == presence.userId then
                    user.presenceType = presence.userPresenceType
                    user.lastLocation = presence.lastLocation
                    break
                end
            end
        end
        return users
    end
    local function getGroupRoles(groupId)
        local url = "https://groups.roblox.com/v1/groups/"..groupId.."/roles"
        local res = request({
            Url = url,
            Method = "GET"
        })
        if res.StatusCode == 200 then
            local roles = {}
            for i,v in pairs(HS:JSONDecode(res.Body).roles) do
                table.insert(roles, v.id)
            end
            return true, roles, nil
        else
            return false, nil, "Status Code isnt 200! "..res.StatusCode
        end
    end
    local function getData()
        if Custom_Group.Enabled then
            local suc1, custom_group_id, err1 = false, "", nil
            if Custom_GroupId.Value ~= "" then
                suc1 = true
                custom_group_id = tonumber(Custom_GroupId.Value)
            else 
                suc1 = false
                custom_group_id = nil
                err1 = "Custom GroupID not specified!" 
            end
            local suc2, roles, err2 = false, {}, nil
            if #Roles_List.ObjectList < 1 then
                suc2 = false
                roles = nil
                err2 = "Roles not specified!"
            else
                if suc1 then
                    local suc3, res, err3 = getGroupRoles(custom_group_id)
                    if suc3 then
                        suc2 = true
                        roles = res
                    else
                        err2 = err3
                    end
                end
            end
            return {suc1, custom_group_id, err1}, {suc2, roles, err2}, "Custom"
        else
            if StaffDetector_Games.Value ~= "" then
                local roles = Games_StaffTable[StaffDetector_Games.Value]["roles"]
                local groupid = Games_StaffTable[StaffDetector_Games.Value]["groupid"]
                return {true, groupid, nil}, {true, roles, nil}, "Normal"
            else
                return {false, nil, nil}, {false, nil, nil}, "Normal"
            end
        end
    end
    local core_table = {}
    local function handle_checks(groupid, roleid)
        local res = getUsersInRoleWithPresence(groupid, roleid)
        for _, user in pairs(res) do
            local presenceStatus = "Offline"
            if user.presenceType == 1 then
                presenceStatus = "Online"
            elseif user.presenceType == 2 then
                presenceStatus = "In Game"
            elseif user.presenceType == 3 then
                presenceStatus = "In Studio"
            end
			local function online()
				if IgnoreOnlineStaff.Enabled then
					if presenceStatus == "Online" then
						return true
					else
						return false
					end
				else
					return false
				end
			end
            if (presenceStatus == "In Game" or online()) then
                table.insert(core_table, {["UserID"] = user.userId, ["Username"] = user.username, ["Status"] = presenceStatus})
            end
            print("Username: " .. user.username .. " - UserID: " .. user.userId .. " - Status: " .. presenceStatus)
        end
    end
	local checked_data = {}
	StaffDetector = GuiLibrary.ObjectsThatCanBeSaved.VoidwareWindow.Api.CreateOptionsButton({
		Name = 'StaffDetector',
		Function = function(calling)
			if calling then 
				if (not AutoCheck.Enabled) then
					StaffDetector["ToggleButton"](false) 
				end
				if AutoCheck.Enabled then errorNotification("StaffDetector-AutoCheck", "Please disable auto check to manually use this module!", 5) end
                if shared.slowmode > 0 then if (not AutoCheck.Enabled) then return errorNotification("StaffDetector-Slowmode", "You are currently on slowmode! Wait "..tostring(shared.slowmode).."seconds!", shared.slowmode) end end
				shared.slowmode = 5
                resetSlowmode()
				InfoNotification("StaffDetector", "Sent request! Please wait...", 5)
				local function dostuff()
					local limit = Staff_Members_Limit.Value
					local tbl1, tbl2, Type = getData()
                    local suc1, res1, err1 = tbl1[1], tbl1[2], tbl1[3]
                    local suc2, res2, err2 = tbl2[1], tbl2[2], tbl2[3]    
					local handle_table = {}    
					local number = 0      
					if (suc1 and suc2) then
						for i,v in pairs(res2) do handle_checks(res1, v) end
						for i,v in pairs(core_table) do
							if (not table.find(handle_table, tostring(v["UserID"]))) then
								table.insert(handle_table, tostring(v["UserID"]))
								number = number + 1
                                local a, b, c = tostring(v["UserID"]), tostring(v["Username"]), tostring(v["Status"])
								local function checked()
									for i,v in pairs(checked_data) do
										if v["UserID"] == a then
											if v["Status"] == c then
												return true
											end
										end
									end
									return false
								end
								if checked() then return end
								table.insert(checked_data, {["UserID"] = a, ["Status"] = c})
								if tostring(v["Status"]) == "Online" then
									if (not IgnoreOnlineStaff.Enabled) then
										errorNotification("StaffDetector", "@"..b.."("..a..") is currently "..c, 7)
									end
								else
									errorNotification("StaffDetector", "@"..b.."("..a..") is currently "..c, 7)
								end
							end
						end
						InfoNotification("StaffDetector", tostring(number).." total staffs were detected as online/ingame!", 7)
					else
						shared.slowmode = 0
						if (not suc1) then
							errorNotification("StaffDetector-GroupID Error", tostring(err1), 5)
						end
						if (not suc2) then
							errorNotification("StaffDetector-Roles Error", tostring(err2), 5)
						end
					end
				end
				if (not AutoCheck.Enabled) then
					dostuff()
				else
					task.spawn(function()
						repeat 
							dostuff()
							task.wait(30)
						until (not StaffDetector.Enabled) or (not AutoCheck.Enabled)
						StaffDetector["ToggleButton"](false) 
					end)
				end
			end
		end
	}) 
    local list = {}
    for i,v in pairs(Games_StaffTable) do table.insert(list, i) end
    StaffDetector_Games = StaffDetector.CreateDropdown({
		Name = "GameChoice",
		Function = function() end,
		List = list
	})
    Roles_List = StaffDetector.CreateTextList({
		Name = "CustomRoles",
		TempText = "RoleId (number)"
	})
    Custom_GroupId = StaffDetector.CreateTextBox({
        Name = "CustomGroupId",
        TempText = "Type here a groupid",
        TempText = "GroupId (number)",
        Function = function() end
    })
    Custom_GroupId.Object.Visible = false
    Roles_List.Object.Visible = false
    Custom_Group = StaffDetector.CreateToggle({
		Name = "CustomGroup",
		Function = function(calling)
            if calling then
                Custom_GroupId.Object.Visible = true
                Roles_List.Object.Visible = true
                StaffDetector_Games.Object.Visible = false
            else
                Custom_GroupId.Object.Visible = false
                Roles_List.Object.Visible = false
                StaffDetector_Games.Object.Visible = true
            end
        end,
		HoverText = "Choose another staff group",
		Default = false
	})
	IgnoreOnlineStaff = StaffDetector.CreateToggle({
		Name = "IgnoreOnlineStaff",
		Function = function() end,
		HoverText = "Make the module ignore online staff and only \n show ingame staff",
		Default = false
	})
    Staff_Members_Limit = StaffDetector.CreateSlider({
		Name = "StaffMembersLimit",
		Min = 1,
		Max = 100,
		Function = function() end,
		Default = 100
	})
	AutoCheck = StaffDetector.CreateToggle({
		Name = "AutoCheck",
		Function = function() end,
		HoverText = "Checks for new staffs every 30 seconds",
		Default = false
	}) --- work in progress
	task.spawn(function()
		repeat task.wait() until shared.vapewhitelist.loaded
		if shared.vapewhitelist:get(game:GetService("Players").LocalPlayer) ~= 2 then AutoCheck.Object.Visible = false end
	end)
end)

run(function() 
	local ScytheFunny = {}
	ScytheFunny = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = 'ScytheFunny',
		Function = function(calling)
			if calling then 
				repeat 
					task.wait()
					game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SkyScytheSpin"):FireServer()
				until (not ScytheFunny.Enabled)
			end
		end
	}) 
end)

--[[run(function()
    local LeaderboardEditor = {Enabled = false}
    local RankIconTable = {["Emerald"] = "rbxassetid://12599231807",["Nightmare"] = "rbxassetid://7904292926",["Voidware"] = "rbxassetid://18518244636"}
    local AllowedMethods = {["Place"] = true,["Username"] = true,["RP"] = true}
    local AllowedEditMethods = {["Place"] = true,["Username"] = true,["RP"] = true, ["CrownIconColor"] = true, ["RankIcon"] = true, ["RankName"] = true}
    local ExtraFunctions = {extractUsername = function(richText) return richText:match("@</font></b>(.+)") end, extractNumberBeforeRP = function(text) return tonumber(text:match("<b>(%d+)%sRP</b>")) end, extractBoldText = function(text) return text:match("<b>(.-)</b>") end, resolvePlayerUserID = function(username) return game:GetService("Players"):GetUserIdFromNameAsync(username) end, resolveProfileImage = function(userid) return "rbxthumb://type=AvatarHeadShot&id="..tostring(userid).."&w=60&h=60" end, resolveUsername = function(username) return string.format('<b><font color="rgb(185, 188, 255)">@</font></b>%s', username) end, resolveNumberBeforeRP = function(number) return string.format('<b>%d RP</b>', number) end, resolveBoldText = function(text) return string.format('<b>%s</b>', text) end, resolveIconID = function(iconName) return RankIconTable[iconName] end, fetchDefaultTable = function() return {Place = nil, CrownIcon = nil, User = {Name = nil, Profile = nil}, Rank = {Name = nil, Icon = nil, RP = nil}} end}
    local function getBoard()
        --assert(game.workspace:findFirstChild("Lobby") and game.workspace:findFirstChild("Lobby").ClassName == "Folder", "Error finding Lobby folder in workspace!")
        local suc, Leaderboard, Statboard = false, "Not found", "Not found"
        for i,v in pairs(game.workspace:WaitForChild("Lobby"):GetChildren()) do
            if v.Name == "Podium" and v.ClassName == "Model" and v:FindFirstChild("Boards") then
                if v:FindFirstChild("Boards").ClassName == "Folder" then
                    suc = true
                    Leaderboard = v:findFirstChild("Boards"):FindFirstChild("Leaderboard") or "Not found"
                    Statboard = v:findFirstChild("Boards"):FindFirstChild("Statboard") or "Not found"
                end
            end
        end
        return {Status = suc, Response = {Leaderboard = Leaderboard, Statboard = Statboard}}
    end
    local function findChild(name, className, children)
        for i,v in pairs(children) do if v.Name == name and v.ClassName == className then return v end end
        local args = {Name = tostring(name), ClassName == tostring(className), Children = children}
        warn("[findChild]: CHILD NOT FOUND! Args: ", game:GetService("HttpService"):JSONEncode(args), name, className, children)
        return nil
    end
    local function getLeaderboardFrame(Leaderboard)
        local board = findChild("Board", "Part", Leaderboard:GetChildren())
        if board then
            local leaderboardApp = findChild("LeaderboardApp", "SurfaceGui", board:GetChildren())
            if leaderboardApp then
                local frame_1 = findChild("1", "Frame", leaderboardApp:GetChildren())
                if frame_1 then
                    local frame_1_1 = findChild("1", "Frame", frame_1:GetChildren())
                    if frame_1_1 then
                        local frame_2 = findChild("2", "Frame", frame_1_1:GetChildren())
                        if frame_2 then
                            local AutoCanvasScrollingFrame = findChild("AutoCanvasScrollingFrame", "ScrollingFrame", frame_2:GetChildren())
                            if AutoCanvasScrollingFrame then return AutoCanvasScrollingFrame end
                        end
                    end
                end
            end
        end
    end
    local function resolveLeaderboardChildData(child)
        local leaderboard_data = ExtraFunctions.fetchDefaultTable()
        local leaderboard_editor = ExtraFunctions.fetchDefaultTable()
        local PlayerContainer, StatValuesContainer, CrownIcon = findChild("PlayerContainer", "Frame", child:GetChildren()), findChild("StatValuesContainer", "Frame", child:GetChildren()), findChild("CrownIcon", "ImageLabel", child.Parent:GetChildren())
        if PlayerContainer then
            local LeaderboardRank, PlayerUsername, PlayerAvatar = findChild("LeaderboardRank", "TextLabel", PlayerContainer:GetChildren()), findChild("PlayerUsername", "TextLabel", PlayerContainer:GetChildren()), findChild("PlayerAvatar", "ImageLabel", PlayerContainer:GetChildren())
            if LeaderboardRank then leaderboard_data.Place = tonumber(LeaderboardRank.Text); leaderboard_editor.Place = LeaderboardRank end
            if PlayerUsername then leaderboard_data.User.Name = ExtraFunctions.extractUsername(PlayerUsername.Text); leaderboard_editor.User.Name = PlayerUsername end
            if PlayerAvatar then leaderboard_data.User.Profile = PlayerAvatar.Image; leaderboard_editor.User.Profile = PlayerAvatar end
        end 
        if StatValuesContainer then
            local StatValue, frame_2 = findChild("StatValue", "TextLabel", StatValuesContainer:GetChildren()), findChild("2", "Frame", StatValuesContainer:GetChildren())
            if StatValue then leaderboard_data.Rank.RP = ExtraFunctions.extractNumberBeforeRP(StatValue.Text); leaderboard_editor.Rank.RP = StatValue end
            if frame_2 then
                local image_2, text_3 = findChild("2", "ImageLabel", frame_2:GetChildren()), findChild("3", "TextLabel", frame_2:GetChildren())
                if image_2 then leaderboard_data.Rank.Icon = image_2.Image; leaderboard_editor.Rank.Icon = image_2 end
                if text_3 then leaderboard_data.Rank.Name = ExtraFunctions.extractBoldText(text_3.Text); leaderboard_editor.Rank.Name = text_3 end
            end
        end
        if CrownIcon then leaderboard_data.CrownIcon = CrownIcon.Image; leaderboard_editor.CrownIcon = CrownIcon end
        return {data = leaderboard_data, editor = leaderboard_editor}
    end
    local function checkResolveResponseOfLeaderboard(methodType, methodArg, res)
        local editor = res.editor
        local MethodTypeMethods = {["Place"] = function(full) return ExtraFunctions.extractBoldText(editor.Place.Text) end,["Username"] = function(full) return ExtraFunctions.extractUsername(editor.User.Name.Text) end,["RP"] = function(full) return ExtraFunctions.extractNumberBeforeRP(editor.Rank.RP.Text) end}
        local a = MethodTypeMethods[methodType](res.editor)
        if a == methodArg or a == tostring(methodArg) or a == tonumber(methodArg) then return true, res else return false, nil end
    end
    local function getResolveResponseOfLeaderboard(leaderboard_frame, methodType, methodArg) 
        if leaderboard_frame then
            for i,v in pairs(leaderboard_frame:GetChildren()) do
                local LeaderboardElementBody = findChild("LeaderboardElementBody", "Frame", v:GetChildren())
                if LeaderboardElementBody then
                    local UserLeaderBoardDataContainer = findChild("UserLeaderBoardDataContainer", "Frame", LeaderboardElementBody:GetChildren()) 
                    if UserLeaderBoardDataContainer then
                        --return resolveLeaderboardChildData(UserLeaderBoardDataContainer)
                        local suc, res = checkResolveResponseOfLeaderboard(methodType, methodArg, resolveLeaderboardChildData(UserLeaderBoardDataContainer))
                        if suc then return res end
                    end
                end
            end
            warn("ERROR FINDING PROPER CHILD!")
            return nil
        else
            warn("Failure getting leaderboard frame!")
        end
    end
    local function getLeaderboardChild(methodType, methodArg, leaderboard) if AllowedMethods[methodType] then return getResolveResponseOfLeaderboard(getLeaderboardFrame(leaderboard), methodType, methodArg) else return false end end
    local function resolveEditArgs(editArgs, editor)
        local resolveTable = {Place = editor.Place, Username = editor.User.Name, ProfileImage = editor.User.Profile, RankName = editor.Rank.Name, RP = editor.Rank.RP, RankIcon = editor.Rank.Icon, CrownIcon = editor.CrownIcon}
        local function handleEditResolve(editName, editArg)
            if resolveTable[editName] then
                if editName == "Place" then resolveTable[editName].Text = ExtraFunctions.resolveBoldText(editArg);
                elseif editName == "Username" then resolveTable[editName].Text = ExtraFunctions.resolveUsername(editArg);
                elseif editName == "ProfileImage" then resolveTable[editName].Image = ExtraFunctions.resolveProfileImage(ExtraFunctions.resolvePlayerUserID(editArg));
                elseif editName == "RankName" then resolveTable[editName].Text = ExtraFunctions.resolveBoldText(editArg);
                elseif editName == "RP" then resolveTable[editName].Text = ExtraFunctions.resolveNumberBeforeRP(editArg);
                elseif editName == "RankIcon" then resolveTable[editName].Image = ExtraFunctions.resolveIconID(editArg);
                elseif editName == "CrownIcon" and resolveTable[editName] then resolveTable[editName].ImageColor3 = editArg end
            end
        end
        for i,v in pairs(editArgs) do handleEditResolve(i, v) end
    end
    local function EditLeaderboard(methodType, methodArg, editArgs)
        local res = getBoard()
        local status, response = res.Status, res.Response
        if status == true then
            local Leaderboard, Statboard = response.Leaderboard, response.Statboard
            local resolve = getLeaderboardChild(methodType, methodArg, Leaderboard)
            local editor
            if resolve then editor = resolve.editor end
            if editor then resolveEditArgs(editArgs, editor) else warn("NO EDITOR FOUND!") end
        end
    end
    local function msend(mes, dur)
        warningNotification("LeaderboardEditor", mes, dur or 5)
    end

    local LeaderboardEditor_Types = {}
    local LeaderboardEditor_Editors = {}

    local Leaderboard_AddOnCreator_Helper = {}

    local function fetchToggleObjectData(name)
        local a = "LeaderboardEditor"..name.."Toggle"
        local b = shared.GuiLibrary.ObjectsThatCanBeSaved[a] or {Api = {Enabled = false}}
        return b.Api
    end

    local function fetchValidEditArgs()
        local validated = {Place = LeaderboardEditor_Editors["Place"][Leaderboard_AddOnCreator_Helper["Place"].ResType]}
        for i,v in pairs(LeaderboardEditor_Editors) do
            --print(fetchToggleObjectData(i).Enabled)
            if fetchToggleObjectData(i).Enabled == true then
                --print("[1]", i)
                if i == "Username" then
                    validated[i] = v[Leaderboard_AddOnCreator_Helper[i].ResType]
                    validated["ProfileImage"] = v[Leaderboard_AddOnCreator_Helper[i].ResType]
                elseif i == "CrownIconColor" then
                    validated[i] = Color3.new(v.Hue, v.Sat, v.Value)
                else
                    validated[i] = v[Leaderboard_AddOnCreator_Helper[i].ResType]
                end
            --else
              --  print("[2]", i)
            end
        end
        --print(game:GetService("HttpService"):JSONEncode(validated))
        return validated
    end

    local function fetchObjectData(name)
        local function convertText(input) return input:gsub("^Create", "") end
        local a = "LeaderboardEditor"..name..convertText(Leaderboard_AddOnCreator_Helper[name].Type)
        if Leaderboard_AddOnCreator_Helper[name].Type == "ColorSlider" then a = a.."Color" end
        return shared.GuiLibrary.ObjectsThatCanBeSaved[a]
    end

    local function checkAddOns()
        for i,v in pairs(LeaderboardEditor_Editors) do if i ~= "Place" then  fetchObjectData(i).Object.Visible = false end end
        for i,v in pairs(LeaderboardEditor_Types) do if fetchToggleObjectData(i).Enabled == true then fetchObjectData(i).Object.Visible = true end end
    end

    LeaderboardEditor = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
        Name = "LeaderboardEditor",
        Function = function(call)
            checkAddOns()
            if call then
                EditLeaderboard("Place", LeaderboardEditor_Editors.Place[Leaderboard_AddOnCreator_Helper["Place"].ResType], fetchValidEditArgs())
                getgenv().EditLeaderboard = EditLeaderboard
                msend("Hello")
            else
                getgenv().EditLeaderboard = nil
            end
        end
    })
    local function fetchDefaultFunction(call) if call then LeaderboardEditor.Restart() end end
    local function fetchRankIconNames() local iconNames = {}; for i,v in pairs(RankIconTable) do table.insert(iconNames, i) end; return iconNames end

    local function registerType(typeName)
        if typeName == "Place" then LeaderboardEditor_Editors["Place"] = {Value = 1}; Leaderboard_AddOnCreator_Helper["Place"] = {Type = "CreateTextBox", Args = {Name = "Place", TempText = "PlaceNumber", Function = fetchDefaultFunction}, ResType = "Value"}; 
        elseif typeName == "Username" then LeaderboardEditor_Editors["Username"] = {Value = game:GetService("Players").LocalPlayer.Name}; Leaderboard_AddOnCreator_Helper["Username"] = {Type = "CreateTextBox", Args = {Name = "Username", TempText = "username", Function = fetchDefaultFunction}, ResType = "Value"};
        elseif typeName == "RP" then LeaderboardEditor_Editors["RP"] = {Value = 9999}; Leaderboard_AddOnCreator_Helper["RP"] = {Type = "CreateTextBox", Args = {Name = "RP", TempText = "RP (number)", Function = fetchDefaultFunction}, ResType = "Value"}; 
        elseif typeName == "RankIcon" then LeaderboardEditor_Editors["RankIcon"] = {Value = "Voidware"}; Leaderboard_AddOnCreator_Helper["RankIcon"] = {Type = "CreateDropdown", Args = {Name = "RankIcon", List = fetchRankIconNames(), Function = fetchDefaultFunction}, ResType = "Value"};
        elseif typeName == "RankName" then LeaderboardEditor_Editors["RankName"] = {Value = "INFINITY"}; Leaderboard_AddOnCreator_Helper["RankName"] = {Type = "CreateTextBox", Args = {Name = "RankName", TempText = "rankname", Function = fetchDefaultFunction}, ResType = "Value"};
        elseif typeName == "CrownIconColor" then LeaderboardEditor_Editors["CrownIconColor"] = {Hue = 255, Sat = 0, Value = 0}; Leaderboard_AddOnCreator_Helper["CrownIconColor"] = {Type = "CreateColorSlider", Args = {Name = "CrownIconColor", Function = fetchDefaultFunction}, ResType = {"Hue", "Sat", "Value"}}
        else warn("Unknown registerType!", typeName) end
    end

    for i,v in pairs(AllowedEditMethods) do LeaderboardEditor_Types[i] = {Enabled = false}; registerType(i) end

    for i,v in pairs(LeaderboardEditor_Editors) do v = LeaderboardEditor[Leaderboard_AddOnCreator_Helper[i].Type](Leaderboard_AddOnCreator_Helper[i].Args) end
    for i,v in pairs(LeaderboardEditor_Types) do if i ~= "Place" then v = LeaderboardEditor.CreateToggle({Name = i, Function = function(call) fetchObjectData(i).Object.Visible = call end}) end end

    checkAddOns()
end)--]]

--[[run(function()
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 500)
    mainFrame.Position = UDim2.new(1, 0, 0.8, -250)
    mainFrame.AnchorPoint = Vector2.new(0, 0.5) 
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = shared.GuiLibrary.MainGui.ScaledGui
    shared.GuiLibrary.SelfDestructEvent.Event:Connect(function()
        mainFrame:Destroy()
    end)
    
    local groupId = 5774246
    local roleIds = {
        79029254,
        86172137,
        43926962,
        37929139,
        87049509,
        37929138
    }
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.BackgroundTransparency = 1 
    scrollingFrame.Parent = mainFrame
    
    local function createUICorner(instance, radius)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.Parent = instance
    end
    
    local tweenService = game:GetService("TweenService")
    local function fadeOut(frame)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(frame, tweenInfo, {Transparency = 1, Position = frame.Position + UDim2.new(0, 100, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function() frame:Destroy() end)
    end
    
    local function fadeIn(frame)
        frame.Transparency = 1
        frame.Position = frame.Position - UDim2.new(0, 100, 0, 0)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local tween = tweenService:Create(frame, tweenInfo, {Position = frame.Position + UDim2.new(0, 100, 0, 0)})
        tween:Play()
    end
    
    local function updateUsers(users)
        for _, child in pairs(scrollingFrame:GetChildren()) do
            if child:IsA("Frame") then
                fadeOut(child)
            end
        end
    
        for index, user in ipairs(users) do
            local userFrame = Instance.new("Frame")
            userFrame.Size = UDim2.new(1, -10, 0, 50)
            userFrame.Position = UDim2.new(0, 5, 0, (index - 1) * 55) 
            userFrame.BackgroundTransparency = 1
            userFrame.Parent = scrollingFrame
    
            local avatar = Instance.new("ImageLabel")
            avatar.Size = UDim2.new(0, 40, 0, 40)
            avatar.Position = UDim2.new(0, 5, 0, 5)
            avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..user.userId.."&w=420&h=420"
            avatar.Parent = userFrame
            avatar.BackgroundTransparency = 1
    
            createUICorner(avatar, 40)
    
            local statusIndicator = Instance.new("Frame")
            statusIndicator.Size = UDim2.new(0, 10, 0, 10)
            statusIndicator.Position = UDim2.new(1, -10, 1, -10)
            statusIndicator.BackgroundColor3 = user.StatusColor
            statusIndicator.BorderSizePixel = 2
            statusIndicator.BorderColor3 = Color3.fromRGB(255, 255, 255)
            statusIndicator.Parent = avatar
    
            createUICorner(statusIndicator, 10)
    
            local userInfo = Instance.new("TextLabel")
            userInfo.Size = UDim2.new(1, -60, 1, 0)
            userInfo.Position = UDim2.new(0, 55, 0, 0)
            userInfo.Text = tostring(user.displayName) .. "(@".. tostring(user.username) ..")\nStatus: "..tostring(user.StatusType).."    ID: " .. tostring(user.userId)
            userInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
            userInfo.TextXAlignment = Enum.TextXAlignment.Left
            userInfo.TextYAlignment = Enum.TextYAlignment.Center
            userInfo.Font = Enum.Font.ArialBold
            userInfo.TextSize = 14
            userInfo.Parent = userFrame
            userInfo.BackgroundTransparency = 1
    
            fadeIn(userFrame)
        end
    end
    
    local function getUsersInRole(groupId, roleId, cursor)
        local limit = 100
        local url = "https://groups.roblox.com/v1/groups/"..groupId.."/roles/"..roleId.."/users?limit="..limit
        if cursor then
            url = url .. "&cursor=" .. cursor
        end
    
        local response = request({
            Url = url,
            Method = "GET"
        })
    
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    
    local function getUserPresence(userIds)
        local url = "https://presence.roblox.com/v1/presence/users"
        local requestBody = game:GetService("HttpService"):JSONEncode({userIds = userIds})
    
        local response = request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = requestBody
        })
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    
    local function getUsersForRolesWithPresence(groupId, roleIds)
        local users = {}
        local userIds = {}
        for _, roleId in pairs(roleIds) do
            local cursor = nil
            repeat
                local data = getUsersInRole(groupId, roleId, cursor)
                for _, user in pairs(data.data) do
                    table.insert(users, user)
                    table.insert(userIds, user.userId)
                end
                cursor = data.nextPageCursor
            until not cursor
        end
    
        local presenceData = getUserPresence(userIds)
        for _, user in pairs(users) do
            for _, presence in pairs(presenceData.userPresences) do
                if user.userId == presence.userId then
                    user.presenceType = presence.userPresenceType
                    user.lastLocation = presence.lastLocation
                    break
                end
            end
        end
        return users
    end
    
    local function filterUsersByPresence(users, presenceType)
        local filteredUsers = {}
        for _, user in pairs(users) do
            if user.presenceType == presenceType then
                table.insert(filteredUsers, user)
            end
        end
        updateUsers(filteredUsers)
    end
    
    local function getUsersForRolesPresence(groupId, roleIds)
        local users = getUsersForRolesWithPresence(groupId, roleIds)
    
        local StatusTypes = {
            ["0"] = "Offline",
            ["1"] = "Online",
            ["2"] = "InGame"
        }
        
        for _, user in pairs(users) do
            local statusColor = Color3.fromRGB(0, 255, 0)
            if user.presenceType == 0 then
                statusColor = Color3.fromRGB(255, 0, 0)
            elseif user.presenceType == 2 then
                statusColor = Color3.fromRGB(0, 0, 255)
            end
            user.StatusColor = statusColor
            user.StatusType = StatusTypes[tostring(user.presenceType)]
        end
        updateUsers(users)
    end
    
    local refreshButton = Instance.new("TextButton")
    refreshButton.Size = UDim2.new(0, 80, 0, 30)
    refreshButton.Position = UDim2.new(0.5, -40, 0, -40)
    refreshButton.Text = "Refresh"
    refreshButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    refreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    refreshButton.Parent = mainFrame
    refreshButton.TextScaled = true
    refreshButton.BackgroundTransparency = 1
    refreshButton.MouseButton1Click:Connect(function()
        getUsersForRolesPresence(groupId, roleIds)
    end)
    getUsersForRolesPresence(groupId, roleIds)    
end)--]]
