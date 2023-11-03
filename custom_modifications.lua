local cfg = oUF_Banaak_config
oUF_Banaak_hooks = {}

oUF_Banaak_hooks.PlayerHealth = {
	sharedStyle = function(self, unit)
		if unit == "player" then self:Tag(self.power, "[hpDetailed] || [ppDetailed]") end
	end,
}

oUF_Banaak_hooks.PlayerName = {
    sharedStyle = function(self, unit)
        if unit == "player" then self:Tag(self.name, "[name]") end
    end,
}

--[[

	Your custom modifications go here. Every function of the main addon can be hooked into.

	Examples:
	____________________________________________

		Absolute health number for player frame
		----------------------------------------------------------------------
		oUF_Banaak_hooks.PlayerHealth = {
			sharedStyle = function(self, unit)
				if unit == "player" then self:Tag(self.power, "[hpDetailed] || [ppDetailed]") end
			end,
		}
		----------------------------------------------------------------------


		Health-colored percentage
		----------------------------------------------------------------------
		oUF_Banaak_hooks.HealthColored = {
			UpdateHealth = function(self)
				if self.unit == "player" and UnitHasVehicleUI("player") then
					h, hMax = UnitHealth("pet"), UnitHealthMax("pet")
				else
					h, hMax = UnitHealth(self.unit), UnitHealthMax(self.unit)
				end

				if UnitIsConnected(self.unit) and not UnitIsGhost(self.unit) and not UnitIsDead(self.unit) then
					for i = 1, 4 do
						self.healthFill[5 - i]:SetVertexColor(1 - h / hMax, h / hMax, 0)
					end
				end
			end,
		}
		----------------------------------------------------------------------


		Suppress OmniCC
		----------------------------------------------------------------------
		oUF_Banaak_hooks.NoOmniCC = {
			PostCreateIcon = function(icons, icon)
				icon.cd.noCooldownCount = true
			end,
		}
		----------------------------------------------------------------------
}

]]

oUF_Banaak_hooks.HealthColored = {
	UpdateHealth = function(self)
		local h, hMax
		if self.unit == "player" and UnitHasVehicleUI("player") then
			h, hMax = UnitHealth("pet"), UnitHealthMax("pet")
		else
			h, hMax = UnitHealth(self.unit), UnitHealthMax(self.unit)
		end

		if UnitIsConnected(self.unit) and not UnitIsGhost(self.unit) and not UnitIsDead(self.unit) then
			for i = 1, 4 do
				if self.healthFill and self.healthFill[5 - i] then
					self.healthFill[5 - i]:SetVertexColor(1 - h / hMax, h / hMax, 0)
				end
			end
		end
	end,
}

oUF_Banaak_hooks.ClassHealth = {
	UpdateHealth = function(self)
		local h, hMax
		if UnitIsConnected(self.unit) and not UnitIsGhost(self.unit) and not UnitIsDead(self.unit) then
			for i = self.unit:find("boss") and 4 or 1, 4 do
				if self.healthFill and self.healthFill[5 - i] then
					self.healthFill[5 - i]:SetVertexColor(RAID_CLASS_COLORS[select(2, UnitClass(self.unit))].r, RAID_CLASS_COLORS[select(2, UnitClass(self.unit))].g, RAID_CLASS_COLORS[select(2, UnitClass(self.unit))].b)
				end
			end
		end
	end,
}