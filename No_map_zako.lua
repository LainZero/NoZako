local modName = "No Zako on Map"
local folderName = modName

local modUtils = require(folderName .. "/modUtils")

local settings = modUtils.getConfigHandler({
    enabledNoZako = true,
}, folderName)

log.info(modName .. " loaded!")

if settings.data.enabledNoZako then
	sdk.hook(sdk.find_type_definition("snow.QuestManager"):get_method("setupEnemyZakoSetData"), function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end, function(retval) end)
end

-- No Zako Configuration on REFramework UI
re.on_draw_ui(function()
    if imgui.tree_node(modName) then
        local changedEnabled, userenabled =
            imgui.checkbox("No Zako on Map", settings.data.enabledNoZako)
        settings.handleChange(changedEnabled, userenabled, "enabledNoZako")

        if not settings.isSavingAvailable then
            imgui.text(
                "WARNING: JSON utils not available (your REFramework version may be outdated). Configuration will not be saved between restarts.")
        end

        imgui.text(version)
        imgui.tree_pop()
    end
end)