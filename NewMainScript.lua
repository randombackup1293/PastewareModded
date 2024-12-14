repeat task.wait() until game:IsLoaded()
shared.oldgetcustomasset = shared.oldgetcustomasset or getcustomasset
task.spawn(function()
    repeat task.wait() until shared.VapeFullyLoaded
    getgenv().getcustomasset = shared.oldgetcustomasset -- vape bad code moment
end)
local CheatEngineMode = false
if (not getgenv) or (getgenv and type(getgenv) ~= "function") then CheatEngineMode = true end
if getgenv and not getgenv().shared then CheatEngineMode = true; getgenv().shared = {}; end
if getgenv and not getgenv().debug then CheatEngineMode = true; getgenv().debug = {traceback = function(string) return string end} end
if getgenv and not getgenv().require then CheatEngineMode = true; end
if getgenv and getgenv().require and type(getgenv().require) ~= "function" then CheatEngineMode = true end
local debugChecks = {
    Type = "table",
    Functions = {
        "getupvalue",
        "getupvalues",
        "getconstants",
        "getproto"
    }
}
if identifyexecutor and type(identifyexecutor) == "function" and tostring(identifyexecutor()):lower() == "appleware" then CheatEngineMode = true end
local function checkDebug()
    if not getgenv().debug then 
        CheatEngineMode = true 
    else 
        if type(debug) ~= debugChecks.Type then 
            CheatEngineMode = true
        else 
            for i, v in pairs(debugChecks.Functions) do
                if not debug[v] or (debug[v] and type(debug[v]) ~= "function") then 
                    CheatEngineMode = true 
                else
                    local suc, res = pcall(debug[v]) 
                    if tostring(res) == "Not Implemented" then 
                        CheatEngineMode = true 
                    end
                end
            end
        end
    end
end
if (not CheatEngineMode) then checkDebug() end
local baseDirectory = shared.RiseMode and "rise/" or "vape/"
if (not isfolder('vape')) then makefolder('vape') end
if (not isfolder('rise')) then makefolder('rise') end
shared.CheatEngineMode = shared.CheatEngineMode or CheatEngineMode
local errorPopupShown = false
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 8 end
local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local delfile = delfile or function(file) writefile(file, "") end
if not isfolder(baseDirectory) then makefolder(baseDirectory) end
local VWFunctions = {}

shared.VWFunctions = VWFunctions
getgenv().VWFunctions = VWFunctions
local blacklistedexecutors = {"solara", "celery", "appleware"}
if identifyexecutor then
    local executor = identifyexecutor()
    for i,v in pairs(blacklistedexecutors) do
        if string.find(string.lower(executor), blacklistedexecutors[i]) then 
            shared.BlacklistedExecutor = {Value = true, Executor = tostring(executor)}
        end
    end
end
local function install_profiles(num)
    if not num then return warn("No number specified!") end
    local httpservice = game:GetService('HttpService')
    local guiprofiles = {}
    local profilesfetched
    local repoOwner = shared.RiseMode and "VapeVoidware/RiseProfiles" or "randombackup1293/VoidwareProfiles"
    local function vapeGithubRequest(scripturl)
        if not isfile(baseDirectory..scripturl) then
            local suc, res = pcall(function() return game:HttpGet('https://raw.githubusercontent.com/'..repoOwner..'/main/'..scripturl, true) end)
            if not isfolder(baseDirectory.."Profiles") then
                makefolder(baseDirectory..'Profiles')
            end
            if not isfolder(baseDirectory..'ClosetProfiles') then makefolder(baseDirectory..'ClosetProfiles') end
            writefile(baseDirectory..scripturl, res)
            task.wait()
        end
        return print(scripturl)
    end
    local Gui1 = {
        MainGui = ""
    }
    local gui = Instance.new("ScreenGui")
        gui.Name = "idk"
        gui.DisplayOrder = 999
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gui.OnTopOfCoreBlur = true
        gui.ResetOnSpawn = false
        gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        Gui1["MainGui"] = gui
    
    local function downloadVapeProfile(path)
        print(path)
        task.spawn(function()
            local textlabel = Instance.new('TextLabel')
            textlabel.Size = UDim2.new(1, 0, 0, 36)
            textlabel.Text = 'Downloading '..path
            textlabel.BackgroundTransparency = 1
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 30
            textlabel.Font = Enum.Font.SourceSans
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.Position = UDim2.new(0, 0, 0, -36)
            textlabel.Parent = Gui1.MainGui
            task.wait(0.1)
            textlabel:Destroy()
            vapeGithubRequest(path)
        end)
        return
    end
    task.spawn(function()
        local res1
        if num == 1 then
            res1 = "https://api.github.com/repos/"..repoOwner.."/contents/Profiles"
        elseif num == 2 then
            res1 = "https://api.github.com/repos/randombackup1293/VoidwareProfiles/contents/ClosetProfiles"
        end
        res = game:HttpGet(res1, true)
        if res ~= '404: Not Found' then 
            for i,v in next, game:GetService("HttpService"):JSONDecode(res) do 
                if type(v) == 'table' and v.name then 
                    table.insert(guiprofiles, v.name) 
                end
            end
        end
        profilesfetched = true
    end)
    repeat task.wait() until profilesfetched
    for i, v in pairs(guiprofiles) do
        local name
        if num == 1 then name = "Profiles/" elseif num == 2 then name = "ClosetProfiles/" end
        downloadVapeProfile(name..guiprofiles[i])
        task.wait()
    end
    if (not isfolder(baseDirectory..'Libraries')) then makefolder(baseDirectory..'Libraries') end
    if num == 1 then writefile(baseDirectory..'Libraries/profilesinstalled3.txt', "true") elseif num == 2 then writefile(baseDirectory..'ClosetProfiles/profilesinstalled3.txt', "true") end 
