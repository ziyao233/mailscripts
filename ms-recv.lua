#!/usr/bin/env lua

--[[
--	mailscripts
--	ms-recv
--	curl is required
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2022-2023 Ziyao.
--]]

local ms		= require "ms-common"

conf	= assert(loadfile(os.getenv("HOME") .. "/.msrc.lua"))();
pop3	= conf.pop3;

user	= ("%s:%s"):format(pop3.user, pop3.password);
url	= ("%s://%s"):format(pop3.tls and "pop3" or "pop3s", pop3.server);
pipe	= io.popen(("curl -s --user %s %s"):format(user,url), "r");
output = pipe:read("a");
count = 0;
for _ in string.gmatch(output,"\n")
do
	count = count + 1;
end

print("Message Number: " .. count);
pipe:close();

getMail = function()
	local pipe = io.popen(("curl -s --user %s %s/1"):format(user, url),"r");
	local mail = pipe:read("a");
	pipe:close();
	return mail;
end

deleteMail = function()
	os.execute(("curl --request DELE -l -s --user %s %s/1"):
		   format(user, url));
	return;
end

for i = 1, count
do
	local mail		= getMail();
	local id,addr		= ms.getFrom(mail);
	local date		= ms.getDate(mail);
	print(addr .. ":\t" .. date);
	local file		= io.open(ms.filename(mail), "w");
	file:write(mail);
	file:close();
	deleteMail();
end
