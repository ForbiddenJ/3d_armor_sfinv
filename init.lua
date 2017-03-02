-- 3D Armor Compatibility Layer for sfinv

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local OverrideCraftPage = true -- Making a separate page is buggy in 0.4.15, so the main page is overriden.

if not OverrideCraftPage then
	sfinv.register_page("3d_armor_sfinv:armorpage", {
		title = "Armor",
		get = function(self, player, context)
			local name = armor:get_valid_player(player, "[set_player_armor]")
			local fy = 0.6
			return sfinv.make_formspec(player, context,
				"label[0,0;Armor]"
				.."list[detached:"..name.."_armor;armor;0,"..fy..";2,3;]"
				.."image[2.5,"..(fy - 0.25)..";2,4;"..armor.textures[name].preview.."]"
				.."label[5.0,"..(fy + 0.0)..";Level: "..armor.def[name].level.."]"
				.."label[5.0,"..(fy + 0.5)..";Heal:  "..armor.def[name].heal.."]"
				.."label[5.0,"..(fy + 1.0)..";Fire:  "..armor.def[name].fire.."]"
				.."label[5.0,"..(fy + 1.5)..";Radiation:  "..armor.def[name].radiation.."]"
				.."listring[current_player;main]"
				.."listring[detached:"..name.."_armor;armor]"
				, true
			)
		end,
	})
else
	sfinv.override_page("sfinv:crafting", {
		title = "Main",
		get = function(self, player, context)
			local name = armor:get_valid_player(player, "[set_player_armor]")
			return sfinv.make_formspec(player, context,
				"listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]" .. armor:get_armor_formspec(name)
				, false
			)
		end,
	})
end

armor.update_inventory = function(self, player)
	sfinv.set_player_inventory_formspec(player)
end
