--[[
	Copyright (c) 2011 the original author or authors

	Permission is hereby granted to use, modify, and distribute this file
	in accordance with the terms of the license agreement accompanying it.
--]]

--[[

	Mocking (faking or emulating) the gameNetwork function using my mock class.
	The example below shows how to mock OpenFeint calls for achievements. I wrote an
	example Achievements wrapper class that'd eventually wrap Papaya Mobile calls as well.
	That way, you can put Achievements everywhere in your code, and never have to worry if you're
	running in the Emulator, or the device; the code never changes. It detects internally if you're
	running on a device, and uses the real gameNetwork apis if you are.
	
	Jesse Warden
	email: jessew@webappsolution.com
	twitter: @jesterxl
	blog: http://jessewarden.com

]]--

require "com.jessewarden.mockachievementsexample.Achievements"

achievements = {
	liftOff 		= {pid = 14, oid = 123123, image = "achievement_Lift_Off.png", name="Lift Off"},
	firstBlood 		= {pid = 15, oid = 123124, image = "achievement_First_Blood.png", name="First Blood"},
}

function example1()
	-- to unlock an achievement, whether on a device or in the emulator, use:
	Achievements:init()
	-- wait a few seconds for it to connect
	local wait = {}
	function wait:timer()
		-- and unlock any achievement you want. Notice, this line of code does not change,
		-- whether you're in the Emulator, or on an actual device.
		Achievements:unlock(achievements.firstBlood)
		--Achievements:unlock(achievements.liftOff)
	end
	timer.performWithDelay(4000, wait)
end

-- if you want to just play around
function example2()
	require "com.jessewarden.mock.openfeint.MockOpenFeint"
	local mock = MockOpenFeint:new()
	--mock:showInit("Welcome Back Cotter")
	--mock:showAchievement(achievements.liftOff.image, achievements.liftOff.name)
	mock:showAchievement(achievements.firstBlood.image, achievements.firstBlood.name)
end

example1()
--example2()

