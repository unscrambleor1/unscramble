--[[
|------------------------------------------------- |--------- ______-----------------_______---|
|   ______   __   ______    _____     _____    __  |  _____  |  ____|  __     __    /  _____/  |
|  |__  __| |  | |__  __|  /     \   |     \  |  | | |__   | | |____  |  |   |  |  /  /____    |
|    |  |   |  |   |  |   /  /_\  \  |  |\  \ |  | |   /  /  |  ____| |  |   |  |  \____   /   |
|    |  |   |  |   |  |  /  _____  \ |  | \  \|  | |  /  /_  | |____  |  |___|  |   ___/  /    |
|    |__|   |__|   |__| /__/     \__\|__|  \_____| | |_____| |______|  \_______/  /______/     |
|--------------------------------------------------|-------------------------------------------|
| This Project Powered by : Pouya Poorrahman CopyRight 2016 Jove Version 5.3 Anti Spam Cli Bot |
|----------------------------------------------------------------------------------------------|
]]
--Begin supergrpup.lua
--Check members #Add supergroup
local function check_member_super(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  if type(result) == 'boolean' then
      print('This is a old message!')
      return reply_msg(msg.id, '[Not supported] This is a old message!', ok_cb, false)
    end
  if success == 0 then
	send_large_msg(receiver, "Promote me to admin first!")
  end
  for k,v in pairs(result) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- SuperGroup configuration
      data[tostring(msg.to.id)] = {
        group_type = 'SuperGroup',
		long_id = msg.to.peer_id,
		moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.title, '_', ' '),
		  lock_arabic = '🔓',
		  lock_link = "🔐",
                  flood = '🔐',
                  lock_media = '🔓',
                  lock_share = '🔓',
		  lock_bots = '🔐',
		  lock_number = '🔓',
		  lock_poker = '🔓',
		  lock_audio = '🔓',
		  lock_photo = '🔓',	
		  lock_video = '🔓',
		  lock_documents = '🔓',	
		  lock_text = '🔓',
		  lock_all = '🔓',	
		  lock_gifs = '🔓',	
		  lock_inline = '🔐',	
		  lock_cmd = '🔓',	
		  lock_spam = '🔐',
		  lock_sticker = '🔓',
		  member = '🔓',
		  public = '🔓',
		  lock_rtl = '🔓',
		  lock_tgservice = '🔓',
		  lock_contacts = '🔓',
		  lock_tag = '🔓',
		  lock_webpage = '🔐',
		  lock_fwd = '🔓',
		  lock_emoji = '🔓',
		  lock_eng = '🔓',
		  strict = '🔓',
		  lock_badw = '🔐'
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
	  local text = '<i>✨سوپر گروه اضافه شد!</i><b>(5.3)</b>✨\n<i>✨طعم مدیریت با آبنبات چوبی🍭 را بچشید✨</i>'
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Check Members #rem supergroup
local function check_member_superrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  if type(result) == 'boolean' then
      print('This is a old message!')
      return reply_msg(msg.id, '[Not supported] This is a old message!', ok_cb, false)
    end
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  local text = '<i>✨سوپر گروه حذف شد!(5.3)✨</i>'
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Function to Add supergroup
local function superadd(msg)
	local data = load_data(_config.moderation.data)
	local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_super,{receiver = receiver, data = data, msg = msg})
end

--Function to remove supergroup
local function superrem(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem,{receiver = receiver, data = data, msg = msg})
end

--Get and output admins and bots in supergroup
local function callback(cb_extra, success, result)
local i = 1
local chat_name = string.gsub(cb_extra.msg.to.print_name, "_", " ")
local member_type = cb_extra.member_type
local text = member_type.." for "..chat_name..":\n"
for k,v in pairsByKeys(result) do
if not v.first_name then
	name = " "
else
	vname = v.first_name:gsub("‮", "")
	name = vname:gsub("_", " ")
	end
		text = text.."\n"..i.." - "..name.."["..v.peer_id.."]"
		i = i + 1
	end
    send_large_msg(cb_extra.receiver, text)
end

local function callback_clean_bots (extra, success, result)
	local msg = extra.msg
	local receiver = 'channel#id'..msg.to.id
	local channel_id = msg.to.id
	for k,v in pairs(result) do
		local bot_id = v.peer_id
		kick_user(bot_id,channel_id)
	end
end
--Get and output info about supergroup
local function callback_info(cb_extra, success, result)
local title ="<i>🔨اطاعات سوپر گروه »» </i><b>["..result.title.."]</b>\n\n"
local admin_num = "<i>🔱تعداد مدیران »» </i><b>"..result.admins_count.."</b>\n"
local user_num = "<i>🔅تعداد کاربران »» </i><b>"..result.participants_count.."</b>\n"
local kicked_num = "<i>🚫تعداد اخراجیان »» </i><b>"..result.kicked_count.."</b>\n"
local channel_id = "<i>💠ایدی >> </i><b>"..result.peer_id.."</b>\n"
if result.username then
	channel_username = "<i>✨نام کاربری »»</i> @"..result.username
else
	channel_username = ""
end
local text = title..admin_num..user_num..kicked_num..channel_id..channel_username
    send_large_msg(cb_extra.receiver, text)
end

--Get and output members of supergroup
local function callback_who(cb_extra, success, result)
local text = "<i>✨اعضای </i>"..cb_extra.receiver
local i = 1
for k,v in pairsByKeys(result) do
if not v.print_name then
	name = " "
else
	vname = v.print_name:gsub("‮", "")
	name = vname:gsub("_", " ")
end
	if v.username then
		username = " @"..v.username
	else
		username = ""
	end
	text = text.."\n"..i.." - "..name.." "..username.." [ "..v.peer_id.." ]\n"
	--text = text.."\n"..username
	i = i + 1
end
    local file = io.open("./groups/lists/supergroups/"..cb_extra.receiver..".txt", "w")
    file:write(text)
    file:flush()
    file:close()
    send_document(cb_extra.receiver,"./groups/lists/supergroups/"..cb_extra.receiver..".txt", ok_cb, false)
	post_msg(cb_extra.receiver, text, ok_cb, false)
end

--Get and output list of kicked users for supergroup
local function callback_kicked(cb_extra, success, result)
--vardump(result)
local text = "<i>🚫اعضای حذف شده ی سوپر گروه</i> "..cb_extra.receiver.."\n\n> "
local i = 1
  	for k,v in pairsByKeys(result) do
  		if not v.print_name then
  			name = " "
  		else
  			vname = v.print_name:gsub("‮", "")
  			name = vname:gsub("_", " ")
  		end
  		if v.username then
  			name = name.." @"..v.username
  		end
  		text = text.."\n"..i.." - "..name.." [ "..v.peer_id.." ]\n"
  		i = i + 1
	end
	local file = io.open("./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", "w")
  	file:write(text)
  	file:flush()
  	file:close()
  	send_document(cb_extra.receiver,"./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", ok_cb, false)
 --send_large_msg(cb_extra.receiver, text)
end

--Begin supergroup locks
local function lock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨قفل لینک از قبل فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_link'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل لینک فعال شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨قفل لینک فعال نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_link'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل لینک غیر فعال شد✨</i>", ok_cb, false)
  end
end

	local function lock_group_media(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨رسانه از قبل قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_media'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨رسانه قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_media(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨رسانه قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_media'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"</i>✨رسانه باز شد✨</i>", ok_cb, false)
  end
end

