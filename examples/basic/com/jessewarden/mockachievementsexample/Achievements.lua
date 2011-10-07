--[[
	Copyright (c) 2011 the original author or authors

	Permission is hereby granted to use, modify, and distribute this file
	in accordance with the terms of the license agreement accompanying it.
--]]

require "gameNetwork"
require "com.jessewarden.mock.openfeint.MockOpenFeint"

Achievements = {}
local platform = system.getInfo("platformName")
if platform == "Android" or platform == "iPhone OS" then
	Achievements.useMock = false
else
	Achievements.useMock = true
	Achievements.mock = MockOpenFeint:new()
	local stage = display.getCurrentStage()
	stage:insert(Achievements.mock)
end

function Achievements:init()
	if self.useMock == false then
		gameNetwork.init("openfeint", 
							"asdf", 
							"asdf", 
							"Your Game Name", 
							"111111")
	else
		self.mock:showInit("Welcome Back Player 2938JKHS8")
	end
end

function Achievements:unlock(achievementVO)
	if self.useMock == true then
		self.mock:showAchievement(achievementVO.image, achievementVO.name)
		return true
	end
	
	local idFieldName
	if self.mode == "openfeint" then
		idFieldName = "oid"
	elseif self.mode == "papayamobile" then
		idFieldName = "pid"
	end
	
	gameNetwork.request("unlockAchievement", achievementVO["oid"])
end

return Achievements