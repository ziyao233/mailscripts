--[[
--	mailscripts
--	ms-recv
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

getFrom = function(mail)
	local id = string.match(mail,[[From:%s*(.->)]]);
	return id,string.match(id,[[<(.-)>]]);
end
getDate = function(mail)
	local date = string.match(mail,"Date:%s(.-)[%+%-]");
	return string.match(date,"%d%d %a%a%a %d%d%d%d %d%d:%d%d:%d%d");
end
getMail = function()
	local pipe = io.popen(("curl -s --user %s %s/1"):format(user,url),"r");
	local mail = pipe:read("a");
	pipe:close();
	return mail;
end
strip = function(s)
	return string.gsub(s,"%W","_");
end
deleteMail = function()
	os.execute(("curl --request DELE -l -s --user %s %s/1"):format(user,url));
	return;
end

for i = 1,count
do
	local mail		= getMail();
	local id,addr		= getFrom(mail);
	local date		= getDate(mail);
	print(addr .. ":\t" .. date);
	local file		= io.open(strip(addr) .. "_" ..
					  strip(date),"w");
	file:write(mail);
	file:close();
	deleteMail();
end