local function lock_group_share(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_share_lock = data[tostring(target)]['settings']['lock_share']
  if group_share_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨اشتراک گذاری از قبل قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_share'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨اشتراک گذاری قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_share(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_share_lock = data[tostring(target)]['settings']['lock_share']
  if group_share_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨اشتراک گذاری قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_share'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اشتراک گذاری باز شد✨</i>", ok_cb, false)
  end
end

local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨ورود ربات از قبل قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_bots'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ورود ربات قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨ورود ربات قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_bots'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ورود ربات ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_number(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_number_lock = data[tostring(target)]['settings']['lock_number']
  if group_number_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨ارسال شماره قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_number'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨ارسال شماره قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_number(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_number_lock = data[tostring(target)]['settings']['lock_number']
  if group_number_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨ارسال شماره قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_number'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال شماره ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨ارسال پوکر از قبل قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_poker'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال پوکر قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨ارسال پوکر قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_poker'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال پوکر ازاد شد✨</i>", ok_cb, false)
  end
end

	local function lock_group_audio(msg, data, target)
		local msg_type = 'Audio'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال صدا قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_audio'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال صدا قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_audio(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Audio'
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال صدا قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_audio'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال صدا ازاد شد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_photo(msg, data, target)
		local msg_type = 'Photo'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال عکس قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_photo'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال عکس قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_photo(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Photo'
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال عکس قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_photo'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال عکس ازاد شد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_video(msg, data, target)
		local msg_type = 'Video'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال فیلم از قبل قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_video'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال فیلم قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_video(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Video'
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال فیلم قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_video'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال فیلم ازاد شد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_documents(msg, data, target)
		local msg_type = 'Documents'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_documents_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال فایل قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_documents'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال فایل قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_documents(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Documents'
  if not is_momod(msg) then
    return
  end
  local group_documents_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال فایل قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_documents'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال فیلم ازاد شد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_text(msg, data, target)
		local msg_type = 'Text'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال متن قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_text'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال متن قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_text(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Text'
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال متن قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_text'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال متن ازاد شد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_all(msg, data, target)
		local msg_type = 'All'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨همه چیز قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_all'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨همه چیز قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_all(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'All'
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨همه چیز قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_all'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨همه چیز ازادشد✨</i>", ok_cb, false)
    end
  end
end

	local function lock_group_gifs(msg, data, target)
		local msg_type = 'Gifs'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == '🔐' and is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨گیف قفل است✨</i>", ok_cb, false)
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_gifs'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال گیف قفل شد✨</i>", ok_cb, false)
    end
  end
end

local function unlock_group_gifs(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Gifs'
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == '🔓' and not is_muted(chat_id, msg_type..': yes') then
   return reply_msg(msg.id,"<i>✨ارسال گیف قفل نیست✨</i>", ok_cb, false)
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_gifs'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال گیف ازاد شد✨</i>", ok_cb, false)
    end
  end
end

local function lock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨اینلاین قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_inline'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨اینلاین قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨اینلاین قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_inline'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨اینلاین ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == '🔐' then
   return reply_msg(msg.id,"<i>✨ارسال دستورات قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_cmd'] = '🔐'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال دستورات قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == '🔓' then
   return reply_msg(msg.id,"<i>✨ارسال دستورات قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_cmd'] = '🔓'
    save_data(_config.moderation.data, data)
   return reply_msg(msg.id,"<i>✨ارسال دستورات ازادشد✨</i>", ok_cb, false)
  end
end

local function is_cmd(jtext)
    if jtext:match("^[/#!](.*)$") then
        return true
    end
    return false
end

    local function isABotBadWay (user)
      local username = user.username or ''
      return username:match("[Bb]ot$")
    end


local function lock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  if not is_owner(msg) then
    return reply_msg(msg.id,"<i>✨*فقط مدیران!✨</i>", ok_cb, false)
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨اسپم از قبل فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_spam'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اسپم فعال شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨اسپم غیر فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_spam'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اسپم غیر فعال شد✨</i>", ok_cb, false)
  end
end

local function lock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨اسپم کردن قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['flood'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اسپم کردن قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨اسپم کردن قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['flood'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اسپم کردن باز شد✨</i>", ok_cb, false)
  end
end

local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨عربی و فارسی از قبل قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_arabic'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨عربی و فارسی قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨عربی و فارسی قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_arabic'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨عربی و فارسی ازاد شد✨</i>", ok_cb, false)
  end
end
-- Tag Fanction by MehdiHS!
local function lock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨تگ قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_tag'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨تگ قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨تگ قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_tag'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨تگ ازاد شد✨</i>", ok_cb, false)
  end
end
-- WebPage Fanction by MehdiHS!
local function lock_group_webpage(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_webpage_lock = data[tostring(target)]['settings']['lock_webpage']
  if group_webpage_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨لینک وب فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_webpage'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨لینک وب فعال شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_webpage(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_webpage_lock = data[tostring(target)]['settings']['lock_webpage']
  if group_webpage_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨لینک وب فعال نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_webpage'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨لینک وب ازاد شد✨</i>", ok_cb, false)
  end
end
-- Anti Fwd Fanction by MehdiHS!
local function lock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨قفل فروارد فعال است!✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_fwd'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل فروارد فعال شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨قفل فروارد فعال نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_fwd'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل فروارد ازاد شد✨</i>", ok_cb, false)
  end
end
-- lock badword Fanction by MehdiHS!
local function lock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨قفل فحش فعال است!✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_badw'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل فحش فعال شد!✨</i>", ok_cb, false)
  end
end

local function unlock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨قفل فحش فعال نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_badw'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨قفل فحش ازاد شد✨</i>", ok_cb, false)
  end
end
-- lock emoji Fanction by MehdiHS!
local function lock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨ایموجی فعال است!✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_emoji'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨ایموجی فعال شد!✨</i>", ok_cb, false)
  end
end

local function unlock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨ایموجی فعال نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_emoji'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨ایموجی ازاد شد✨</i>", ok_cb, false)
  end
end
-- lock English Fanction by MehdiHS!
local function lock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨انگلیسی قفل است!✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_eng'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨انگلیسی قفل شد!✨</i>", ok_cb, false)
  end
end

local function unlock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨انگلیسی قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_eng'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨انگلیسی ازاد شد✨</i>", ok_cb, false)
  end
end
local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨اعضای گروه قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_member'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اعضای گروه ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨راستچین قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_rtl'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨راستچین قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨راستچین قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_rtl'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨راستچین ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨اعلان قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_tgservice'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اعلان قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨اعلان قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_tgservice'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨اعلان ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨استیکر قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_sticker'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨استیکر قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨استیکر قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_sticker'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨استیکر ازاد شد✨</i>", ok_cb, false)
  end
end

local function lock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨مخاطب قفل است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_contacts'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨مخاطب قفل شد✨</i>", ok_cb, false)
  end
end

local function unlock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨مخاطب قفل نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_contacts'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨مخاطب ازاد شد✨</i>", ok_cb, false)
  end
end

local function enable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨تنظیمات سخت گیرانه فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['strict'] = '🔐'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨تنظیمات سخت گیرانه فعال شد✨</i>", ok_cb, false)
  end
end

local function disable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨تنظیمات سخت گیرانه غیر فعال است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['strict'] = '🔓'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨تنظیمات سخت گیرانه غیر فعال شد✨</i>", ok_cb, false)
  end
end
--End supergroup locks

--'Set supergroup rules' function
local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return reply_msg(msg.id,"<i>✨قوانین ثبت شد✨</i>", ok_cb, false)
end

--'Get supergroup rules' function
local function get_rules(msg, data)
  local data_cat = 'rules'
  if not data[tostring(msg.to.id)][data_cat] then
    return reply_msg(msg.id,"<i>✨قانونی ثبت نشده است✨</i>", ok_cb, false)
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local group_name = data[tostring(msg.to.id)]['settings']['set_name']
  local rules = group_name..'<i> ✨قوانین✨</i>:\n\n'..rules:gsub("/n", " ")
  return rules
end

--Set supergroup to public or not public function
local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return reply_msg(msg.id,"<i>✨فقط برای مدیران!</i>✨", ok_cb, false)
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id
	save_data(_config.moderation.data, data)
  end
  if group_public_lock == '🔐' then
    return reply_msg(msg.id,"<i>✨گروه از قبل عمومی است✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['public'] = '🔐'
    save_data(_config.moderation.data, data)
  end
  return reply_msg(msg.id,"<i>✨حالا گروه عمومی شد✨</i>", ok_cb, false)
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id
	save_data(_config.moderation.data, data)
  end
  if group_public_lock == '🔓' then
    return reply_msg(msg.id,"<i>✨گروه عمومی نیست✨</i>", ok_cb, false)
  else
    data[tostring(target)]['settings']['public'] = '🔓'
	data[tostring(target)]['long_id'] = msg.to.long_id
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"<i>✨گروه از حالت عمومی در امده است✨</i>",ok_cb,false)
  end
end

--Show supergroup settings; function
function show_supergroup_settingsmod(msg, target)
 	if not is_momod(msg) then
    	return
  	end
	local data = load_data(_config.moderation.data)
    if data[tostring(target)] then
     	if data[tostring(target)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else
        	NUM_MSG_MAX = 5
      	end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = '🔓'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tag'] then
			data[tostring(target)]['settings']['lock_tag'] = '🔓'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_webpage'] then
			data[tostring(target)]['settings']['lock_webpage'] = '🔐'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_emoji'] then
			data[tostring(target)]['settings']['lock_emoji'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_eng'] then
			data[tostring(target)]['settings']['lock_eng'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_badw'] then
			data[tostring(target)]['settings']['lock_badw'] = '🔐'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_photo'] then
			data[tostring(target)]['settings']['lock_photo'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_gif'] then
			data[tostring(target)]['settings']['lock_gif'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_video'] then
			data[tostring(target)]['settings']['lock_video'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_document'] then
			data[tostring(target)]['settings']['lock_document'] = '🔓'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_audio'] then
			data[tostring(target)]['settings']['lock_audio'] = '🔓'
		end
end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tgservice'] then
			data[tostring(target)]['settings']['lock_tgservice'] = '🔓'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_member'] then
			data[tostring(target)]['settings']['lock_member'] = '🔓'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_fwd'] then
			data[tostring(target)]['settings']['lock_fwd'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_media'] then
			data[tostring(target)]['settings']['lock_media'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_share'] then
			data[tostring(target)]['settings']['lock_share'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_bots'] then
			data[tostring(target)]['settings']['lock_bots'] = '🔐'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_number'] then
			data[tostring(target)]['settings']['lock_number'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_poker'] then
			data[tostring(target)]['settings']['lock_poker'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_audio'] then
			data[tostring(target)]['settings']['lock_audio'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_photo'] then
			data[tostring(target)]['settings']['lock_photo'] = '🔓'
		end
	end	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_video'] then
			data[tostring(target)]['settings']['lock_video'] = '🔓'
		end
	end	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_documents'] then
			data[tostring(target)]['settings']['lock_documents'] = '🔓'
		end
	end	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_text'] then
			data[tostring(target)]['settings']['lock_text'] = '🔓'
		end
	end	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_all'] then
			data[tostring(target)]['settings']['lock_all'] = '🔓'
		end
	end
		if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_gifs'] then
			data[tostring(target)]['settings']['lock_gifs'] = '🔓'
		end
	end
			if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_inline'] then
			data[tostring(target)]['settings']['lock_inline'] = '🔓'
		end
	end
			if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_cmd'] then
			data[tostring(target)]['settings']['lock_cmd'] = '🔓'
		end
	end
  local settings = data[tostring(target)]['settings']
local text = "<i>✨تنظیمات سوپر گروه✨</i>:\n➖➖➖➖➖➖➖➖\n\n<i>«اسم ربات»»📍ژوپیتر 5.3📍 \n«لقب ورژن»» 🍭آبنبات چوبی(Lollipop)🍭 \n«قفل لینک»» "..settings.lock_link.."\n«قفل وب لینک»» "..settings.lock_webpage.."\n«قفل تگ»» "..settings.lock_tag.."\n«قفل شکلک»» "..settings.lock_emoji.."\n«قفل انگلیسی»» "..settings.lock_eng.."\n«قفل کلمات زشت»» "..settings.lock_badw.."\n«قفل حساسیت»» "..settings.flood.."\n«مقدار حساسیت»» 🔅"..NUM_MSG_MAX.."🔅\n«قفل اسپم»» "..settings.lock_spam.."\n«قفل مخاطب»» "..settings.lock_contacts.."\n«قفل فارسی»» "..settings.lock_arabic.."\n«قفل اعضا»» "..settings.lock_member.."\n«قفل راستچین»» "..settings.lock_rtl.."\n«قفل فروارد»» "..settings.lock_fwd.."\n«قفل اعلان»» "..settings.lock_tgservice.."\n«قفل استیکر»» "..settings.lock_sticker.."\n«قفل رسانه»» "..settings.lock_media.."\n«قفل ربات ها»» "..settings.lock_bots.."\n«قفل اشتراک گذاری»»"..settings.lock_share.."\n«قفل شماره»»"..settings.lock_number.."\n«قفل پوکر»» "..settings.lock_poker.."\n«قفل صدا»» "..settings.lock_audio.."\n«قفل عکس»» "..settings.lock_photo.."\n«قفل فیلم»» "..settings.lock_video.."\n«قفل فایل»» "..settings.lock_documents.."\n«قفل متن»» "..settings.lock_text.."\n«قفل همه»» "..settings.lock_all.."\n«قفل گیف»» "..settings.lock_gifs.."\n«قفل لینک شیشه ای(اینلاین)»» "..settings.lock_inline.."\n«قفل دستورات(cmd)»» "..settings.lock_cmd.."\n«عمومی»» "..settings.public.."\n«قفل سختگیرانه»» "..settings.strict.."</i>\n\n➖➖➖➖➖➖➖➖➖\n✨<i>«مدیریت کامل»: SmartTG.Ir ✨</i>"	
	reply_msg(msg.id, text, ok_cb, false)
end

local function promote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return
  end
  if data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..' <i>✨از قبل یک مدیر است✨</i>')
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
end

local function demote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return
  end
  if not data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_tag_username..'<i> یک  ✨مدیر نیست✨</i>')
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
end

local function promote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return send_large_msg(receiver, '<i>✨سوپر گروه اضافه نشده است✨</i>')
  end
  if data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..'<i>✨از قبل یک مدیر است✨</i>')
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username..'<i> ✨ارتقا یافت✨</i>')
end

local function demote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return send_large_msg(receiver, '<i>✨گروه اضافه نشده است✨</i>')
  end
  if not data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_tag_username..'<i>✨دیگر مدیر نیست✨</i>')
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username..'<i>✨عزل شد✨</i>')
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return '<i>✨سوپر گروه اضافه نشده است✨</i>'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then
    return '<i>✨مدیری در این گروه حضور ندارد ✨</i>'
  end
  local i = 1
  local message = '\n<i>✨لیست مدیران </i>' .. string.gsub(msg.to.print_name, '_', ' ') .. '✨:\n> '
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

-- Start by reply actions
function get_message_callback(extra, success, result)
	local get_cmd = extra.get_cmd
	local msg = extra.msg
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "")
	local name_log = print_name:gsub("_", " ")
    if type(result) == 'boolean' then
  		print('This is a old message!')
  		return
  	end
  	if get_cmd == "id" and not result.action then
		local channel = 'channel#id'..result.to.peer_id
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for: ["..result.from.peer_id.."]")
		id1 = send_large_msg(channel, result.from.peer_id)
	elseif get_cmd == 'id' and result.action then
		local action = result.action.type
		if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
			if result.action.user then
				user_id = result.action.user.peer_id
			else
				user_id = result.peer_id
			end
			local channel = 'channel#id'..result.to.peer_id
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id by service msg for: ["..user_id.."]")
			id1 = send_large_msg(channel, user_id)
		end
    elseif get_cmd == "idfrom" then
		local channel = 'channel#id'..result.to.peer_id
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for msg fwd from: ["..result.fwd_from.peer_id.."]")
		id2 = send_large_msg(channel, result.fwd_from.peer_id)
    elseif get_cmd == 'channel_block' and not result.action then
		local member_id = result.from.peer_id
		local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "✨Leave using kickme command✨")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
			   return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید بالا مقام ها را اخراج کنید✨</i>")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید سایر مدیران را اخراج کنید✨</i>")
    end
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply")
		kick_user(member_id, channel_id)
	elseif get_cmd == 'channel_block' and result.action and result.action.type == 'chat_add_user' then
		local user_id = result.action.user.peer_id
		local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "✨Leave using kickme command✨")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
			   return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید بالا مقام ها را اخراج کنید✨</i>")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید سایر مدیران را اخراج کنید✨</i>")
    end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply to sev. msg.")
		kick_user(user_id, channel_id)
	elseif get_cmd == "del" then
		delete_msg(result.id, ok_cb, false)
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted a message by reply")
	elseif get_cmd == "setadmin" then
		local user_id = result.from.peer_id
		local channel_id = "channel#id"..result.to.peer_id
		channel_set_admin(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
			text = "<i>✨ @"..result.from.username.." ادمین شد✨</i>"
		else
			text = "✨<b>[ "..user_id.." ]</b><i>ادمین شد✨</i>"
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..user_id.."] as admin by reply")
		send_large_msg(channel_id, text)
	elseif get_cmd == "demoteadmin" then
		local user_id = result.from.peer_id
		local channel_id = "channel#id"..result.to.peer_id
		if is_admin2(result.from.peer_id) then
			return send_large_msg(channel_id, "<i>✨شما نمیتوانید ادمین های کل را خلع کنید✨</i>")
		end
		channel_demote(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
			text = "<i>✨ @"..result.from.username.." خلع مقام شد✨</i>"
		else
			text = "<i>✨[ "..user_id.." ] خلع مقام شد✨</i>"
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted: ["..user_id.."] from admin by reply")
		send_large_msg(channel_id, text)
	elseif get_cmd == "setowner" then
		local group_owner = data[tostring(result.to.peer_id)]['set_owner']
		if group_owner then
		local channel_id = 'channel#id'..result.to.peer_id
			if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
				local user = "user#id"..group_owner
				channel_demote(channel_id, user, ok_cb, false)
			end
			local user_id = "user#id"..result.from.peer_id
			channel_set_admin(channel_id, user_id, ok_cb, false)
			data[tostring(result.to.peer_id)]['set_owner'] = tostring(result.from.peer_id)
			save_data(_config.moderation.data, data)
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..result.from.peer_id.."] as owner by reply")
			if result.from.username then
				text = "<i>✨ @"..result.from.username.." [ "..result.from.peer_id.." ]مالک گروه شد✨</i>"
			else
				text = "<b>✨[ "..result.from.peer_id.." ]</b><i> مالک گروه شد✨</i>"
			end
			send_large_msg(channel_id, text)
		end
	elseif get_cmd == "promote" then
		local receiver = result.to.peer_id
		local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
		local member_name = full_name:gsub("‮", "")
		local member_username = member_name:gsub("_", " ")
		if result.from.username then
			member_username = '@'.. result.from.username
		end
		local member_id = result.from.peer_id
		if result.to.peer_type == 'channel' then
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted mod: @"..member_username.."["..result.from.peer_id.."] by reply")
		promote2("channel#id"..result.to.peer_id, member_username, member_id)
	    --channel_set_mod(channel_id, user, ok_cb, false)
		end
	elseif get_cmd == "demote" then
		local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
		local member_name = full_name:gsub("‮", "")
		local member_username = member_name:gsub("_", " ")
    if result.from.username then
		member_username = '@'.. result.from.username
    end
		local member_id = result.from.peer_id
		--local user = "user#id"..result.peer_id
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted mod: @"..member_username.."["..user_id.."] by reply")
		demote2("channel#id"..result.to.peer_id, member_username, member_id)
		--channel_demote(channel_id, user, ok_cb, false)
	elseif get_cmd == 'mute_user' then
		if result.service then
			local action = result.action.type
			if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
				if result.action.user then
					user_id = result.action.user.peer_id
				end
			end
			if action == 'chat_add_user_link' then
				if result.from then
					user_id = result.from.peer_id
				end
			end
		else
			user_id = result.from.peer_id
		end
		local receiver = extra.receiver
		local chat_id = msg.to.id
		print(user_id)
		print(chat_id)
		if is_muted_user(chat_id, user_id) then
			unmute_user(chat_id, user_id)
			send_large_msg(receiver, "<b>✨["..user_id.."]</b><i>از لیست ساکت شده ها خارج شد✨</i>")
		elseif is_admin1(msg) then
			mute_user(chat_id, user_id)
			send_large_msg(receiver, "<b>✨ ["..user_id.."]</b><i> ساکت شد✨</i>")
		end
	end
end
-- End by reply actions

--By ID actions
local function cb_user_info(extra, success, result)
	local receiver = extra.receiver
	local user_id = result.peer_id
	local get_cmd = extra.get_cmd
	local data = load_data(_config.moderation.data)
	--[[if get_cmd == "setadmin" then
		local user_id = "user#id"..result.peer_id
		channel_set_admin(receiver, user_id, ok_cb, false)
		if result.username then
			text = "@"..result.username.." has been set as an admin"
		else
			text = "[ "..result.peer_id.." ] has been set as an admin"
		end
			send_large_msg(receiver, text)]]
	if get_cmd == "demoteadmin" then
		if is_admin2(result.peer_id) then
			return send_large_msg(receiver, "<i>✨شما نمیتوانید ادمین های کل را خلع مقام کنید!✨</i>")
		end
		local user_id = "user#id"..result.peer_id
		channel_demote(receiver, user_id, ok_cb, false)
		if result.username then
			text = "<i>✨ @"..result.username.." از ادمینی خلع شد✨</i>"
			send_large_msg(receiver, text)
		else
			text = "<i>✨[ "..result.peer_id.." ] از ادمینی خلع شد✨</i>"
			send_large_msg(receiver, text)
		end
	elseif get_cmd == "promote" then
		if result.username then
			member_username = "@"..result.username
		else
			member_username = string.gsub(result.print_name, '_', ' ')
		end
		promote2(receiver, member_username, user_id)
	elseif get_cmd == "demote" then
		if result.username then
			member_username = "@"..result.username
		else
			member_username = string.gsub(result.print_name, '_', ' ')
		end
		demote2(receiver, member_username, user_id)
	end
end

-- Begin resolve username actions
local function callbackres(extra, success, result)
  local member_id = result.peer_id
  local member_username = "@"..result.username
  local get_cmd = extra.get_cmd
	if get_cmd == "res" then
		local user = result.peer_id
		local name = string.gsub(result.print_name, "_", " ")
		local channel = 'channel#id'..extra.channelid
		send_large_msg(channel, user..'\n'..name)
		return user
	elseif get_cmd == "id" then
		local user = result.peer_id
		local channel = 'channel#id'..extra.channelid
		send_large_msg(channel, user)
		return user
  elseif get_cmd == "invite" then
    local receiver = extra.channel
    local user_id = "user#id"..result.peer_id
    channel_invite(receiver, user_id, ok_cb, false)
	--elseif get_cmd == "channel_block" then
		local user_id = result.peer_id
		local channel_id = extra.channelid
    local sender = extra.sender
    if member_id == sender then
      return send_large_msg("channel#id"..channel_id, "💠Leave using kickme command💠")
    end
		if is_momod2(member_id, channel_id) and not is_admin2(sender) then
			   return send_large_msg("channel#id"..channel_id, "<i>✨نمیتوانید بالا مقام را اخراج کنید✨</i>")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید سایر مدیران را اخراج کنید✨</i>")
    end
		kick_user(user_id, channel_id)
	elseif get_cmd == "setadmin" then
		local user_id = "user#id"..result.peer_id
		local channel_id = extra.channel
		channel_set_admin(channel_id, user_id, ok_cb, false)
	    if result.username then
			text = "<i>✨ @"..result.username.." ادمین شد✨</i>"
			send_large_msg(channel_id, text)
		else
			text = "<i>✨ @"..result.peer_id.." ادمین شد✨</i>"
			send_large_msg(channel_id, text)
		end
	elseif get_cmd == "setowner" then
		local receiver = extra.channel
		local channel = string.gsub(receiver, 'channel#id', '')
		local from_id = extra.from_id
		local group_owner = data[tostring(channel)]['set_owner']
		if group_owner then
			local user = "user#id"..group_owner
			if not is_admin2(group_owner) and not is_support(group_owner) then
				channel_demote(receiver, user, ok_cb, false)
			end
			local user_id = "user#id"..result.peer_id
			channel_set_admin(receiver, user_id, ok_cb, false)
			data[tostring(channel)]['set_owner'] = tostring(result.peer_id)
			save_data(_config.moderation.data, data)
			savelog(channel, name_log.." ["..from_id.."] set ["..result.peer_id.."] as owner by username")
		if result.username then
			text = member_username.."<b>✨ [ "..result.peer_id.." ][ "..result.username.." ]</b><i> مالک گروه شد✨</i>"
		else
			text = "<b>✨ [ "..result.peer_id.." ]</b><i> مالک گروه شد ✨<i>"
		end
		send_large_msg(receiver, text)
  end
	elseif get_cmd == "promote" then
		local receiver = extra.channel
		local user_id = result.peer_id
		--local user = "user#id"..result.peer_id
		promote2(receiver, member_username, user_id)
		--channel_set_mod(receiver, user, ok_cb, false)
	elseif get_cmd == "demote" then
		local receiver = extra.channel
		local user_id = result.peer_id
		local user = "user#id"..result.peer_id
		demote2(receiver, member_username, user_id)
	elseif get_cmd == "demoteadmin" then
		local user_id = "user#id"..result.peer_id
		local channel_id = extra.channel
		if is_admin2(result.peer_id) then
			return send_large_msg(channel_id, "<i>✨شما ادمین های کل را نمیتوانید خلع کنید!✨</i>")
		end
		channel_demote(channel_id, user_id, ok_cb, false)
		if result.username then
			text = "<i>✨ @"..result.username.." خلع شد✨</i>"
			send_large_msg(channel_id, text)
		else
			text = "<i>✨ @"..result.peer_id.." خلع شد✨</i>"
			send_large_msg(channel_id, text)
		end
		local receiver = extra.channel
		local user_id = result.peer_id
		demote_admin(receiver, member_username, user_id)
	elseif get_cmd == 'mute_user' then
		local user_id = result.peer_id
		local receiver = extra.receiver
		local chat_id = string.gsub(receiver, 'channel#id', '')
		if is_muted_user(chat_id, user_id) then
			unmute_user(chat_id, user_id)
			send_large_msg(receiver, "<b>✨ ["..user_id.."] </b><i>از لیست ساکت شده ها خارج شد✨</i>")
		elseif is_owner(extra.msg) then
			mute_user(chat_id, user_id)
			send_large_msg(receiver, "<b>✨ ["..user_id.."]</b><i> ساکت شد✨</i>")
		end
	end
end
--End resolve username actions

--Begin non-channel_invite username actions
local function in_channel_cb(cb_extra, success, result)
  local get_cmd = cb_extra.get_cmd
  local receiver = cb_extra.receiver
  local msg = cb_extra.msg
  local data = load_data(_config.moderation.data)
  local print_name = user_print_name(cb_extra.msg.from):gsub("‮", "")
  local name_log = print_name:gsub("_", " ")
  local member = cb_extra.username
  local memberid = cb_extra.user_id
  if member then
    text = '<i>✨فردی با ایدی @'..member..' در این سوپر گروه نیست✨</i>'
  else
    text = '<i>✨فردی با ایدی ['..memberid..'] در این سوپر گروه نیست✨</i>'
  end
if get_cmd == "channel_block" then
  for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
     local user_id = v.peer_id
     local channel_id = cb_extra.msg.to.id
     local sender = cb_extra.msg.from.id
      if user_id == sender then
        return send_large_msg("channel#id"..channel_id, "💠Leave using kickme command💠")
      end
      if is_momod2(user_id, channel_id) and not is_admin2(sender) then
        return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید بالا مقام را اخراج کنید✨</i>")
      end
      if is_admin2(user_id) then
        return send_large_msg("channel#id"..channel_id, "<i>✨شما نمیتوانید سایر مدیران را اخراج کنید✨</i>")
      end
      if v.username then
        text = ""
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..v.username.." ["..v.peer_id.."]")
      else
        text = ""
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..v.peer_id.."]")
      end
      kick_user(user_id, channel_id)
      return
    end
  end
elseif get_cmd == "setadmin" then
   for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
      local user_id = "user#id"..v.peer_id
      local channel_id = "channel#id"..cb_extra.msg.to.id
      channel_set_admin(channel_id, user_id, ok_cb, false)
      if v.username then
        text = "<b>✨ @"..v.username.." ["..v.peer_id.."]</b><i> ادمین شد✨</i>"
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..v.username.." ["..v.peer_id.."]")
      else
        text = "<b>✨ ["..v.peer_id.."]</b><i> ادمین شد✨</i>"
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin "..v.peer_id)
      end
	  if v.username then
		member_username = "@"..v.username
	  else
		member_username = string.gsub(v.print_name, '_', ' ')
	  end
		local receiver = channel_id
		local user_id = v.peer_id
		promote_admin(receiver, member_username, user_id)

    end
    send_large_msg(channel_id, text)
    return
 end
 elseif get_cmd == 'setowner' then
	for k,v in pairs(result) do
		vusername = v.username
		vpeer_id = tostring(v.peer_id)
		if vusername == member or vpeer_id == memberid then
			local channel = string.gsub(receiver, 'channel#id', '')
			local from_id = cb_extra.msg.from.id
			local group_owner = data[tostring(channel)]['set_owner']
			if group_owner then
				if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
					local user = "user#id"..group_owner
					channel_demote(receiver, user, ok_cb, false)
				end
					local user_id = "user#id"..v.peer_id
					channel_set_admin(receiver, user_id, ok_cb, false)
					data[tostring(channel)]['set_owner'] = tostring(v.peer_id)
					save_data(_config.moderation.data, data)
					savelog(channel, name_log.."["..from_id.."] set ["..v.peer_id.."] as owner by username")
				if result.username then
					text = member_username.."<b>✨ ["..v.peer_id.."]["..v.username.."]</b><i> مالک گروه شد✨</i>"
				else
					text = "<b>✨ ["..v.peer_id.."]</b><i> مالک گروه شد✨</i>"
				end
			end
		elseif memberid and vusername ~= member and vpeer_id ~= memberid then
			local channel = string.gsub(receiver, 'channel#id', '')
			local from_id = cb_extra.msg.from.id
			local group_owner = data[tostring(channel)]['set_owner']
			if group_owner then
				if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
					local user = "user#id"..group_owner
					channel_demote(receiver, user, ok_cb, false)
				end
				data[tostring(channel)]['set_owner'] = tostring(memberid)
				save_data(_config.moderation.data, data)
				savelog(channel, name_log.."["..from_id.."] set ["..memberid.."] as owner by username")
				text = "<b>✨ ["..memberid.."]["..member.."]</b><i> مالک گروه شد✨</i>"
			end
		end
	end
 end
send_large_msg(receiver, text)
end
--End non-channel_invite username actions

--'Set supergroup photo' function
local function set_supergroup_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)] then
      return
  end
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/channel_photo_'..msg.to.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    channel_set_photo(receiver, file, ok_cb, false)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, '<i>✨عکس ذخیره شد✨!</i>', ok_cb, false)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, '<i>✨انجام نشد بعدا تست کنید!✨</i>', ok_cb, false)
  end
end

--Run function
local function run(msg, matches)
	if msg.to.type == 'chat' then
		if matches[1] == 'تبدیل به سوپرگروه' then
			if not is_admin1(msg) then
				return
			end
			local receiver = get_receiver(msg)
			chat_upgrade(receiver, ok_cb, false)
		end
	elseif msg.to.type == 'channel'then
		if matches[1] == 'تبدیل به سوپرگروه' then
			if not is_admin1(msg) then
				return
			end
			return "<i>✨از قبل سوپر گروه است✨</i>"
		end
	end
	if msg.to.type == 'channel' then
	local support_id = msg.from.id
	local receiver = get_receiver(msg)
	local print_name = user_print_name(msg.from):gsub("‮", "")
	local name_log = print_name:gsub("_", " ")
	local data = load_data(_config.moderation.data)
		if matches[1] == 'اضافه' and not matches[2] then
			if not is_admin1(msg) and not is_support(support_id) then
				return
			end
			if is_super_group(msg) then
				return reply_msg(msg.id, '<i>✨سوپر گروه از قبل اضافه شده است✨\n✨این ربات با ورژن ابنبات چوبی🍭 اداره میشود✨</i>', ok_cb, false)
			end
			print("<i>✨سوپر گروه "..msg.to.print_name.."("..msg.to.id..") اضافه شد✨</i>")
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] added SuperGroup")
			superadd(msg)
			set_mutes(msg.to.id)
			channel_set_admin(receiver, 'user#id'..msg.from.id, ok_cb, false)
		end

		if matches[1] == 'حذف گروه' and is_admin1(msg) and not matches[2] then
			if not is_super_group(msg) then
				return reply_msg(msg.id, '<i>✨سوپر گروه اضافه نشده است✨</i>', ok_cb, false)
			end
			print("<i>✨سوپر گروه "..msg.to.print_name.."("..msg.to.id..") حذف شد✨</i>")
			superrem(msg)
			rem_mutes(msg.to.id)
		end

		if not data[tostring(msg.to.id)] then
			return
		end
		if matches[1] == "اطلاعات" then
			if not is_owner(msg) then
				return
			end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup info")
			channel_info(receiver, callback_info, {receiver = receiver, msg = msg})
		end

		if matches[1] == "ادمین ها" then
			if not is_owner(msg) and not is_support(msg.from.id) then
				return
			end
			member_type = 'Admins'
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup Admins list")
			admins = channel_get_admins(receiver,callback, {receiver = receiver, msg = msg, member_type = member_type})
		end

		if matches[1] == "مالک" then
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
				return "<i>✨مالکی نیست!از مدیران کل بخواهید یکی را مالک گروه کنند✨</i>"
			end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
			return "<i>✨مالک گروه✨</i> »»<b> ✨["..group_owner..']✨</b>'
		end

		if matches[1] == "لیست مدیران" then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
			return modlist(msg)
			-- channel_get_admins(receiver,callback, {receiver = receiver})
		end

		if matches[1] == "ربات ها" and is_momod(msg) then
			member_type = 'Bots'
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup bots list")
			channel_get_bots(receiver, callback, {receiver = receiver, msg = msg, member_type = member_type})
		end

		if matches[1] == "افراد" and not matches[2] and is_momod(msg) then
			local user_id = msg.from.peer_id
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup users list")
			channel_get_users(receiver, callback_who, {receiver = receiver})
		end

		if matches[1] == "اخراج شده" and is_momod(msg) then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested Kicked users list")
			channel_get_kicked(receiver, callback_kicked, {receiver = receiver})
		end

		if matches[1] == 'حذف' and is_momod(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'del',
					msg = msg
				}
				delete_msg(msg.id, ok_cb, false)
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			end
		end

		if matches[1] == 'اخراج' and is_momod(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'channel_block',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'اخراج' and string.match(matches[2], '^%d+$') then
				local user_id = matches[2]
				local channel_id = msg.to.id
				if is_momod2(user_id, channel_id) and not is_admin2(user_id) then
					return send_large_msg(receiver, "<i>✨شما نمیتوانید بالا مقام را اخراج کنید✨</i>")
				end
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: [ user#id"..user_id.." ]")
				kick_user(user_id, channel_id)
				local	get_cmd = 'channel_block'
				local	msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif msg.text:match("@[%a%d]") then
			local cbres_extra = {
					channelid = msg.to.id,
					get_cmd = 'channel_block',
					sender = msg.from.id
				}
			    local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..username)
				resolve_username(username, callbackres, cbres_extra)
			local get_cmd = 'channel_block'
			local msg = msg
			local username = matches[2]
			local username = string.gsub(matches[2], '@', '')
			channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'ایدی' then
			if type(msg.reply_id) ~= "nil" and is_momod(msg) and not matches[2] then
				local cbreply_extra = {
					get_cmd = 'id',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif type(msg.reply_id) ~= "nil" and matches[2] == "from" and is_momod(msg) then
				local cbreply_extra = {
					get_cmd = 'idfrom',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif msg.text:match("@[%a%d]") then
				local cbres_extra = {
					channelid = msg.to.id,
					get_cmd = 'id'
				}
				local username = matches[2]
				local username = username:gsub("@","")
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested ID for: @"..username)
				resolve_username(username,  callbackres, cbres_extra)
			else
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup ID")
				return reply_msg(msg.id, "<i> «✨ایدی سوپر گروه»: "..msg.to.id.."\n «🔰اسم سوپرگروه»: "..msg.to.title.."\n «🔹اسم کوچک»: "..(msg.from.first_name or '').."\n «🔸نام خانوادگی»: "..(msg.from.last_name or '').."\n «🚩ایدی شما»: "..msg.from.id.." \n «🔆نام کاربری شما»: @"..(msg.from.username or '').."\n «📞شماره موبایل»: "..(msg.from.phone or '').."+ \n «💭لینک شما»: Telegram.Me/"..(msg.from.username or '').."\n «📝نوع گروه»: #SuperGroup\n«🍭سایت اصلی»: SmartTG.Ir </i>", ok_cb, false)		end
		end

		if matches[1] == 'اخراجم کن' then
			if msg.to.type == 'channel' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] left via kickme")
				channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false)
			end
		end

		if matches[1] == 'لینک جدید' and is_momod(msg)then
			local function callback_link (extra , success, result)
			local receiver = get_receiver(msg)
				if success == 0 then
					send_large_msg(receiver, '<i>✨خطا!دلیل:ربات سازنده نیست!لطفا از تنظیم لینک برای ثبت لینک استفاده کنید✨</i>')
					data[tostring(msg.to.id)]['settings']['set_link'] = nil
					save_data(_config.moderation.data, data)
				else
					send_large_msg(receiver, "Created a new link")
					data[tostring(msg.to.id)]['settings']['set_link'] = result
					save_data(_config.moderation.data, data)
				end
			end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to create a new SuperGroup link")
			export_channel_link(receiver, callback_link, false)
		end

		if matches[1] == 'تنظیم لینک' and is_owner(msg) then
			data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting'
			save_data(_config.moderation.data, data)
			return '<i>✨لطفا لینک جدید را اسال کنید!✨</i>'
		end

		if msg.text then
			if msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then
				data[tostring(msg.to.id)]['settings']['set_link'] = msg.text
				save_data(_config.moderation.data, data)
				return "<i>✨لینک جدید درست شد !✨\n✨ جهت خرید ساب دامین به سایت SmartTG.Ir مراجعه کنید✨</i>"
			end
		end

		if matches[1] == 'لینک' then
			if not is_momod(msg) then
				return
			end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
				return "<i>✨ابتدا لینک جدید را بسازید!یا اگر ربات سازنده نیست از تنظیم لینک استفاده کنید✨</i>"
			end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
			return "<i>✨لینک سوپر گروه✨:</i>\n> "..group_link
		end

		if matches[1] == "دعوت" and is_sudo(msg) then
			local cbres_extra = {
				channel = get_receiver(msg),
				get_cmd = "invite"
			}
			local username = matches[2]
			local username = username:gsub("@","")
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] invited @"..username)
			resolve_username(username,  callbackres, cbres_extra)
		end

		if matches[1] == 'اطلاعات' and is_owner(msg) then
			local cbres_extra = {
				channelid = msg.to.id,
				get_cmd = 'res'
			}
			local username = matches[2]
			local username = username:gsub("@","")
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] resolved username: @"..username)
			resolve_username(username,  callbackres, cbres_extra)
		end

		if matches[1] == 'اخراج' and is_momod(msg) then
			local receiver = channel..matches[3]
			local user = "user#id"..matches[2]
			chaannel_kick(receiver, user, ok_cb, false)
		end

			if matches[1] == 'تنظیم ادمین' then
				if not is_support(msg.from.id) and not is_owner(msg) then
					return
				end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'setadmin',
					msg = msg
				}
				setadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'تنظیم ادمین' and string.match(matches[2], '^%d+$') then
			--[[]	local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'setadmin'
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})]]
				local	get_cmd = 'setadmin'
				local	msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif matches[1] == 'تنظیم ادمین' and not string.match(matches[2], '^%d+$') then
				--[[local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'setadmin'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..username)
				resolve_username(username, callbackres, cbres_extra)]]
				local	get_cmd = 'setadmin'
				local	msg = msg
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'عزل ادمین' then
			if not is_support(msg.from.id) and not is_owner(msg) then
				return
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'demoteadmin',
					msg = msg
				}
				demoteadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'عزل ادمین' and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'demoteadmin'
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == 'عزل ادمین' and not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'demoteadmin'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted admin @"..username)
				resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == 'تنظیم مالک' and is_owner(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'setowner',
					msg = msg
				}
				setowner = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'تنظیم مالک' and string.match(matches[2], '^%d+$') then
			local group_owner = data[tostring(msg.to.id)]['set_owner']
				if group_owner then
					local receiver = get_receiver(msg)
					local user_id = "user#id"..group_owner
					if not is_admin2(group_owner) and not is_support(group_owner) then
						channel_demote(receiver, user_id, ok_cb, false)
					end
					local user = "user#id"..matches[2]
					channel_set_admin(receiver, user, ok_cb, false)
					data[tostring(msg.to.id)]['set_owner'] = tostring(matches[2])
					save_data(_config.moderation.data, data)
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
					local text = "<b>✨ [ "..matches[2].." ] </b><i>مالک گروه شد✨</i>"
					return text
				end
				local	get_cmd = 'setowner'
				local	msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif matches[1] == 'تنظیم مالک' and not string.match(matches[2], '^%d+$') then
				local	get_cmd = 'setowner'
				local	msg = msg
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'ارتقا' then
		  if not is_momod(msg) then
				return
			end
			if not is_owner(msg) then
				return reply_msg(msg.id,"<i>✨خطا!فقط مدیران میتوانند عزل کنند!✨</i>",ok_cb,false)
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'promote',
					msg = msg
				}
				promote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'ارتقا' and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'promote'
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted user#id"..matches[2])
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == 'ارتقا' and not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'promote',
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @"..username)
				return resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == 'mp' and is_sudo(msg) then
			channel = get_receiver(msg)
			user_id = 'user#id'..matches[2]
			channel_set_mod(channel, user_id, ok_cb, false)
			return "<i>✨انجام شد✨</i>"
		end
		if matches[1] == 'md' and is_sudo(msg) then
			channel = get_receiver(msg)
			user_id = 'user#id'..matches[2]
			channel_demote(channel, user_id, ok_cb, false)
			return "<i>✨انجام شد✨</i>"
		end

		if matches[1] == 'عزل' then
			if not is_momod(msg) then
				return
			end
			if not is_owner(msg) then
				return reply_msg(msg.id,"<i>✨خطا!فقط بالا مقام ها میتوانند عزل کنند!✨</i>",ok_cb,false)
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'demote',
					msg = msg
				}
				demote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'عزل' and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'demote'
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted user#id"..matches[2])
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'demote'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @"..username)
				return resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == "تنظیم نام" and is_momod(msg) then
			local receiver = get_receiver(msg)
			local set_name = string.gsub(matches[2], '_', '')
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..matches[2])
			rename_channel(receiver, set_name, ok_cb, false)
		end

		if msg.service and msg.action.type == 'chat_rename' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..msg.to.title)
			data[tostring(msg.to.id)]['settings']['set_name'] = msg.to.title
			save_data(_config.moderation.data, data)
		end

		if matches[1] == "تنظیم درباره" and is_momod(msg) then
			local receiver = get_receiver(msg)
			local about_text = matches[2]
			local data_cat = 'description'
			local target = msg.to.id
			data[tostring(target)][data_cat] = about_text
			save_data(_config.moderation.data, data)
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup description to: "..about_text)
			channel_set_about(receiver, about_text, ok_cb, false)
			return "<i>✨درباره گروه ثبت شد✨\n\n✨برنامه خود را ببندید سپس باز کنید✨</i>"
		end

		if matches[1] == "تنظیم نام کاربری" and is_admin1(msg) then
			local function ok_username_cb (extra, success, result)
				local receiver = extra.receiver
				if success == 1 then
					send_large_msg(receiver, "<i>✨SuperGroup username Set.✨\n\n✨Select the chat again to see the changes.✨</i>")
				elseif success == 0 then
					send_large_msg(receiver, "<i>✨Failed to set SuperGroup username.✨\n✨Username may already be taken✨.\n\n✨Note: Username can use a-z, 0-9 and underscores.✨\n✨Minimum length is 5 characters.✨</i>")
				end
			end
			local username = string.gsub(matches[2], '@', '')
			channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
		end

		if matches[1] == 'تنظیم قوانین' and is_momod(msg) then
			rules = matches[2]
			local target = msg.to.id
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[2].."]")
			return set_rulesmod(msg, data, target)
		end

		if msg.media then
			if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_momod(msg) then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] set new SuperGroup photo")
				load_photo(msg.id, set_supergroup_photo, msg)
				return
			end
		end
		if matches[1] == 'تنظیم عکس' and is_momod(msg) then
			data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
			save_data(_config.moderation.data, data)
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] started setting new SuperGroup photo")
			return '<i>✨لطفا عکس جدید را برای من ارسال کنید✨</i>'
		end

		if matches[1] == 'پاک کردن' then
			if not is_momod(msg) then
				return
			end
			if not is_momod(msg) then
				return reply_msg(msg.id,"<i>✨تنها مالک میتواند پاک کند✨</i>", ok_cb,false)
			end
			if matches[2] == 'لیست مدیران' then
				if next(data[tostring(msg.to.id)]['moderators']) == nil then
					return reply_msg(msg.id,"<i>✨مدیری در این سوپر گروه وجود ندارد✨</i>", ok_cb,false)
				end
				for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
					data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
				return reply_msg(msg.id,"<i>✨لیست مدیران پاک شد✨</i>", ok_cb,false)
			end
			if matches[2] == 'لیست بن' and is_owner(msg) then
		    local chat_id = msg.to.id
            local hash = 'banned:'..chat_id
            local data_cat = 'banlist'
            data[tostring(msg.to.id)][data_cat] = nil
            save_data(_config.moderation.data, data)
            redis:del(hash)
			return reply_msg(msg.id,"<i>✨لیست بن ها پاک شد✨</i>",ok_cb, false)
			end
			if matches[2] == 'قوانین' then
				local data_cat = 'rules'
				if data[tostring(msg.to.id)][data_cat] == nil then
					return reply_msg(msg.id,"<i>✨هیچ قانونی ثبت نیست✨</i>", ok_cb,false)
				end
				data[tostring(msg.to.id)][data_cat] = nil
				save_data(_config.moderation.data, data)
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
				return reply_msg(msg.id,"<i>✨قوانین پاک شدند✨</i>", ok_cb,false)
			end
			if matches[2] == 'درباره' then
				local receiver = get_receiver(msg)
				local about_text = ' '
				local data_cat = 'description'
				if data[tostring(msg.to.id)][data_cat] == nil then
					return reply_msg(msg.id,"<i>✨درباره ای ثبت نیست✨</i>", ok_cb,false)
				end
				data[tostring(msg.to.id)][data_cat] = nil
				save_data(_config.moderation.data, data)
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
				channel_set_about(receiver, about_text, ok_cb, false)
				return reply_msg(msg.id,"<i>✨درباره حذف شد✨</i>", ok_cb,false)
			end
			if matches[2] == 'لیست خفه ها' then
				chat_id = msg.to.id
				local hash =  'mute_user:'..chat_id
					redis:del(hash)
				return reply_msg(msg.id,"<i>✨لیست ساکت شده ها پاک شد✨</i>", ok_cb,false)
			end
			if matches[2] == 'نام کاربری' and is_admin1(msg) then
				local function ok_username_cb (extra, success, result)
					local receiver = extra.receiver
					if success == 1 then
						send_large_msg(receiver, "<i>✨نام کاربری حذف شد✨</i>")
					elseif success == 0 then
						send_large_msg(receiver, "<i>✨ناتوان در پاک کردن نام✨</i>")
					end
				end
				local username = ""
				channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
			end
		    if matches[2] == "ربات ها" and is_momod(msg) then
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked all SuperGroup bots")
				channel_get_bots(receiver, callback_clean_bots, {msg = msg})
				return reply_msg(msg.id,"<i>✨تمام ربات ها حذف شدنداز ✨</i>" ..string.gsub(msg.to.print_name, "_", " "), ok_cb,false)
			end
			if matches[2] == 'لیست گولبال بن' and is_sudo then 
            local hash = 'gbanned'
                local data_cat = 'gbanlist'
                data[tostring(msg.to.id)][data_cat] = nil
                save_data(_config.moderation.data, data)
                redis:del(hash)
			return reply_msg(msg.id,"<i>✨لیست گلوبال بن پاک شد✨</i>", ok_cb,false)
		end
	end
		if matches[1] == 'قفل' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == 'لینک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link posting ")
				return lock_group_links(msg, data, target)
			end
			if matches[2] == 'اسپم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked spam ")
				return lock_group_spam(msg, data, target)
			end
			if matches[2] == 'حساسیت' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
				return lock_group_flood(msg, data, target)
			end
			if matches[2] == 'فارسی' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
				return lock_group_arabic(msg, data, target)
			end
			if matches[2] == 'تگ' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Tag ")
				return lock_group_tag(msg, data, target)
			end
			if matches[2] == 'وب لینک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked WebLink ")
				return lock_group_webpage(msg, data, target)
			end
			if matches[2] == 'فروارد' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Forward Msg ")
				return lock_group_fwd(msg, data, target)
			end
			if matches[2] == 'کلمات زشت' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Badwords ")
				return lock_group_badw(msg, data, target)
			end
			if matches[2] == 'شکلک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Emoji ")
				return lock_group_emoji(msg, data, target)
			end
			if matches[2] == 'انگلیسی' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked English ")
				return lock_group_eng(msg, data, target)
			end
			if matches[2] == 'اعضا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
				return lock_group_membermod(msg, data, target)
			end
			if matches[2]:lower() == 'راستچین' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked rtl chars. in names")
				return lock_group_rtl(msg, data, target)
			end
			if matches[2] == 'اعلان' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Tgservice Actions")
				return lock_group_tgservice(msg, data, target)
			end
			if matches[2] == 'استیکر' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker posting")
				return lock_group_sticker(msg, data, target)
			end
			if matches[2] == 'مخاطب' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact posting")
				return lock_group_contacts(msg, data, target)
			end
			if matches[2] == 'سختگیرانه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked enabled strict settings")
				return enable_strict_rules(msg, data, target)
			end
			if matches[2] == 'رسانه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked media posting")
				return lock_group_media(msg, data, target)
			end
			if matches[2] == 'اشتراک گذاری' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked share posting")
				return lock_group_share(msg, data, target)
			end
			if matches[2] == 'ربات' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots")
				return lock_group_bots(msg, data, target)
			end
			if matches[2] == 'شماره' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked number posting")
				return lock_group_number(msg, data, target)
			end
			if matches[2] == 'پوکر' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked poker posting")
				return lock_group_poker(msg, data, target)
			end
			if matches[2] == 'صدا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked voice posting")
				return lock_group_audio(msg, data, target)
			end
			if matches[2] == 'عکس' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked photo posting")
				return lock_group_photo(msg, data, target)
			end
			if matches[2] == 'فیلم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked video posting")
				return lock_group_video(msg, data, target)
			end
			if matches[2] == 'فایل' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked documents posting")
				return lock_group_documents(msg, data, target)
			end
			if matches[2] == 'متن' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked text posting")
				return lock_group_text(msg, data, target)
			end
			if matches[2] == 'همه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked all posting")
				return lock_group_all(msg, data, target)
			end
			if matches[2] == 'گیف' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked gifs posting")
				return lock_group_gifs(msg, data, target)
			end
			if matches[2] == 'اینلاین' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked inline posting")
				return lock_group_inline(msg, data, target)
			end
			if matches[2] == 'دستور' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked cmd posting")
				return lock_group_cmd(msg, data, target)
			end
		end
        if matches[1] == 'مانع' and is_momod(msg) then
		local target = msg.to.id
				if matches[2] == 'عکس' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked photo posting")
				return lock_group_photo(msg, data, target)
			end
				if matches[2] == 'فیلم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked video posting")
				return lock_group_video(msg, data, target)
			end
				if matches[2] == 'گیف' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked gif posting")
				return lock_group_gif(msg, data, target)
			end
				if matches[2] == 'صدا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked audio posting")
				return lock_group_audio(msg, data, target)
			end
				if matches[2] == 'فایل' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked document posting")
				return lock_group_document(msg, data, target)
			end
		end
		if matches[1] == 'بازکردن' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == 'لینک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link posting")
				return unlock_group_links(msg, data, target)
			end
			if matches[2] == 'اسپم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked spam")
				return unlock_group_spam(msg, data, target)
			end
			if matches[2] == 'حساسیت' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood")
				return unlock_group_flood(msg, data, target)
			end
			if matches[2] == 'فارسی' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Arabic")
				return unlock_group_arabic(msg, data, target)
			end
			if matches[2] == 'تگ' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Tag")
				return unlock_group_tag(msg, data, target)
			end
			if matches[2] == 'وب لینک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked WebLink")
				return unlock_group_webpage(msg, data, target)
			end
			if matches[2] == 'شکلک' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Emoji")
				return unlock_group_emoji(msg, data, target)
			end
			if matches[2] == 'انگلیسی' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked English")
				return unlock_group_eng(msg, data, target)
			end
			if matches[2] == 'فروارد' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Forward Msg")
				return unlock_group_fwd(msg, data, target)
			end
			if matches[2] == 'کلمات زشت' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Badwords")
				return unlock_group_badw(msg, data, target)
			end
			if matches[2] == 'عکس' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo")
				return unlock_group_photo(msg, data, target)
			end
			if matches[2] == 'اعضا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
				return unlock_group_membermod(msg, data, target)
			end
			if matches[2]:lower() == 'راستچین' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked RTL chars. in names")
				return unlock_group_rtl(msg, data, target)
			end
				if matches[2] == 'اعلان' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tgservice actions")
				return unlock_group_tgservice(msg, data, target)
			end
			if matches[2] == 'استیکر' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker posting")
				return unlock_group_sticker(msg, data, target)
			end
			if matches[2] == 'مخاطب' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact posting")
				return unlock_group_contacts(msg, data, target)
			end
			if matches[2] == 'سختگیرانه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled strict settings")
				return disable_strict_rules(msg, data, target)
			end
			if matches[2] == 'رسانه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact media")
				return unlock_group_media(msg, data, target)
			end
			if matches[2] == 'اشتراک گذاری' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked share posting")
				return unlock_group_share(msg, data, target)
			end
			if matches[2] == 'ربات' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked bots")
				return unlock_group_bots(msg, data, target)
			end
			if matches[2] == 'شماره' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked number posting")
				return unlock_group_number(msg, data, target)
			end
			if matches[2] == 'پوکر' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked poker posting")
				return unlock_group_poker(msg, data, target)
			end
			if matches[2] == 'صدا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked voice posting")
				return unlock_group_audio(msg, data, target)
			end
			if matches[2] == 'عکس' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo posting")
				return unlock_group_photo(msg, data, target)
			end
			if matches[2] == 'فیلم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked video posting")
				return unlock_group_video(msg, data, target)
			end
			if matches[2] == 'فایل' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked documents posting")
				return unlock_group_documents(msg, data, target)
			end
			if matches[2] == 'متن' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked text posting")
				return unlock_group_text(msg, data, target)
			end
			if matches[2] == 'همه' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked all posting")
				return unlock_group_all(msg, data, target)
			end
			if matches[2] == 'گیف' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked gifs posting")
				return unlock_group_gifs(msg, data, target)
			end
			if matches[2] == 'اینلاین' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked inline posting")
				return unlock_group_inline(msg, data, target)
			end
			if matches[2] == 'دستور' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked cmd posting")
				return unlock_group_cmd(msg, data, target)
			end
		end
		if matches[1] == 'حذف مانع' and is_momod(msg) then
			local target = msg.to.id
				if matches[2] == 'عکس' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo posting")
				return unlock_group_photo(msg, data, target)
		    end
				if matches[2] == 'فیلم' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked video posting")
				return unlock_group_video(msg, data, target)
		    end
				if matches[2] == 'گیف' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked gif posting")
				return unlock_group_gif(msg, data, target)
		    end
				if matches[2] == 'صدا' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked audio posting")
				return unlock_group_audio(msg, data, target)
		    end
			    if matches[2] == 'فایل' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked document posting")
				return unlock_group_document(msg, data, target)
		    end
		end
		if matches[1] == 'تنظیم حساسیت' then
			if not is_momod(msg) then
				return
			end
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 50 then
				return "<i>✨شماره اشتباه!عدد باید بین(5تا20)باشد✨</i>"
			end
			local flood_max = matches[2]
			data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
			return '<i>✨حساسیت تنظیم شد بر روی✨: </i>'..matches[2]
		end
		if matches[1] == 'عمومی' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == '🔐' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
				return set_public_membermod(msg, data, target)
			end
			if matches[2] == '🔓' then
				savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: not public")
				return unset_public_membermod(msg, data, target)
			end
		end

		if matches[1] == 'ممنوعیت' and is_momod(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨صدا ممنوع شد✨</i>"
				else
					return "<i>✨صدا از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨عکس ممنوع شد✨</i>"
				else 
					return "<i>✨عکس از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨فیلم ممنوع شد✨</i>"
				else
					return "<i>✨فیلم از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨گیف ممنوع شد✨</i>"
				else
					return "<i>✨گیف از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨فایل ممنوع شد✨</i>"
				else
					return "<i>✨فایل از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨متن ممنوع شد✨</i>"
				else
					return "<i>✨متن از قبل ممنوع است✨</i>"
				end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<i>✨همه چی ممنوع شد✨</i>"
				else
					return "<i>✨همه چی از قبل ممنوع است✨</i>"
				end
			end
		end
		if matches[1] == 'حذف ممنوعیت' and is_momod(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨صدا ازاد شد✨<i>"
				else
					return "<i>✨صدا از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨عکس ازاد شد✨<i>"
				else
					return "<i>✨عکس از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨فیلم ازاد شد✨</i>"
				else
					return "<i>✨فیلم از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨گیف ازاد شد✨</i>"
				else
					return "<i>✨گیف از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨فایل ازاد شد✨</i>"
				else
					return "<i>✨فایل از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute message")
					unmute(chat_id, msg_type)
					return "<i>✨متن ازاد شد✨</i>"
				else
					return "<i>✨متن از قبل ازاد است✨</i>"
				end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<i>✨همه چی ازاد شد✨</i>"
				else
					return "<i>✨همه چی از قبل ازاد است✨</i>"
				end
			end
		end


		if matches[1] == "خفه کردن" and is_momod(msg) then
			local chat_id = msg.to.id
			local hash = "mute_user"..chat_id
			local user_id = ""
			if type(msg.reply_id) ~= "nil" then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				muteuser = get_message(msg.reply_id, get_message_callback, {receiver = receiver, get_cmd = get_cmd, msg = msg})
			elseif matches[1] == "خفه کردن" and string.match(matches[2], '^%d+$') then
				local user_id = matches[2]
				if is_muted_user(chat_id, user_id) then
					unmute_user(chat_id, user_id)
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed ["..user_id.."] from the muted users list")
					return "<b>✨["..user_id.."]["..username.."] </b><i>از لیست ساکت شده ها خارج شد✨</i>"
				elseif is_momod(msg) then
					mute_user(chat_id, user_id)
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."] to the muted users list")
					return reply_msg(msg.id,"<b>✨["..user_id.."]["..username.."]</b><i> ساکت شد✨</i>",ok_cb,false)
				end
			elseif matches[1] == "خفه کردن" and not string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				resolve_username(username, callbackres, {receiver = receiver, get_cmd = get_cmd, msg=msg})
			end
		end

		if matches[1] == "لیست ممنوعیت" and is_momod(msg) then
			local chat_id = msg.to.id
			if not has_mutes(chat_id) then
				set_mutes(chat_id)
				return mutes_list(chat_id)
			end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup muteslist")
			return mutes_list(chat_id)
		end
		if matches[1] == "لیست خفه ها" and is_momod(msg) then
			local chat_id = msg.to.id
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup mutelist")
			return muted_user_list(chat_id)
		end

		if matches[1] == 'تنظیمات' and is_momod(msg) then
			local target = msg.to.id
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup settings ")
			return show_supergroup_settingsmod(msg, target)
		end

		if matches[1] == 'قوانین' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
			return get_rules(msg, data)
		end

		if matches[1] == '/help' and not is_momod(msg) then
                        text = ""
			reply_msg(msg.id, text, ok_cb, false)
		elseif matches[1] == 'help' and is_momod(msg) then
                        text = ""
			reply_msg(msg.id, text, ok_cb, false)
		end
		
	if matches[1] == 'superhelp' and is_momod(msg) then
                       text = ""
                       reply_msg(msg.id, text, ok_cb, false)
	end
	if matches[1] == 'superhelp' and msg.to.type == "user" then
			text = ""
			reply_msg(msg.id, text, ok_cb, false)
	end

		if matches[1] == 'peer_id' and is_admin1(msg)then
			text = msg.to.peer_id
			reply_msg(msg.id, text, ok_cb, false)
			post_large_msg(receiver, text)
		end

		if matches[1] == 'msg.to.id' and is_admin1(msg) then
			text = msg.to.id
			reply_msg(msg.id, text, ok_cb, false)
			post_large_msg(receiver, text)
		end

		--Admin Join Service Message
		if msg.service then
		local action = msg.action.type
			if action == 'chat_add_user_link' then
				if is_owner2(msg.from.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.from.id
					savelog(msg.to.id, name_log.." Admin ["..msg.from.id.."] joined the SuperGroup via link")
					channel_set_admin(receiver, user, ok_cb, false)
				end
				if is_support(msg.from.id) and not is_owner2(msg.from.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.from.id
					savelog(msg.to.id, name_log.." Support member ["..msg.from.id.."] joined the SuperGroup")
					channel_set_mod(receiver, user, ok_cb, false)
				end
			end
			if action == 'chat_add_user' then
				if is_owner2(msg.action.user.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.action.user.id
					savelog(msg.to.id, name_log.." Admin ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
					channel_set_admin(receiver, user, ok_cb, false)
				end
				if is_support(msg.action.user.id) and not is_owner2(msg.action.user.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.action.user.id
					savelog(msg.to.id, name_log.." Support member ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
					channel_set_mod(receiver, user, ok_cb, false)
				end
			end
		end
		if matches[1] == 'msg.to.peer_id' then
			post_large_msg(receiver, msg.to.peer_id)
		end
	end
end

local function pre_process(msg)
  if not msg.text and msg.media then
    msg.text = '['..msg.media.type..']'
  end
  return msg
end

return {
  patterns = {
	"^(اضافه)$",
	"^(حذف گروه)$",
	"^(انتقال) (.*)$",
	"^(اطلاعات)$",
	"^(ادمین ها)$",
	"^(مالک)$",
	"^(لیست مدیران)$",
	"^(ربات ها)$",
	"^(افراد)$",
	"^(اخراج شده)$",
    "^(اخراج) (.*)",
	"^(اخراج)",
	"^(تبدیل به سوپرگروه)$",
	"^(ایدی)$",
	"^(ایدی) (.*)$",
	"^(اخراجم کن)$",
	"^(اخراج) (.*)$",
	"^(لینک جدید)$",
	"^(تنظیم لینک)$",
	"^(لینک)$",
	"^(اطلاعات) (.*)$",
	"^(تنظیم ادمین) (.*)$",
	"^(تنظیم ادمین)",
	"^(عزل ادمین) (.*)$",
	"^(عزل ادمین)",
	"^(تنظیم مالک) (.*)$",
	"^(تنظیم مالک)$",
	"^(ارتقا) (.*)$",
	"^(ارتقا)",
	"^(عزل) (.*)$",
	"^(عزل)",
	"^(تنظیم نام) (.*)$",
	"^(تنظیم درباره) (.*)$",
	"^(تنظیم قوانین) (.*)$",
	"^(تنظیم عکس)$",
	"^(تنظیم نام کاربری) (.*)$",
	"^(حذف)$",
	"^(قفل) (.*)$",
	"^(بازکردن) (.*)$",
	"^(ممنوعیت) ([^%s]+)$",
	"^(حذف ممنوعیت) ([^%s]+)$",
	"^(خفه کردن)$",
	"^(خفه کردن) (.*)$",
	"^(عمومی) (.*)$",
	"^(تنظیمات)$",
	"^(قوانین)$",
	"^(تنظیم حساسیت) (%d+)$",
	"^(پاک کردن) (.*)$",
	"^(لیست ممنوعیت)$",
	"^(لیست خفه ها)$",
    "^([https?://w]*.?telegram.me/joinchat/%S+)$",
	"msg.to.peer_id",
	"%[(document)%]",
	"%[(photo)%]",
	"%[(video)%]",
	"%[(audio)%]",
	"%[(contact)%]",
	"^!!tgservice (.+)$",
  },
  run = run,
  pre_process = pre_process
}
--Persian Supergroup Debuged..Translate and New Changes:Pouya Poorrahman
