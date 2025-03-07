/client/New()
	. = ..()
	spawn if(src)
		src.country = ip2country(address)
		if(country == "BR")
			message_admins("<span class='adminnotice'>[key_name_admin(src)] is a Brazilian!</span>")

/proc/ip2country(ipaddr)
	var/list/http_response[] = world.Export("http://ip-api.com/json/[ipaddr]")
	var/page_content = http_response["CONTENT"]
	if(page_content)
		var/list/geodata = json_decode(html_decode(file2text(page_content)))
		return geodata["countryCode"]

GLOBAL_LIST_INIT(countries,icon_states('icons/flags.dmi'))  //BLYAAAAAAAAAAAAAAT

/proc/country2chaticon(country_code)
	if(GLOB.countries.Find(country_code))
		return "[icon2html('icons/flags.dmi', world, country_code)]"
	else
		return "[icon2html('icons/flags.dmi', world, "unknown")]"

///client/New()
//	. = ..()
//	spawn if(src)
//		if(src.account_age < CONFIG_GET(number/accountage))
//			log_access("Account too new: [src.ckey] automatically kicked.")
//			message_admins("[src.ckey] has been kicked due to his account being too new: [src.account_age] days")
//			to_chat(src, span_userdanger("Your account is too new to join this server. Come back in [CONFIG_GET(number/accountage) - src.account_age] days!"))
//			QDEL_IN(src, 1)
