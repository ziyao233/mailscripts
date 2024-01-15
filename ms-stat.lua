#!/usr/bin/env lua5.4

--[[
--	mailscripts
--	ms-stat
--	curl is required
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2022-2024 Ziyao. All rights reserved.
--]]

conf	= assert(loadfile(os.getenv("HOME") .. "/.msrc.lua"))();
pop3	= conf.pop3;

user	= ("%s:%s"):format(pop3.user, pop3.password);
url	= ("%s://%s"):format(pop3.tls and "pop3s" or "pop3", pop3.server);
pipe	= io.popen(("curl -s --user %s %s -v"):format(user,url),"r");
output = pipe:read("a");
count = 0;
for _ in string.gmatch(output,"\n")
do
	count = count + 1;
end

print("Message Number: " .. count);
pipe:close();
