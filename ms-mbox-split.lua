#!/usr/bin/env lua5.4

--[[
--	mailscripts
--	ms-mbox-split
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2023-2024 Yao Zi. All rights reserved.
--]]

local io		= require "io";
local string		= require "string";
local os		= require "os";

local ms		= require "ms-common";

local function
allMessages(mbox)
	-- Pattern: From xxx@xxx Wed Jun 30 21:49:08 1993\n
	local fromLine = "From .- %d+ %d+:%d+:%d+ %d%d%d%d";
	local t = mbox:gsub(("%s\n"):format(fromLine, fromLine), "\1\1");
	return t:gmatch("\1([^\1]+)\1");
end

local function
checkExist(path)
	return io.open(path);
end

if #arg ~= 1 and #arg ~= 0
then
	io.stderr:write(("%s usage:\n\t%s [mbox]"):format(arg[0], arg[0]));
	os.exit(-1);
end

local input = #arg == 0 and io.stdin or assert(io.open(arg[1]));
local mbox = input:read("a");

-- Trick: Prepend two '\n' to generalize the first message in mbox
-- 	  Append a header to generalize the last message
mbox = "\n\n" .. mbox .. "\nFrom xxx@xxx Wed Jun 30 21:49:08 1993\n";

local count, conflict = 0, 0;
for mail in allMessages(mbox)
do
	local p = ms.strip(ms.getID(mail)) .. ".mail";
	print("name: " .. tostring(p));

	if checkExist(p)
	then
		print "\talready exists";
		conflict = conflict + 1;
	end

	local f = assert(io.open(p, "w"));
	f:write(mail);
	f:close()
	count = count + 1;
end

print(("%d messages in total"):format(count));
print(("%d messages already exist (or conflict Message-ID?)"):format(conflict));
