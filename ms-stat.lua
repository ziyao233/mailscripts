--[[
--	mailscripts
--	ms-stat
--	curl is required
--	By MIT License.
--	Copyright (c) 2022 Ziyao.
--]]

conf	= assert(loadfile(os.getenv("HOME") .. "/.msrc.lua"))();
pop3	= conf.pop3;

user	= ("%s:%s"):format(pop3.user,pop3.password);
url	= ("%s://%s"):format(pop3.tls and "pop3" or "pop3s",pop3.server);
pipe	= io.popen(("curl -s --user %s %s"):format(user,url),"r");
output = pipe:read("a");
count = 0;
for _ in string.gmatch(output,"\n")
do
	count = count + 1;
end

print("Message Number: " .. count);
pipe:close();
