--[[
--	mailscripts
--	ms-stat
--	curl is required
--	By MIT License.
--	Copyright (c) 2022 Ziyao.
--]]

assert(arg[1] and arg[2],"Usage: " .. arg[0] .. " TO_ADDRESS File");

conf	= assert(loadfile(os.getenv("HOME") .. "/.msrc.lua"))();
smtp	= conf.smtp;

user	= ("%s:%s"):format(smtp.user,smtp.password);
url	= ("%s://%s"):format(smtp.tls and "smtp" or "smtps",smtp.server);
os.execute(("curl --mail-from %s --mail-rcpt %s -s --user %s %s " ..
	   "--upload-file %s"):
	   format(smtp.from,arg[1],user,url,arg[2]));
