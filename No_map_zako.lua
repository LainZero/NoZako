sdk.hook(sdk.find_type_definition("snow.QuestManager"):get_method("setupEnemyZakoSetData"), function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end, function(retval) end)
