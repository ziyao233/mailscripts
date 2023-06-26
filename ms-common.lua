--[[
--	mailscripts
--	ms-common.lua
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2023 Yao Zi. All rights reserved.
--]]

--[[
--	This file contains some commonm functions used by different scripts.
--]]

local function
getFrom(mail)
	local id = string.match(mail, [[From:%s*(.->)]]);
	return id,string.match(id, [[<(.-)>]]);
end

local function
getDate(mail)
	local date = string.match(mail, "Date:%s*([^\n]-)[%+%-]%d%d%d%d");
	return string.match(date, "%d+ %a%a%a %d%d%d%d %d+:%d+:%d+");
end

local function
strip(s)
	return string.gsub(s, "%W", "_");
end

local function
filename(mail)
	local _, addr	= getFrom(mail);
	local date	= getDate(mail);
	return ("%s_%s.mail"):format(strip(addr), strip(date));
end

return {
	getFrom		= getFrom,
	getDate		= getDate,
	strip		= strip,
	filename	= filename,
       }
