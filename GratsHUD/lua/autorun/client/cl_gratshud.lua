local Player = LocalPlayer()
local ply = LocalPlayer()

surface.CreateFont( "Hud_25", {
	font = "Roboto",
	size = 25,
	weight = 500,
})

surface.CreateFont( "Hud_20", {
	font = "Roboto",
	size = 20,
	weight = 500,
})

surface.CreateFont( "Bold", {
	font = "Roboto",
	size = 20,
	weight = 1000,
})

surface.CreateFont( "Bold1", {
	font = "Roboto",
	size = 30,
	weight = 1000,
})

surface.CreateFont( "Bold2", {
	font = "Roboto",
	size = 25,
	weight = 1000,
})


/*---------------------------------------------------------------------------
Drawing custom HUD.
---------------------------------------------------------------------------*/


local localplayer = LocalPlayer()

local HideElementsTable = {
    ["DarkRP_HUD"] = true,
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_ArrestedHUD"]      = true,
    ["DarkRP_EntityDisplay"] = false,
    ["DarkRP_ZombieInfo"] = true,
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_Agenda"] = true,
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudSuitPower"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
 --   ["CHudCrosshair"] = true,
}


local function Frame() 
		local scrw, scrh = ScrW(), ScrH()
		local boxW, boxH = scrw * 0.12, scrh * .005
		local coxW, coxH = scrw * .052, scrh * .095
		local ply = LocalPlayer()
		local hp = ply:Health()
		local ar = ply:Armor()
		local maxhp = ply:GetMaxHealth()

	draw.RoundedBox(0, scrw * .061, scrh * .92, boxW, boxH, Color(255, 255, 255))

end


local function Info()
	local ply = LocalPlayer()
	local hp = ply:Health()
	local ar = ply:Armor()
	local maxhp = ply:GetMaxHealth()

	draw.DrawText(ply:GetName(),"F4_LOUNGE_Large", ScrW() * 0.065, ScrH() * .885, Color( 255, 255, 255))

	draw.DrawText(ply:getDarkRPVar("job"),"F4_LOUNGE_Large", ScrW() * .065	, ScrH() * .901, Color( 255, 255, 255))

	draw.DrawText("$ "..ply:getDarkRPVar("money"),"F4_LOUNGE_Large", ScrW() * 0.125, ScrH() * .925, Color( 0, 255, 0))

	draw.DrawText(ply:Health().." %","F4_LOUNGE_Large", ScrW() * .065, ScrH() * .925, Color( 242, 7, 46))

	draw.DrawText(ply:Armor().." %","F4_LOUNGE_Large", ScrW() * .095, ScrH() * .925, Color(  5, 131, 246))
	
end

local function Ammo()
	local AmmoEmpty= "No Ammo"
	local NoWeapon = "No Weapon"
	local Player   = LocalPlayer()
	local weapon = LocalPlayer():GetActiveWeapon()
    if(!weapon.Clip1) then return end
    if(weapon:Clip1() < 0) then return end

	draw.RoundedBox(0,ScrW() - 176,ScrH() - 42, 168 ,30 + 4,Color(40,40,40,210))
    draw.RoundedBox(0,ScrW() - 112,ScrH() - 82, 100 + 4 ,30 + 4,Color(40,40,40,210))
	draw.RoundedBox(0,ScrW() - 112,ScrH() - 82, 100 + 4 ,.1 + 2,Color(255,255,255))
	draw.RoundedBox(0,ScrW() - 176,ScrH() - 42, 168 ,.1 + 2,Color(255,255,255))

    if (Player:GetActiveWeapon():IsValid()) then
    	local Clip1Ammo     = Player:GetActiveWeapon():Clip1()
    	local Clip2Ammo     = Player:GetAmmoCount(Player:GetActiveWeapon():GetPrimaryAmmoType())
        local WeaponName    = Player:GetActiveWeapon():GetPrintName()
	
    if Clip1Ammo == -1 then
        draw.SimpleText(Clip2Ammo,"F4_LOUNGE_Large", ScrW() - 62,ScrH() - 65, Color(255,255,255),1,1)                          // Primary Ammo Text f/ throwables
    else
        draw.SimpleText(Clip1Ammo.."/"..Clip2Ammo,"F4_LOUNGE_Large", ScrW() - 62,ScrH() - 65, Color(255,255,255),1,1)          // Primary Ammo Text
    end

	if Clip1Ammo <= 0 and Clip2Ammo <= 0 then
	 
	    draw.RoundedBox(0,ScrW() - 112,ScrH() - 82, 100 + 4 ,30 + 4,Color(40,40,40))  
		draw.SimpleText(AmmoEmpty,"F4_LOUNGE_Large", ScrW() - 62,ScrH() - 67, Color(255,255,255),1,1)
	
    end
	draw.SimpleText(WeaponName ,"F4_LOUNGE_Large", ScrW() - 93,ScrH() - 25, Color(255,255,255),1,1)
    else
        draw.SimpleText(NoWeapon ,"F4_LOUNGE_Large", ScrW() - 93,ScrH() - 25, Color(255,255,255),1,1)
        draw.SimpleText(AmmoEmpty,"F4_LOUNGE_Large", ScrW() - 62,ScrH() - 67, Color(255,255,255),1,1)
    end
end

/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
hook.Add("HUDPaint","PaintHUD", function()
	Frame()
	Info()
	Ammo()
end)

/*---------------------------------------------------------------------------
Remove some elements from the HUD in favour of the DarkRP HUD
---------------------------------------------------------------------------*/


local HideElements = {
  ["DarkRP_HUD"] = true,
  ["DarkRP_EntityDisplay"] = true,
  ["DarkRP_ZombieInfo"] = true,
  ["DarkRP_Agenda"] = true,
  ["DarkRP_LocalPlayerHUD"] = true,
  ["DarkRP_Hungermod"] = true
}

hook.Add("HUDShouldDraw", "HideElements", function(name)
	if HideElements[name] or 
		name == "CHudHealth" or
		name == "CHudBattery" or
		name == "CHudAmmo" or 
		name ==	"CHudSecondaryAmmo" 
	then 
		return false 
	end
end)	
