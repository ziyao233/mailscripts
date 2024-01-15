#!/usr/bin/env lua5.4

--[[
--	mailscripts
--	ms-info
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2024 Yao Zi. All rights reserved.
--]]

local io		= require "io";
local string		= require "string";
local os		= require "os";

local ms		= require "ms-common";

local items <const>	= {
				date	= ms.getDate,
				from	= function(m)
						local _, addr = ms.getFrom(m);
						return addr;
					  end,
			  };

if #arg < 2
then
	io.stderr:write("Usage:\n\tms-info <MAILFILE> <ITEM> [ITEM] ...\n");
	os.exit(-1);
end

local mail = (arg[1] == "-" and io.stdin or
				assert(io.open(arg[1], "r"))):read("a");

for i = 2, #arg
do
	local handler = items[arg[i]];

	if not handler
	then
		io.stderr:write(("Unknown item %s\n"):format(arg[i]));
		os.exit(-1);
	else
		print(("%s: %s"):format(arg[i], handler(mail)));
	end
end
