
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Door Charge"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true



if (SERVER) then
	function ENT:GetLockPosition(door, normal)
		local index = door:LookupBone("handle")
		local position = door:GetPos()
		normal = normal or door:GetForward():Angle()

		if (index and index >= 1) then
			position = door:GetBonePosition(index)
		end

		position = position + normal:Forward() * 7.2 + normal:Up() * 10 + normal:Right() * 2

		normal:RotateAroundAxis(normal:Up(), 90)
		normal:RotateAroundAxis(normal:Forward(), 180)
		normal:RotateAroundAxis(normal:Right(), 180)

		return position, normal
	end

	function ENT:SetDoor(door, position, angles)
		if (!IsValid(door) or !door:IsDoor()) then
			return
		end

		local doorPartner = door:GetDoorPartner()

		self.door = door
		self.door:DeleteOnRemove(self)
		door.ixLock = self

		if (IsValid(doorPartner)) then
			self.doorPartner = doorPartner
			self.doorPartner:DeleteOnRemove(self)
			doorPartner.ixLock = self
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
		self.creator = client
		local entity = ents.Create("hl2_doorcharge")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		entity:Activate()
		entity:SetDoor(door, position, angles)

		return entity
	end

	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_lock01.mdl")
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
			timer.Create("doorcharge"..id, 5,1, function()
				util.BlastDamage(self.creator,self,self:GetPos(), 100, 100)
				self:Remove()
			end)
		end
	end

	function ENT:Use(client)
		self:Toggle(client)
	end
else
	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	local color_red = Color(255, 50, 50, 255)

	function ENT:Draw()
		self:DrawModel()

		local color = color_red
		local position = self:GetPos() + self:GetUp() * -8.7 + self:GetForward() * -3.85 + self:GetRight() * -6

		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 10, 10, color)
	end
end