end
local function are_installed_1()
    if not isfolder(baseDirectory..'Profiles') then makefolder(baseDirectory..'Profiles') end
    if isfile(baseDirectory..'Libraries/profilesinstalled3.txt') then return true else return false end
end
local function are_installed_2() 
    if not isfolder(baseDirectory..'ClosetProfiles') then makefolder(baseDirectory..'ClosetProfiles') end
    if isfile(baseDirectory..'ClosetProfiles/profilesinstalled3.txt') then return true else return false end
end
if not are_installed_1() then install_profiles(1) end
if not are_installed_2() then install_profiles(2) end
local url = "https://github.com/randombackup1293/PastewareModded"
if not shared.VapeDeveloper then 
	local commit = "main"
	for i,v in pairs(game:HttpGet(url):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			commit = str:sub(0, str:find('"') - 1)
			break
		end
	end
	if commit then
		if isfolder(baseDirectory) then 
		    writefile(baseDirectory.."commithash2.txt", commit)
			if ((not isfile(baseDirectory.."commithash.txt")) or (readfile(baseDirectory.."commithash.txt") ~= commit or commit == "main")) then
				for i,v in pairs({baseDirectory.."Universal.lua", baseDirectory.."MainScript.lua", baseDirectory.."GuiLibrary.lua"}) do 
					if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                        if not shared.VoidDev then
						    delfile(v)
                        end
					end 
				end
				if isfolder(baseDirectory.."CustomModules") then 
					for i,v in pairs(listfiles(baseDirectory.."CustomModules")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                            if not shared.VoidDev then
							    delfile(v)
                            end
						end 
					end
				end
				if isfolder(baseDirectory.."Libraries") then 
					for i,v in pairs(listfiles(baseDirectory.."Libraries")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                            if not shared.VoidDev then
							    delfile(v)
                            end
						end 
					end
				end
				writefile(baseDirectory.."commithash2.txt", commit)
			end
		else
			makefolder("vape")
			writefile(baseDirectory.."commithash2.txt", commit)
		end
	else
		error("Failed to connect to github, please try using a VPN.")
	end
end
if not shared.VapeDeveloper then 
	local commit = "main"
	for i,v in pairs(game:HttpGet("https://github.com/randombackup1293/PastewareModded"):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			commit = str:sub(0, str:find('"') - 1)
			break
		end
	end
	if commit then
		if isfolder("vape") then 
			if ((not isfile(baseDirectory.."commithash.txt")) or (readfile(baseDirectory.."commithash.txt") ~= commit or commit == "main")) then
				writefile(baseDirectory.."commithash.txt", commit)
			end
		else
			makefolder("vape")
			writefile(baseDirectory.."commithash.txt", commit)
		end
	else
		error("Failed to connect to github, please try using a VPN.")
	end
end
local function vapeGithubRequest(scripturl, isImportant)
    if isfile(baseDirectory..scripturl) then
        if not shared.VoidDev then
            pcall(function() delfile(baseDirectory..scripturl) end)
        else
            return readfile(baseDirectory..scripturl) 
        end
    end
    local suc, res
    local url = (scripturl == "MainScript.lua" or scripturl == "GuiLibrary.lua") and "https://raw.githubusercontent.com/randombackup1293/PastewareModded/"
    print(url..readfile(baseDirectory.."commithash2.txt").."/"..scripturl)
    suc, res = pcall(function() return game:HttpGet(url..readfile(baseDirectory.."commithash2.txt").."/"..scripturl, true) end)
    if not suc or res == "404: Not Found" then
        if isImportant then
            game:GetService("Players").LocalPlayer:Kick("Failed to connect to github : "..baseDirectory..scripturl.." : "..res)
        end
        warn(baseDirectory..scripturl, res)
    end
    if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
    return res
end
local function pload(fileName, isImportant, required)
    fileName = tostring(fileName)
    if string.find(fileName, "CustomModules") and string.find(fileName, "Voidware") then
        fileName = string.gsub(fileName, "Voidware", "VW")
    end        
    if shared.VoidDev and shared.DebugMode then warn(fileName, isImportant, required, debug.traceback(fileName)) end
    local res = vapeGithubRequest(fileName, isImportant)
    local a = loadstring(res)
    local suc, err = true, ""
    if type(a) ~= "function" then suc = false; err = tostring(a) else if required then return a() else a() end end
    if (not suc) then 
        if isImportant then
            if (not string.find(string.lower(err), "vape already injected")) and (not string.find(string.lower(err), "rise already injected")) then
                task.spawn(function()
                    repeat task.wait() until errorNotification
                    errorNotification("Failure loading critical file! : "..baseDirectory..tostring(fileName), " : "..tostring(debug.traceback(err)), 10) 
                end)
            end
            --warn("Failure loading critical file! : vape/"..tostring(fileName).." : "..tostring(debug.traceback(err)))
            --if (not string.find(string.lower(err), "vape already injected")) then game:GetService("Players").LocalPlayer:Kick("Failure loading critical file! : vape/"..tostring(fileName).." : "..tostring(debug.traceback(err))) end
        else
            task.spawn(function()
                repeat task.wait() until errorNotification
                if not string.find(res, "404: Not Found") then 
                    errorNotification('Failure loading: '..baseDirectory..tostring(fileName), tostring(debug.traceback(err)), 7)
                end
            end)
        end
    end
end
shared.pload = pload
getgenv().pload = pload
return pload("MainScript.lua", true)
