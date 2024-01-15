#!/usr/bin/env lua5.4

--[[
--	mailscripts
--	ms-fetch-thread
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2023 Yao Zi. All rights reserved.
--]]

--[[
--	cURL and gzip is required.
--]]

local io			= require "io";
local string			= require "string";
local os			= require "os";

local mailboxAPI <const> = "https://lore.kernel.org/all/"
local function
mboxURL(id)
	return ("%s%s/t.mbox.gz"):format(mailboxAPI, id);
end

if #arg ~= 1 and #arg ~= 2
then
	io.stderr:write(("%s usage:\n\tID [file]\n"):format(arg[0]));
	os.exit(-1);
end

local output = #arg == 2 and assert(io.open(arg[2], "w")) or io.stdout;
local mbox = io.popen(("curl -L %s | gzip -d"):
		      format(mboxURL(arg[1]))):read("a");
output:write(mbox);
output:close();
