if SERVER then
    AddCSLuaFile()

    resource.AddFile("materials/vgui/ttt/vskin/events/inf_demote_traitor.vmt")
end

if CLIENT then
    EVENT.title = "title_event_inf_demote_traitor"
    EVENT.icon = Material("vgui/ttt/vskin/events/inf_demote_traitor.vmt")

    function EVENT:GetText()
        return {
            {
                string = "desc_event_inf_demote_traitor",
                params = {
                    name = self.event.traitor_name,
                    oldRole = roles.GetByIndex(self.event.traitor_role).name
                },
                translateParams = true
            }
        }
    end
end

if SERVER then
    function EVENT:Trigger(traitor)
        self:AddAffectedPlayers(
            { traitor:SteamID64() },
            { traitor:GetName() }
        )

        return self:Add({
            serialname = self.event.title,
            traitor_name = traitor:GetName(),
            traitor_role = traitor:GetSubRole()
        })
    end

    function EVENT:Serialize()
        return self.event.serialname
    end
end
