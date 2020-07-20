local function init()
	if not DarkRP then
		MsgC(Color(255,0,0), "DarkRP Classic Advert tried to run, but DarkRP wasn't declared!\n")
		return
	end

	DarkRP.removeChatCommand("advert")
	DarkRP.declareChatCommand({
		command = "advert",
		description = "Displays an advertisement to everyone in chat.",
		delay = 1.5
	})
	
	if SERVER then
		DarkRP.defineChatCommand("advert",function(ply,args)
			if args == "" then
				DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
				return ""
			end
			local DoSay = function(text)
				if text == "" then
					DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
					return
				end
				for k,v in pairs(player.GetAll()) do
					local col = team.GetColor(ply:Team())
					DarkRP.talkToPerson(v, col, "[Advert] " .. ply:Nick(), Color(255, 255, 0, 255), text, ply)
				end
			end
			hook.Call("playerAdverted", nil, ply, args)
			return args, DoSay
		end, 1.5)
	else
		DarkRP.addChatReceiver("/advert", "advertise", function(ply) return true end)
	end
end

if SERVER then
	if #player.GetAll() > 0 then
		init()
	else
		hook.Add("PlayerInitialSpawn", "dfca-load", init)
	end
else
	hook.Add("InitPostEntity", "dfca-load", init)
end
