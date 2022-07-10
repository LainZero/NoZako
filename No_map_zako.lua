local modName = "No Zako on Map"
local folderName = modName
local version = "Version: 1.0.4"

local modUtils = require(folderName .. "/modUtils")

local settings = modUtils.getConfigHandler({
    enabledNoZako = true,
}, folderName)

log.info(modName .. " loaded!")

sdk.hook(sdk.find_type_definition("snow.enemy.EnemyManager"):get_method("setupEnemyZakoSetData"), function(args)
  if settings.data.enabledNoZako then
    return sdk.PreHookResult.SKIP_ORIGINAL
  else
    return sdk.PreHookResult.CALL_ORIGINAL
  end
end, function(retval) end)


-- No Zako Configuration on REFramework UI
re.on_draw_ui(function()
    if imgui.tree_node(modName) then
        local changedEnabled, userenabled =
            imgui.checkbox("Remove Zako Enemy on Map", settings.data.enabledNoZako)
        settings.handleChange(changedEnabled, userenabled, "enabledNoZako")

        if not settings.isSavingAvailable then
            imgui.text(
                "WARNING: JSON utils not available (your REFramework version may be outdated). Configuration will not be saved between restarts.")
        end

        imgui.text(version)
        imgui.tree_pop()
    end
end)