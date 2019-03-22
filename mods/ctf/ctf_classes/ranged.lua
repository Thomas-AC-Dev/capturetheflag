local shooter_specs = {}


shooter.get_weapon_spec = function(_, user, name)
	local spec = shooter.registered_weapons[name]
	if not spec then
		return nil
	end
	spec = spec.spec
	spec.name = user:get_player_name()

	if not user then
		return spec
	end

	local class = ctf_classes.get(user)
	if class.name ~= "shooter" then
		if name == "shooter:rifle" then
			minetest.chat_send_player(user:get_player_name(),
				"Only Shooters are skilled enough for rifles! Change your class at spawn")
			return nil
		end
		return spec
	end

	if shooter_specs[name] then
		return shooter_specs[name]
	end

	spec = table.copy(spec)
	shooter_specs[name] = spec

	spec.range = spec.range * 1.5
	spec.tool_caps.full_punch_interval = spec.tool_caps.full_punch_interval * 0.8
	return spec
end
