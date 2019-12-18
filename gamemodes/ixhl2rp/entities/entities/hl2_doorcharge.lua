
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Door Charge"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Armed")
end

if (SERVER) then
	function ENT:GetLockPosition(door, normal)
		local index = door:LookupBone("handle")
		local position = door:GetPos()
		normal = normal or door:GetForward():Angle()

		if (index and index >= 1) then
			position = door:GetBonePosition(index)
		end

		position = position + normal:Forward() * 3.2 + normal:Up() * 10 + normal:Right() * 2

		normal:RotateAroundAxis(normal:Up(), 180)
		normal:RotateAroundAxis(normal:Forward(), 90)
		normal:RotateAroundAxis(normal:Right(), 90)

		return position, normal
	end

	function ENT:SetDoor(door, position, angles)
		if (!IsValid(door) or !door:IsDoor()) then
			return
		end

		local doorPartner = door:GetDoorPartner()

		self.door = door
		self.door:DeleteOnRemove(self)


		if (IsValid(doorPartner)) then
			self.doorPartner = doorPartner
			self.doorPartner:DeleteOnRemove(self)
			
		end

		self:SetPos(position)
		self:SetAngles(angles)
		self:SetParent(door)
	end

	function ENT:SpawnFunction(client, trace)
		local door = trace.Entity

		if (!IsValid(door) or !door:IsDoor()) then
			return client:NotifyLocalized("dNotValid")
		end

		local normal = client:GetEyeTrace().HitNormal:Angle()
		local position, angles = self:GetLockPosition(door, normal)
		local entity = ents.Create("hl2_doorcharge")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		entity:Activate()
		entity:SetDoor(door, position, angles)

		return entity
	end

	function ENT:Initialize()
		self:SetModel("models/warz/items/c4.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)

		self.nextUseTime = 0
	end

	function ENT:OnRemove()
		if (IsValid(self)) then
			self:SetParent(nil)
		end
	end

	function ENT:Toggle(client)
		local id = self:GetCreationID()
		if not timer.Exists("doorcharge"..id) then
			self.toggle = true
			local ent = self
			timer.Create("doorcharge"..id, 5,1, function()
				local explode = ents.Create( "env_explosion" ) 
				local explo = ents.Create( "env_explosion" )
				explo:SetPos( ent:GetPos() )
				explo:Spawn()
				explo:Fire( "Explode" )
				explo:SetKeyValue( "IMagnitude", 20 )			
				ent.door:Fire("Unlock")
				ent:Remove()
			end)
			self.nextbeep = CurTime()+1
			self:SetArmed(true)
			self:EmitSound("hl1/fvox/beep.wav")
			
		end
	end

	function ENT:Use(client)
		self:Toggle(client)
	end
else
 

	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	local color_red = Color(255, 50, 50, 255)
	local color_green = Color(68, 189, 50)
	function ENT:Draw()
		self:DrawModel()

		if self:GetArmed() then 
			color = color_red
		else
			color = color_green
		end
		local position = self:GetPos() + self:GetUp() * 2

		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 10, 10, color)
	end
	function ENT:Think()
		if self:GetArmed() then
			if not self.nextbeep then 
				self.beeptime = 1
				self.nextbeep = CurTime() + self.beeptime
				--self.beeps = 0
			end
			if self.nextbeep<CurTime() then --and self.beeps<=2
				print("beepnext"..self.beeptime)
				self:EmitSound("hl1/fvox/beep.wav")
				self.nextbeep = CurTime()+ self.beeptime
				--self.beeps = self.beeps +1
				if self.beeptime<0.3 then return end 
				self.beeptime = self.beeptime*.6
			end
		end
	end

end


