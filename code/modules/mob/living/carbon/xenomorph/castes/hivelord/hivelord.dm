/mob/living/carbon/xenomorph/hivelord
	caste_base_type = /mob/living/carbon/xenomorph/hivelord
	name = "Hivelord"
	desc = "A huge ass xeno covered in weeds! Oh shit!"
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	icon_state = "Hivelord Walking"
	health = 325
	maxHealth = 325
	plasma_stored = 200
	pixel_x = -16
	old_x = -16
	speed = 0.4
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead xeno is hard
	var/speed_activated = 0
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_ZERO
	var/list/tunnels = list() //list of active tunnels

// ***************************************
// *********** Init
// ***************************************
/mob/living/carbon/xenomorph/hivelord/Initialize()
	. = ..()
	update_spits()

// ***************************************
// *********** Mob override
// ***************************************
/mob/living/carbon/xenomorph/hivelord/movement_delay()
	. = ..()

	if(speed_activated)
		if(locate(/obj/effect/alien/weeds) in loc)
			. -= 1.5

// ***************************************
// *********** Life overrides
// ***************************************
/mob/living/carbon/xenomorph/hivelord/handle_living_plasma_updates()
	if(speed_activated)
		plasma_stored -= 30
		if(plasma_stored < 0)
			speed_activated = FALSE
			to_chat(src, "<span class='warning'>You feel dizzy as the world slows down.</span>")
	..()

/mob/living/carbon/xenomorph/hivelord/Stat()
	. = ..()

	if(statpanel("Stats"))
		stat(null, "Active Tunnel Sets: [tunnels.len * 0.5] / [HIVELORD_TUNNEL_SET_LIMIT]")
