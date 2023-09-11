#!/usr/bin/env lua

--[[
--	mailscripts
--	ms-send
--	curl is required
--	By Mozilla Public License Version 2.0
--	Copyright (c) 2022-2023 Ziyao. All rights reserved.
--]]

assert(arg[1] and arg[2],"Usage: " .. arg[0] .. " TO_ADDRESS File");

conf	= assert(loadfile(os.getenv("HOME") .. "/.msrc.lua"))();
smtp	= conf.smtp;

user	= ("%s:%s"):format(smtp.user, smtp.password);
url	= ("%s://%s"):format(smtp.tls and "smtps" or "smtp", smtp.server);

cmd = ("curl %s --user %s --mail-from %s --mail-rcpt %s --upload-file %s -v -s"):
      format(url, user, smtp.from, arg[1], arg[2]);
os.execute(cmd);
