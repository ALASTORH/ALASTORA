redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./serpent.lua") 
json = dofile("./JSON.lua") 
JSON  = dofile("./dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT ¦ awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua MARCOS.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua MARCOS.lua')
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua MARCOS.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("MARCOS", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/MARCOS
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./MARCOS.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("MA", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/MARCOS
while(true) do
rm -fr ../.telegram-cli
screen -S MARCOS -X kill
screen -S MARCOS ./MARCOS
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[
⇓⇓⇓⇓⇓⇓⇓⇓
DEV ➲ @AST0RH
CH ➠ @ASTORHBOTS
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf games.lua.1") 
io.popen("cd File_Bot && rm -rf games.lua.2") 
io.popen("cd File_Bot && rm -rf games.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/ALASTORH/Files_ALASTORA/master/games.lua") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,879123322}
function SudoBot(msg)  
local MARCOS = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
MARCOS = true  
end  
end  
return MARCOS  
end 
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Bot(msg)  then
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or Bot(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."VVVZVV:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function wzeer(msg)
local hash = database:sismember(bot_id.."WZ:EE:R"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(879123322) then  
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'VVVZVV:MN:TF'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'WZ:EE:R'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 

function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(879123322) then  
var = 'مطور السورس👨‍🔧'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي👨‍💻'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت🤖'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور👩‍🚒'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ الاساسي👩‍🚀'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ👨‍✈️'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير👮‍♂️'  
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن👷‍♂️'  
elseif database:sismember(bot_id..'VVVZVV:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'WZ:EE:R'..chat_id, user_id) then
var = 'وزيـر🤴' 
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز👨‍🎓'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو👶'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token 
local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)
if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown&disable_web_page_preview=true" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Total_Msg(msgs)  
local MARCOS_Msg = ''  
if msgs < 100 then 
MARCOS_Msg = 'مـبـتـدئ😔💔' 
elseif msgs < 200 then 
MARCOS_Msg = 'ضـعـيـف😔💔' 
elseif msgs < 1000 then 
MARCOS_Msg = 'مـتـوسـط🙂💔' 
elseif msgs < 2000 then 
MARCOS_Msg = 'متفاعل😍🙊' 
elseif msgs < 3000 then 
MARCOS_Msg = 'كفووووو😍✔️' 
elseif msgs < 4000 then 
MARCOS_Msg = 'متفاعل جدا😍💘' 
elseif msgs < 5000 then 
MARCOS_Msg = 'اقوى تفاعل🙊👻'  
elseif msgs < 6000 then 
MARCOS_Msg = 'متفاعل نار😍🔥' 
elseif msgs < 7000 then 
MARCOS_Msg = 'قمة التفاعل🤸‍♂️😻' 
elseif msgs < 8000 then 
MARCOS_Msg = 'اســطوري😳😻' 
elseif msgs < 10000 then 
MARCOS_Msg = 'ملك التفاعل🤴😍' 
elseif msgs < 15000 then 
MARCOS_Msg = 'امبراطور التفاعل💂‍♀️😻' 
elseif msgs < 10000000000 then 
MARCOS_Msg = 'جنرال التفاعل✔️😍'  
end 
return MARCOS_Msg 
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'MARCOS Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"MARCOS":"'..NAME..'",'
else
t = t..',"'..v..'":{"MARCOS":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '📋¦ عدد مجموعات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"🎼┇سورس الاسطورة")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"🔖| ملف النسخه الاحتياطيه ليس لهاذا البوت")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_,"🔘| جاري ...\n🎗️| رفع الملف الان")
else
send(chat,msg.id_,"*📌| عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n🔰|تم رفع الملف بنجاح وتفعيل المجموعات\n⚡| ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")   
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n📮| العضــو » '..Name..'\n🔘| قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n📮| العضــو » '..Name..'\n🔘| قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n📮| العضــو » '..Name..'\n🔘| قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_Poyka(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.Poyka and msg then
pre_msg = plugin.Poyka(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end
--------------------------------------------------------------------------------------------------------------
function SourceMARCOS(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_, msg.id_,"📫┇تم الغاء الاذاعه") 
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_,"📮┇تمت الاذاعه الى *~ "..#list.." ~* مجموعه ")     
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if SudoBot(msg) then
local bl = '⚜️| اهلا عزيزي آلمـطـور\n👨‍💻| آنت آلمـطـور آلآسـآسـي للبوت\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●ء\n🔘| تسـتطـيع‌‏ آلتحگم باوامر البوت\n🔰| من خلاال الكيبورد خاص بك\n📮| قناة سورس البوت [اضغط هنا](t.me/LSLHB)'
local keyboard = {
{'الاحصائيات 🔍'},
{'تعطيل التواصل ✖️','تفعيل التواصل 🔛'},
{'ضع اسم للبوت ®','المطورين 👷‍♂️'},
{'قائمه العام 📝','قائمه الكتم العام ❃'},
{'ضع كليشه ستارت 📃','حذف كليشه ستارت ♻️'},
{'اذاعه قروبات👥','اذاعه خاص 🗣️','معلومات الكيبورد 💬'},
{'تغير رساله الاشتراك','حذف رساله الاشتراك 🚫','تغير الاشتراك'},
{'اذاعه بالتوجيه 🔖','اذاعه بالتوجيه خاص 📯'},
{'اذاعه بالتثبيت'},
{'اضف نصيحه ➕','حذف النصائح 🗑'},
{'اضف مقالات ➕','حذف المقالات 🗑'},
{'اضف صراحة ➕','حذف الصراحة 🗑'},
{'اضف نكت ➕','حذف النكت 🗑'},
{'تفعيل الاشتراك الاجباري 📥','تعطيل الاشتراك الاجباري 📤'},
{'الاشتراك الاجباري 🚸','تفعيل الاشتراك الاول🌟'},
{'تفعيل البوت الخدمي 🔓','تعطيل البوت الخدمي🔏'},
{'تنظيف القروبات 🗑️','تنظيف المشتركين 🗑️'},
{'جلب نسخه احتياطيه 📂','الاصدار 📟'},
{'تحديث السورس ™','معلومات السيرفر 📊'},
{'الغاء ✖'}
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceMARCOSr = start
else
SourceMARCOSr = '🔖| اهلا عزيزي\n📮| انا بوت حماية المجموعات\n⚡| اختصاصي حمايه المجموعات\n✨| من تكرار والسبام والتوجيه والخ.؟\n🚸| لتفعيلي اتبع الاخطوات…↓\n⚠️| اضفني الي مجموعتك وقم بترقيتي ادمن واكتب كلمه { تفعيل }  ويستطيع »{ منشئ او المشرفين } بتفعيل فقط'
end 
send(msg.chat_id_, msg.id_, SourceMARCOSr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not SudoBot(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.sender_user_id_, msg.id_,'☑️| تم ارسال رسالتك\n🔖| سيتم رد في اقرب وقت')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '📥| تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if SudoBot(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔘|تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔘| تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local MARCOS_Msg = '\n⚠| فشل ارسال رسالتك لان العضو قام بحظر البوت'
send(msg.chat_id_, msg.id_,MARCOS_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔖|تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔖| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then   
 if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔖| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔖| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌| المستخدم » '..Name..'\n🔖| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل التواصل 🔛' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n🔘| تم تفعيل التواصل ' 
else
Text = '\n⚠️| بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ✖️' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n🔘| تم تعطيل التواصل' 
else
Text = '\n⚠️| بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي 🔓' and SudoBot(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n🔘| تم تفعيل البوت الخدمي ' 
else
Text = '\n⚠️| بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي 🔏' and SudoBot(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n🔘| تم تعطيل البوت الخدمي' 
else
Text = '\n⚠️| بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,'🔘| الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'📝| تم حفظ كليشه ستارت') 
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت 📃' and SudoBot(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'📑| ارسل لي الكليشه الان') 
return false
end
if text == 'حذف كليشه ستارت ♻️' and SudoBot(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'🔖|تم حذف كليشه ستارت') 
end
if text == 'الاصدار 📟' and SudoBot(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,'*📡| اصدار سورس الاسطورة \n📟| الاصدار ←{ 1.3v}*') 
end
if text == 'معلومات السيرفر 📊' and SudoBot(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖•\n*»» '"$linux_version"'*' 
echo '*———————————~*\n✺✔{ الذاكره العشوائيه } ⇎\n*»» '"$memUsedPrc"'*'
echo '*———————————~*\n✺✔{ وحـده الـتـخـزيـن } ⇎\n*»» '"$HardDisk"'*'
echo '*———————————~*\n✺✔{ الـمــعــالــج } ⇎\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*———————————~*\n✺✔{ الــدخــول } ⇎\n*»» '`whoami`'*'
echo '*———————————~*\n✺✔{ مـده تـشغيـل الـسـيـرفـر }⇎\n*»» '"$uptime"'*'
]]):read('*all'))  
end

if text == "اضف مقالات ➕" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل المقاله الان")
end
if text == "حذف المقالات 🗑" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:del(bot_id.."makal:bots")
return send(msg.chat_id_, msg.id_,"تم حذف المقالات")
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ المقالات بنجاح')
database:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
database:sadd(bot_id.."makal:bots", text)
return false end
end
if text == "اضف نصيحه ➕" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:set(bot_id.."nsih:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل النصيحه الان")
end
if text == "حذف النصائح 🗑" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:del(bot_id.."nsih:bots")
return send(msg.chat_id_, msg.id_,"تم حذف النصائح")
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."nsih:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ النصيحه بنجاح')
database:set(bot_id.."nsih:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
database:sadd(bot_id.."nsih:bots", text)
return false end
end
if text == "اضف صراحة ➕" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:set(bot_id.."srah:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل سوال الصراحة")
end
if text == "حذف الصراحة 🗑" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:del(bot_id.."srah:bots")
return send(msg.chat_id_, msg.id_,"تم حذف اسئلة الصراحة")
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."srah:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ سوال الصراحة')
database:set(bot_id.."srah:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
database:sadd(bot_id.."srah:bots", text)
return false end
end
if text == "اضف نكت ➕" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:set(bot_id.."nkth:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل النكته الان 😛")
end
if text == "حذف النكت 🗑" then
if not SudoBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمطور الاساسي فقط')
return false
end
database:del(bot_id.."nkth:bots")
return send(msg.chat_id_, msg.id_,"تم حذف النكت بنجاح 😔")
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."nkth:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ النكته بنجاح 😍')
database:set(bot_id.."nkth:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
database:sadd(bot_id.."nkth:bots", text)
return false end
end
if text == 'معلومات الكيبورد 💬' and SudoBot(msg) then 
database:del(bot_id..'Sart:Bot') 
send(msg.chat_id_, msg.id_,'📮| اهلا عزيزى مطور اساسي \n🔰| معلومات كتالي↓\n1• الاحصائيات { لعرض عدد القروبات، والمشتركين في البوت }\n2• تفعيل التواصل { لتفعيل التواصل عبر البوت خاص بك}\n3• تعطيل التواصل { لتعطيل التواصل عبر البوت خاص بك }\n4• قائمه العام { لعرض المحظورين عام في البوت }\n5• المطورين { لعرض المطورين في بوتك } \n6• ضع اسم للبوت { لختيار اسم لبوت خاص بك }\n7• حذف كليشه ستارت { حذف كليشه عندما يضغط العضو علي كلمه /start }\n8• ضع كليشه ستارت { لختيار كلايشه /start جديدة }\n9• اذاعه { ارسال رساله لجميع القروبات في بوتك }\n10• اذاعه خاص { ارسال رساله لجميع مشتركين بوتك!}\n11• تعطيل الاشتراك الاجباري { لتعطيل الاشتراك جباري خاص بوتك}\n12• تفعيل الاشتراك الاجباري { لتفعيل الاشتراك الاجباري بوتك }\n13•اذاعه بالتوجيه { ارسال رساله بالتوجيه الي جميع القروبات }\n14• اذاعه بالتوجيه خاص { ارسال رساله بالتوجيه الي جميع المشتركين }\n15• حذف رساله الاشتراك { لحذف رساله الاشتراك التي اضفتها }\n16• تغير رساله الاشتراك { لتغير رساله الاشتراك خاصه بوتك وتختار غيرها }\n17• تغير الاشتراك {لتغير الاشتراك الاجباري خاص بوتك واضافت قناة غيرها }\n18• تفعيل الاشتراك الاول { لتفعيل الاشتراك جباري عندما تفعيل البوت اول مَـرّھٌ }\n19• الاشتراك الاجباري { لظهار القناة مفعل الاشتراك عليها }\n20• تفعيل البوت الخدمي { يمكن هاذا امر ان منشئ القروب يفعل البوت م̷ـــِْن دون حتياجه لمطور البوت\n21• تعطيل البوت الخدمي { يمك هل خاصيه ان تفعيل البوت اله مطورين البوت فقط }\n22• تنظيف المشتركين { يمكنك ازاله المشتركين الوهمين عبر هل امر }\n23• تنظيف القروبات { يمكن ازاله المجموعات الوهميه عبر عل امر }\n24• جلب نسخه احتياطيه { لعرض ملف المجموعات بوتك }\n25• تحديث السورس { لتحديث السورس خاص بوتك }\n26• الغاء { للغاء الامر الذي طلبته }\n===ء====================\n🔰| اوامر كيبورد المطور االاساسي معا شرح\n📮| قناة السورس [ضغط هنا](t.me/LSLHB) \n💬| مطور السورس [اضغط هنا](t.me/AST0RH)') 
end
if text == 'تحديث السورس ™' and SudoBot(msg) then 
os.execute('rm -rf MARCOS.lua')
os.execute('wget https://raw.githubusercontent.com/ALASTORH/ALASTORA/master/MARCOS.lua')
send(msg.chat_id_, msg.id_,'*🔭| تم تحديث البوت \n📮| لديك اخر اصدار سورس الاسطورة\n📡| الاصدار ← {1.3v}*')
dofile('MARCOS.lua')  
end
if text == "ضع اسم للبوت ®" and SudoBot(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"📫¦ ارسل لي الاسم الان ")  
return false
end
if text == 'الاحصائيات 🔍' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '🔰| احصائيات البوت \n'..'👥|عدد المجموعات »{'..Groups..'}'..'\n👤| عدد المشتركين »{'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين 👷‍♂️") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n📑| قائمة مطورين البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖| لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("قائمه العام 📝") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n⛔¦ قائمة المحظورين عام \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖¦ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("قائمه الكتم العام ❃") and SudoBot(msg) then
local list = database:smembers(bot_id..'Gmute:User')
t = "\n⚠️| قائمة المكتومين عام \n≪━━━━━ÃŜŤÕŘȞ━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص 🗣️" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥¦ ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n📫¦ للخروج ارسل الغاء ") 
return false
end 
if text=="اذاعه قروبات👥" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥¦ ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n📫¦ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه 🔖" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥| ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص 📯" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥| ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي سواء ~ { ملصق, متحركه, صوره, رساله }\n📫┇للخروج ارسل الغاء ") 
return false
end 
if text == 'جلب نسخه احتياطيه 📂' and SudoBot(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين 🗑️" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'📌¦ عدد المشتركين الان » ( '..#pv..' )\n📬¦ تم ازالة » ( '..sendok..' ) من المشتركين\n📥¦ الان عدد المشتركين الحقيقي » ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف القروبات 🗑️" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'📮| لا يوجد مجموعات وهميه في البوت\n')   
else
local MARCOS = (w + q)
local sendok = #group - MARCOS
if q == 0 then
MARCOS = ''
else
MARCOS = '\n📛| تم ازالة » { '..q..' } مجموعات من البوت'
end
if w == 0 then
MARCOSk = ''
else
MARCOSk = '\n💠| تم ازالة » {'..w..'} مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'📌¦ عدد المجموعات الان » { '..#group..' }'..MARCOSk..''..MARCOS..'\n*📌| الان عدد المجموعات الحقيقي » { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = '⚠¦ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥¦ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌¦ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n??| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤|العضو » '..userid..''
status  = '\n🔘| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⚠️| تم الغاء حفظ اسم البوت") 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, "🔘| تم حفظ اسم البوت")  
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"🚸| تم الغاء الاذاعه للخاص") 
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"📌¦ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"🔘| تم الغاء الاذاعه") 
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"📌¦ تمت الاذاعه الى >>{"..#list.."} مجموعه في البوت ")     
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⚠️| تم الغاء الاذاعه") 
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"📮¦ تمت الاذاعه الى >>{"..#list.."} مجموعات في البوت ")     
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"📫| تم الغاء الاذاعه") 
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"📮¦ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "📬| تم الغاء الامر ") 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '📮| المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '⚡| عذا لا يمكنك وضع معرف حسابات في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'📮| عذا لا يمكنك وضع معرف مجوعه في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'📮| البوت ادمن في القناة \n🚸| تم تفعيل الاشتراك الاجباري في \n🔘| ايدي القناة ('..data.id_..')\n🔖| معرف القناة ([@'..data.type_.channel_.username_..'])') 
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'📮| البوت ليس ادمن في القناة يرجى ترقيته ادمن ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "📬| تم الغاء الامر ") 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'📮| تم تغيير رسالة الاشتراك بنجاح ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink"  or msg.content_.ID == "MessageChatAddMembers" then 
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'⚠| عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'⚠|… ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقا') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'📮| تم تغيير صورة المجموعه') 
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"📫| تم الغاء وضع الوصف") 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'📮| تم تغيير وصف المجموعه')   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"📫| تم الغاء حفظ الترحيب") 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'📮| تم حفظ ترحيب المجموعه')   
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"⚠️| تم الغاء حفظ الرابط")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"📥| تم حفظ الرابط بنجاح")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if MARCOS_Msg and not Special(msg) then  
local MARCOS_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if MARCOS_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠¦العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n📛¦["..MARCOS_Msg.."] \n") 
else
send(msg.chat_id_,0,"⚠¦العضو : {["..data.first_name_.."](T.ME/ASTORHBOTS)}\n📛¦["..MARCOS_Msg.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end 
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Manager(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","ك","ختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Manager(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Manager(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "⚠|عذرا يا » {[@"..data.username_.."]}\n⚠️|  الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
else
send(msg.chat_id_,0, "⚠|عذرا يا » {["..data.first_name_.."](T.ME/ASTORHBOTS)}\n📮| الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠|عذرا يا » {[@"..data.username_.."]}\n📮| الصوره التي ارسلتها تم منعها من المجموعه \n" ) 
else
send(msg.chat_id_,0,"⚠|عذرا يا » {["..data.first_name_.."](T.ME/ASTORHBOTS)}\n📮| الصوره التي ارسلتها تم منعها من المجموعه \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠|عذرا يا » {[@"..data.username_.."]}\n📮| المتحركه التي ارسلتها تم منعها من المجموعه \n") 
else
send(msg.chat_id_,0,"⚠|عذرا يا » {["..data.first_name_.."](T.ME/ASTORHBOTS)}\n📮| المتحركه التي ارسلتها تم منعها من المجموعه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥¦ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌¦ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸¦ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'🔖¦ عدد اعضاء المجموعه قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'*🔖┇ يا عيني مفعل من زمان لا تزعجنا ♥️*')
else
sendText(msg.chat_id_,'\n👤| بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n📝|  تم تفعيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '🔖| تم تفعيل مجموعه جديده\n'..
'\n🔘| بواسطة {'..Name..'}'..
'\n💠| ايدي المجموعه {`'..IdChat..'`}'..
'\n👥| اسم المجموعه {['..NameChat..']}'..
'\n🔖|عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n🖇️| الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'🔖¦ المجموعه تم تطيلها من قبل')
else
sendText(msg.chat_id_,'\n👤| بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n📌| تم تعطيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '\nتم تعطيل المجموعه |🔖'..
'\n🔘| بواسطة {'..Name..'}'..
'\n💠|ايدي المجموعه {`'..IdChat..'`}'..
'\n👥|اسم المجموعه {['..NameChat..']}'..
'\n🖇️| الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸¦ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'🔖¦ عدد اعضاء المجموعه قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'📌| تم تفعيل المجموعه بنجاح')
else
sendText(msg.chat_id_,'\n👤¦ بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n✔️¦ تم تفعيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '🔖| تم تفعيل مجموعه جديده\n'..
'\n🔘| بواسطة {'..Name..'}'..
'\n👤| موقعه في المجموعه {'..AddPy..'}' ..
'\n💠| ايدي المجموعه {`'..IdChat..'`}'..
'\n👥| عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n📝| اسم المجموعه {['..NameChat..']}'..
'\n🖇️| الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and SudoBot(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'📌¦ تم تعيين عدد الاعضاء سيتم تفعيل المجموعات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث السورس' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥¦ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌¦ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf MARCOS.lua')
os.execute('wget https://raw.githubusercontent.com/ALASTORH/ALASTORA/master/MARCOS.lua')
send(msg.chat_id_, msg.id_,'*🔭| تم تحديث البوت \n📮| لديك اخر اصدار سورس الاسطورة\n📡| الاصدار ← { 1.3v}*')
dofile('MARCOS.lua')  
end



if text and text:match("^تغير الاشتراك$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '⚡| حسنآ ارسل لي معرف القناة') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") and SudoBot(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '📌| حسنآ ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك ??" and SudoBot(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "🔘| تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^تفعيل الاشتراك الاول🌟$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '🔰| حسنآ ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك الاجباري 📥" and SudoBot(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"📮| الاشتراك الاجباري مفعل \n🔘| على القناة » ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_,"🔖| اهلا عزيزي المطور \n📌| ارسل معرف قناتك ليتم تفعيل الاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري 📤" and SudoBot(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "🔖| تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري 🚸" and SudoBot(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "🔖| تم تفعيل الاشتراك الاجباري \n🚸| على القناة » ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "📮| لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
if text == "الاضافات" and Constructor(msg) then
local Xx = database:get(bot_id.."AL:Sre:stats") or "لم يتم التحديد"
TextAdd = [[
📯┇ اهلا بك عزيزي 💞
📯┇ اوامر الاضافات كتالي⟱
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📪┇ كتم الاسماء
1- كتم اسم +(اسم)
2- الغاء كتم اسم +(اسم)
3- الاسماء المكتومه
4- مسح الاسماء المكتومه
5- تفعيل كتم الاسم
6- تعطيل كتم الاسم
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📋┇ وضع توحيد
1- وضع توحيد +(التوحيد)
2- تعين عدد الكتم+(العدد)
3- التوحيد
4- تفعيل التوحيد
5- تعطيل التوحيد 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📌┇ اهلا بك عزيزي 💞
📌┇ اوامر التنبيه كتالي⟱
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📳┇ تنبيه الاسماء 💗
1- تفعيل تنبيه الاسماء 
2- تعطيل تنبيه الاسماء
🆔┇ تنبيه المعرف 💗
1- تفعيل تنبيه المعرف
2- تعطيل تنبيه المعرف
🏞┇ تنبيه الصور 💗
1- تفعيل تنبيه الصور 
2- تعطيل تنبيه الصور 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(TextAdd)) 
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⌯┇ تم كتم الاسم '..BlNe)
database:sadd(bot_id.."MaRcoS:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⌯┇ تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."MaRcoS:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."MaRcoS:blocname"..msg.chat_id_)
texts = "⌯┇ تم مسح الاسماء المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."MaRcoS:blocname"..msg.chat_id_)
t = "\n⌯┇ قائمة الاسماء المكتومه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if #All_name == 0 then
t = "⌯┇ لا يوجد اسماء مكتومه"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '⌯┇ تم التفعيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '⌯┇ تم تعطيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function RA0AD_name(t1,t2)
if t2.id_ then 
name_MaRcoS = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_MaRcoS then 
names_MaRcoS = database:smembers(bot_id.."MaRcoS:blocname"..msg.chat_id_) or ""
if names_MaRcoS and names_MaRcoS[1] then 
for i=1,#names_MaRcoS do 
if name_MaRcoS:match("(.*)("..names_MaRcoS[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, RA0AD_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^وضع توحيد (.*)$") and Constructor(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^وضع توحيد (.*)$")
send(msg.chat_id_, msg.id_,'⌯┇ تم تعيين '..teh..' كتوحيد للمجموعه')
database:set(bot_id.."MaRcoS:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and Constructor(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'⌯┇ تم تعين  '..nump..' عدد الكتم')
database:set(bot_id.."MaRcoS:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."MaRcoS:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."MaRcoS:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'⌯┇ التوحيد '..s1..'\n ⌯┇ عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '⌯┇ تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '⌯┇ تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."MaRcoS:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function amir_MaRcoSa_new(MaRcoS1,MaRcoS2)
if MaRcoS2 and MaRcoS2.first_name_ then 
if MaRcoS2.first_name_:match("(.*)"..database:get(bot_id.."MaRcoS:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."MaRcoS:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local MaRcoS_nnn = database:get(bot_id.."MaRcoS:nump"..msg.chat_id_) or 5
local MaRcoS_nnn2 = database:get(bot_id.."MaRcoS:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(MaRcoS_nnn2) == tonumber(MaRcoS_nnn) or tonumber(MaRcoS_nnn2) > tonumber(MaRcoS_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."MaRcoS:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "⌯┇ عزيزي >>["..MaRcoS2.username_.."](https://t.me/"..(MaRcoS2.username_ or "ASTORHBOTS")..")\n⌯┇ عليك وضع التوحيد ⪼ {"..database:get(bot_id.."MaRcoS:teh"..msg.chat_id_).."} بجانب اسمك\n⌯┇ عدد المحاولات المتبقيه {"..(tonumber(MaRcoS_nnn) - tonumber(MaRcoS_nnn2)).."}")
end
end
end
end
bnnaGet(id, amir_MaRcoSa_new)
end
end
if text == "تفعيل تنبيه الاسماء" and Manager(msg) then
send(msg.chat_id_, msg.id_, '•تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and Manager(msg) then
send(msg.chat_id_, msg.id_, '•تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:BBE:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local MARCOSChengName = database:get(bot_id.."MARCOS:Cheng:Name"..data.id_)
if not data.first_name_ then 
if MARCOSChengName then 
send(msg.chat_id_, msg.id_, " ليش مغير اسمك ياحلو ☹"..MARCOSChengName..']')
database:del(bot_id.."MARCOS:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if MARCOSChengName ~= data.first_name_ then 
local Text = {
  "اسمك القديم احلى",
"ليش غيرت اسمك يحلو ",
"هذا لحلو غير اسمه ",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MARCOS:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '•تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '•تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local MARCOSChengUserName = database:get(bot_id.."MARCOS:Cheng:UserName"..data.id_)
if not data.username_ then 
if MARCOSChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خمطو بساع بساع  \n هاذه معرفه  : [@"..MARCOSChengUserName..']')
database:del(bot_id.."MARCOS:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if MARCOSChengUserName ~= data.username_ then 
local Text = {
'شكو غيرت معرفك شنو نشروك بقنوات نحراف 🌞😹😹😹',
"هاها شو غيرت معرفك بس لا هددوك 🤞😂😂",
"شسالفه شو غيرت معرفك 😐🌝",
"غير معرفه خمطو بساع بساع \n هاذه معرفه : @"..data.username_.."",
'ها عار مو جان معرفك \n شكو غيرته ل @'..data.username_..' ',
'ها يول شو مغير معرفك', 
"منور معرف جديد : "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MARCOS:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '•تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and Constructor(msg) then
send(msg.chat_id_, msg.id_, '•تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local MARCOSChengPhoto = database:get(bot_id.."MARCOS:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if MARCOSChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صوره الحلو 😂👌🏻")
database:del(bot_id.."MARCOS:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if MARCOSChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شكو غيرت صورتك  يا حلو ",
  "منور طالع حلو عل صوره جديده",
  "ها شو غيرت صورتك 🤔😹",
  "شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚",
  "شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞",
  "شكو غيرت الصوره شسالفه ؟؟ 🤔🌞",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MARCOS:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)   
end
if text == 'السورس' or text == 'سورس' or text == 'ياسورس' or text == 'يا سورس' then
local Text =[[
🙋︙اهلا بكـ في سورس الاسطورة 🦅
🕹 : السـورس الاقوئ في الوطن العربي
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●

]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = '📮︙⇚ قناة السورس', url = "https://t.me/Lslhb"}
},
{
{text = '👲︙⇚ الدعم الفني', url = "https://t.me/chtlhb"}
},
{
{text = '👲︙⇚ مبرمج السورس', url = "https://t.me/pfpff"}
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'مقالات' or text == 'مقالة' or text == 'مقالة' then
local list = database:smembers(bot_id.."makal:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
database:set(bot_id.."makal:bots:qus"..msg.chat_id_,quschen1)
database:setex(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(database:get(bot_id.."makal:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = database:ttl(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timemkall)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,'  استمر ي وحش ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 2 then
send(msg.chat_id_, msg.id_,'  اكيد محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 3 then
send(msg.chat_id_, msg.id_,'  اتوقع محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 4 then
send(msg.chat_id_, msg.id_,'  مركب تيربو !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 5 then
send(msg.chat_id_, msg.id_, '  صح عليك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 6 then
send(msg.chat_id_, msg.id_,'   صحيح !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 7 then
send(msg.chat_id_, msg.id_,'   شد حيلك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 8 then
send(msg.chat_id_, msg.id_, '  عندك اسرع ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 9 then
send(msg.chat_id_, msg.id_,'   يجي ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 10 then
send(msg.chat_id_, msg.id_,'   كفو ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 11 then
send(msg.chat_id_, msg.id_,'   ماش !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 12 then
send(msg.chat_id_, msg.id_,'   مستوى مستوى !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 13 then
send(msg.chat_id_, msg.id_,'   تدرب ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 14 then
send(msg.chat_id_, msg.id_,'   مدري وش اقول ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 15 then
send(msg.chat_id_, msg.id_,'   بطه ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 16 then
send(msg.chat_id_, msg.id_,'   ي بطوط !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 17 then
send(msg.chat_id_, msg.id_,'   مافي اسرع  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 18 then
send(msg.chat_id_, msg.id_,'   بكير  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 19 then
send(msg.chat_id_, msg.id_,'   وش هذا !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 20 then
send(msg.chat_id_, msg.id_,'   الله يعينك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 21 then
send(msg.chat_id_, msg.id_,'   كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 22 then
send(msg.chat_id_, msg.id_,'   يبي لك تدريب  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 23 then
send(msg.chat_id_, msg.id_,'   انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 24 then
send(msg.chat_id_, msg.id_,'   ههههه بطى !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 25 then
send(msg.chat_id_, msg.id_,'   ابك وش العلم !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 26 then
send(msg.chat_id_, msg.id_,'  اخر مرا تلعب !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 27 then
send(msg.chat_id_, msg.id_,'   ي بطي !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 28 then
send(msg.chat_id_, msg.id_,'   ليه انت بطى يخوي !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 29 then
send(msg.chat_id_, msg.id_,'   تدبر زين بس  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 30 then
send(msg.chat_id_, msg.id_,'  مستوى بس !  \n عدد الثواني {'..timemkal..'}')
end
database:del(bot_id.."makal:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
database:del(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end
if text == 'انصحني' or text == 'نصيحه' or text == 'انصحيني' then
local list = database:smembers(bot_id.."nsih:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
database:set(bot_id.."nsih:bots:qus"..msg.chat_id_,quschen1)
database:setex(bot_id.."nih:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(database:get(bot_id.."nsih:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = database:ttl(bot_id.."nih:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timenihh)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,'  استمر ي وحش ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 2 then
send(msg.chat_id_, msg.id_,'  اكيد محد ينافسك ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 3 then
send(msg.chat_id_, msg.id_,'  اتوقع محد ينافسك ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 4 then
send(msg.chat_id_, msg.id_,'  مركب تيربو !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 5 then
send(msg.chat_id_, msg.id_, '  صح عليك !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 6 then
send(msg.chat_id_, msg.id_,'   صحيح !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 7 then
send(msg.chat_id_, msg.id_,'   شد حيلك ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 8 then
send(msg.chat_id_, msg.id_, '  عندك اسرع ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 9 then
send(msg.chat_id_, msg.id_,'   يجي ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 10 then
send(msg.chat_id_, msg.id_,'   كفو ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 11 then
send(msg.chat_id_, msg.id_,'   ماش !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 12 then
send(msg.chat_id_, msg.id_,'   مستوى مستوى !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 13 then
send(msg.chat_id_, msg.id_,'   تدرب ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 14 then
send(msg.chat_id_, msg.id_,'   مدري وش اقول ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 15 then
send(msg.chat_id_, msg.id_,'   بطه ! \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 16 then
send(msg.chat_id_, msg.id_,'   ي بطوط !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 17 then
send(msg.chat_id_, msg.id_,'   مافي اسرع  !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 18 then
send(msg.chat_id_, msg.id_,'   بكير  !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 19 then
send(msg.chat_id_, msg.id_,'   وش هذا !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 20 then
send(msg.chat_id_, msg.id_,'   الله يعينك !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 21 then
send(msg.chat_id_, msg.id_,'   كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 22 then
send(msg.chat_id_, msg.id_,'   يبي لك تدريب  !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 23 then
send(msg.chat_id_, msg.id_,'   انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 24 then
send(msg.chat_id_, msg.id_,'   ههههه بطى !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 25 then
send(msg.chat_id_, msg.id_,'   ابك وش العلم !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 26 then
send(msg.chat_id_, msg.id_,'  اخر مرا تلعب !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 27 then
send(msg.chat_id_, msg.id_,'   ي بطي !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 28 then
send(msg.chat_id_, msg.id_,'   ليه انت بطى يخوي !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 29 then
send(msg.chat_id_, msg.id_,'   تدبر زين بس  !  \n عدد الثواني {'..timenih..'}')
elseif tonumber(timenih) == 30 then
send(msg.chat_id_, msg.id_,'  مستوى بس !  \n عدد الثواني {'..timenih..'}')
end
database:del(bot_id.."nsih:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
database:del(bot_id.."nih:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end
if text == 'صراحه' or text == 'صراحة' then
local list = database:smembers(bot_id.."srah:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
database:set(bot_id.."srah:bots:qus"..msg.chat_id_,quschen1)
database:setex(bot_id.."sah:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(database:get(bot_id.."srah:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = database:ttl(bot_id.."sah:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timesah)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,'  استمر ي وحش ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 2 then
send(msg.chat_id_, msg.id_,'  اكيد محد ينافسك ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 3 then
send(msg.chat_id_, msg.id_,'  اتوقع محد ينافسك ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 4 then
send(msg.chat_id_, msg.id_,'  مركب تيربو !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 5 then
send(msg.chat_id_, msg.id_, '  صح عليك !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 6 then
send(msg.chat_id_, msg.id_,'   صحيح !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 7 then
send(msg.chat_id_, msg.id_,'   شد حيلك ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 8 then
send(msg.chat_id_, msg.id_, '  عندك اسرع ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 9 then
send(msg.chat_id_, msg.id_,'   يجي ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 10 then
send(msg.chat_id_, msg.id_,'   كفو ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 11 then
send(msg.chat_id_, msg.id_,'   ماش !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 12 then
send(msg.chat_id_, msg.id_,'   مستوى مستوى !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 13 then
send(msg.chat_id_, msg.id_,'   تدرب ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 14 then
send(msg.chat_id_, msg.id_,'   مدري وش اقول ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 15 then
send(msg.chat_id_, msg.id_,'   بطه ! \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 16 then
send(msg.chat_id_, msg.id_,'   ي بطوط !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 17 then
send(msg.chat_id_, msg.id_,'   مافي اسرع  !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 18 then
send(msg.chat_id_, msg.id_,'   بكير  !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 19 then
send(msg.chat_id_, msg.id_,'   وش هذا !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 20 then
send(msg.chat_id_, msg.id_,'   الله يعينك !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 21 then
send(msg.chat_id_, msg.id_,'   كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 22 then
send(msg.chat_id_, msg.id_,'   يبي لك تدريب  !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 23 then
send(msg.chat_id_, msg.id_,'   انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 24 then
send(msg.chat_id_, msg.id_,'   ههههه بطى !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 25 then
send(msg.chat_id_, msg.id_,'   ابك وش العلم !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 26 then
send(msg.chat_id_, msg.id_,'  اخر مرا تلعب !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 27 then
send(msg.chat_id_, msg.id_,'   ي بطي !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 28 then
send(msg.chat_id_, msg.id_,'   ليه انت بطى يخوي !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 29 then
send(msg.chat_id_, msg.id_,'   تدبر زين بس  !  \n عدد الثواني {'..timesah..'}')
elseif tonumber(timesah) == 30 then
send(msg.chat_id_, msg.id_,'  مستوى بس !  \n عدد الثواني {'..timesah..'}')
end
database:del(bot_id.."srah:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
database:del(bot_id.."sah:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end
if text == 'نكته' or text == 'نكت' or text == 'نكتة' then
local list = database:smembers(bot_id.."nkth:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
database:set(bot_id.."srah:bots:qus"..msg.chat_id_,quschen1)
database:setex(bot_id.."nth:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(database:get(bot_id.."nkth:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = database:ttl(bot_id.."nth:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timenth)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,'  استمر ي وحش ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 2 then
send(msg.chat_id_, msg.id_,'  اكيد محد ينافسك ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 3 then
send(msg.chat_id_, msg.id_,'  اتوقع محد ينافسك ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 4 then
send(msg.chat_id_, msg.id_,'  مركب تيربو !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 5 then
send(msg.chat_id_, msg.id_, '  صح عليك !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 6 then
send(msg.chat_id_, msg.id_,'   صحيح !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 7 then
send(msg.chat_id_, msg.id_,'   شد حيلك ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 8 then
send(msg.chat_id_, msg.id_, '  عندك اسرع ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 9 then
send(msg.chat_id_, msg.id_,'   يجي ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 10 then
send(msg.chat_id_, msg.id_,'   كفو ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 11 then
send(msg.chat_id_, msg.id_,'   ماش !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 12 then
send(msg.chat_id_, msg.id_,'   مستوى مستوى !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 13 then
send(msg.chat_id_, msg.id_,'   تدرب ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 14 then
send(msg.chat_id_, msg.id_,'   مدري وش اقول ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 15 then
send(msg.chat_id_, msg.id_,'   بطه ! \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 16 then
send(msg.chat_id_, msg.id_,'   ي بطوط !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 17 then
send(msg.chat_id_, msg.id_,'   مافي اسرع  !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 18 then
send(msg.chat_id_, msg.id_,'   بكير  !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 19 then
send(msg.chat_id_, msg.id_,'   وش هذا !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 20 then
send(msg.chat_id_, msg.id_,'   الله يعينك !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 21 then
send(msg.chat_id_, msg.id_,'   كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 22 then
send(msg.chat_id_, msg.id_,'   يبي لك تدريب  !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 23 then
send(msg.chat_id_, msg.id_,'   انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 24 then
send(msg.chat_id_, msg.id_,'   ههههه بطى !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 25 then
send(msg.chat_id_, msg.id_,'   ابك وش العلم !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 26 then
send(msg.chat_id_, msg.id_,'  اخر مرا تلعب !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 27 then
send(msg.chat_id_, msg.id_,'   ي بطي !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 28 then
send(msg.chat_id_, msg.id_,'   ليه انت بطى يخوي !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 29 then
send(msg.chat_id_, msg.id_,'   تدبر زين بس  !  \n عدد الثواني {'..timenth..'}')
elseif tonumber(timenth) == 30 then
send(msg.chat_id_, msg.id_,'  مستوى بس !  \n عدد الثواني {'..timenth..'}')
end
database:del(bot_id.."nkth:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
database:del(bot_id.."nth:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع النسخه الاحتياطيه' and SudoBot(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه احتياطيه' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = "📮| قائمه الاوامر المضافه  \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> ("..v..") » {"..Cmds.."}\n"
else
t = t..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد اوامر مضافه"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'💠| تم ازالة جميع الاوامر المضافه')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'📌| ارسل الامر القديم')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'🔖| ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'📌| ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'🔘| تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الدردشه ')  
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n??| تـم قفـل اضافة الاعضاء ')  
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل دخول الاعضاء ')  
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل البوتات ')  
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل البوتات بالطرد\n⛔| الحاله ←الطرد')  
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الاشعارات ')  
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التثبيت هنا ')  
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل تعديل ')  
end,nil)   
elseif text == 'قفل الفشار' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌯┇بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n⌯┇تـم قفـل الفشار ')
end,nil)  
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌯┇بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n⌯┇تـم قفـل الفارسيه ')
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل تعديل  ')  
end,nil)   
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل جميع الاوامر ')  
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ℘︙ بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'S0DRG')..') \n ℘︙ تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ℘︙ بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'S0DRG')..') \n ℘︙ تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح اضافة الاعضاء ')  
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الدردشه ')  
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح دخول الاعضاء ')  
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح البوتات ')  
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') ??\n🔘| تـم فـتح البوتات بالطرد\n⛔| الحاله ←الطرد')  
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح الاشعارات ')  
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح التثبيت هنا ')  
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح تعديل  ')  
end,nil)   
elseif text == 'فتح الفشار' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌯┇بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n⌯┇تـم فـتح الفشار ')
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌯┇بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n⌯┇تـم فـتح الفارسيه ')
end,nil)
elseif text == 'فتح التعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح تعديل  ')  
end,nil)   
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فـتح جميع الاوامر ')  
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الروابط ')  
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الروابط بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الروابط بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الروابط بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الروابط ')  
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المعرفات ')  
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المعرفات بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المعرفات بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n??| تـم قفـل المعرفات بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح المعرفات ')  
end,nil)   
end
if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التاك ')  
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التاك بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التاك بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التاك بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح التاك ')  
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الشارحه ')  
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الشارحه بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الشارحه بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الشارحه بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الشارحه ')  
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصور ')  
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصور بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصور بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصور بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الصور ')  
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الفيديو ')  
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الفيديو بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الفيديو بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الفيديو بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الفيديو ')  
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المتحركه ')  
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المتحركه بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المتحركه بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل المتحركه بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح المتحركه ')  
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الالعاب ')  
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الالعاب بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الالعاب بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الالعاب بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الالعاب ')  
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الاغاني ')  
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الاغاني بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الاغاني بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الاغاني بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الاغاني ')  
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصوت ')  
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصوت بالتقييد\n⛔| الحاله ←التقييد')  
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصوت بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الصوت بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الصوت ')  
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكيبورد ')  
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكيبورد بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكيبورد بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكيبورد بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملصقات بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملصقات بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملصقات بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التوجيه بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التوجيه بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل التوجيه بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملفات بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملفات بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الملفات بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل السيلفي بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل السيلفي بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n??| تـم قفـل السيلفي بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الماركداون بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الماركداون بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الماركداون بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الجهات بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الجهات بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الجهات بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكلايش بالتقييد\n⛔| الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكلايش بالكتم\n⛔| الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم قفـل الكلايش بالطرد\n⛔| الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'ASTORHBOTS')..') \n🔘| تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'🔘| تم قفل التكرار بالطرد\n⛔| الحاله ←الطرد')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'🔘| تم قفل التكرار \n⛔| الحاله ←بالمسح')
elseif text == 'قفل التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'🔘| تم قفل التكرار بالتقييد\n⛔| الحاله ←التقييد')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'🔘| تم قفل التكرار بالكتم\n⛔| الحاله ←الكتم')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'🔘| تم فتح التكرار')
end 
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and SudoBot(msg) then    
dofile('MARCOS.lua')  
send(msg.chat_id_, msg.id_, '☑️| تم تحديث البوت') 
end 
if text == ("مسح قائمه العام") and SudoBot(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n🔖| تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n*⚠️| قائمة المحظورين عام \n━━━━━━━━━━━\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*✖¦ لا يوجد محظورين عام*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⚠️| لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "🚸| لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n*🔘| تم حظره عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⛔| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "🔖| لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⚠️| لا يمكنك حظر المطور الاساسي \n")
return false 
end
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم حظره عام من المجموعات'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⛔| لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠|لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⚠️| لا تستطيع استخدام البوت \n ⚠️| يرجى الاشتراك بالقناه اولا \n ⚠️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⚠️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n⚠️| تم كتمه عام من القروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⚠️| لا تستطيع استخدام البوت \n ⚠️| يرجى الاشتراك بالقناه اولا \n ⚠️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع كتم البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⚠️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'lslhb')..')'
status  = '\n⚠️| تم كتمه عام من القروبات'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⚠️| لا تستطيع استخدام البوت \n ⚠️| يرجى الاشتراك بالقناه اولا \n ⚠️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⚠️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n⚠️| تم كتمه عام من القروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n⚠️| تم كتمه عام من القروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء(الحظر-الكتم) عام من القروبات  '
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء حظره عام من المجموعات'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم الغاء(الحظر-الكتم) عام من القروبات  '
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and SudoBot(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n📝|  تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n*📮| قائمة مطورين البوت \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*✖| لا يوجد مطورين*"
end
send(msg.chat_id_, msg.id_, t)
end


if text == 'الملفات' and SudoBot(msg) then
t = '*📮| ملفات السورس الاسطورة ↓\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف ← {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" or text == 'المتجر' then
if SudoBot(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/ALASTORH/Files_ALASTORA/master/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n??| اهلا بك في متجر ملفات الاسطورة\n🔰| ملفات السورس ↓\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n\n"
local TextE = "\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n🔘|  علامة تعني { ✓ } ملف مفعل\n🔘| علامة تعني { ✘ } ملف معطل\n🔖| قناة سورس الاسطورة ↓\n".."📮| [اضغط هنا لدخول](t.me/ASTORHBOTS) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✓)"
else
CeckFile = "(✘)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`} » '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"🔰| لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and SudoBot(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = "📁| الملف ← "..file.."\n🔰| تم تعطيل ملف \n"
else
t = "🔖| بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/ALASTORH/Files_ALASTORA/master/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('MARCOS.lua')  
else
send(msg.chat_id_, msg.id_,"⚠️| عذرا هاذا ملف ليس من ملفات سورس الاسطورة\n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and SudoBot(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = "🔖| بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = "📁| الملف ← "..file.."\n🔰| تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/ALASTORH/Files_ALASTORA/master/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('MARCOS.lua')  
else
send(msg.chat_id_, msg.id_,"⚠️|  عذرا هاذا ملف ليس من ملفات سورس الاسطورة\n") 
end
return false
end
if text == "مسح الملفات" and SudoBot(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_,"🔖| تم مسح الملفات")
return false
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ??| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح قائمه المالك") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n 🔷|تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n 🔷| قائمه المالك \n≪━━━━━ÃŜŤÕŘȞ━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 🔷| لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n 🔷| وينكم تعالو يريدوكم بكروب \n≪━━━━━ÃŜŤÕŘȞ━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " 🔷| لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 🔷| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n 🔷| تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and Sudo(msg) then
local username = text:match("^رفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 🔷| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n 🔷| العضو » ['..result.title_..'](t.me/'..(username or 'LSLHB')..')'
status  = '\n 🔷| تم ترقيته مالك'
texts = usertext..status
else
texts = ' 🔷| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 🔷| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n 🔷| تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 🔷| العضو » '..userid..''
status  = '\n 🔷| تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 🔷| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n 🔷| تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n 🔷| العضو » ['..result.title_..'](t.me/'..(username or 'LSLHB')..')'
status  = '\n 🔷| تم تنزيله من المالكين'
texts = usertext..status
else
texts = ' 🔷| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 🔷| لا تستطيع استخدام البوت \n  🔷|يرجى الاشتراك بالقناه اولا \n  🔷|اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 🔷| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'LSLHB')..')'
status  = '\n 🔷| تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 🔷| العضو » '..userid..''
status  = '\n 🔷| تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------

if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "℘︙ المنشئين الاساسين تعالو مخرب \nٴ≪┉ ┉ ┉ ┉ ┉ 𝐃𝐑𝐠 ┉  ┉ ┉ ┉ ┉≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "℘︙ ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","℘︙ قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "🙋‍♂️︙ المنشئين الاساسين تعالو مخرب \nٴ≪┉ ┉ ┉ ┉ ┉ 𝐃𝐑𝐠 ┉  ┉ ┉ ┉ ┉≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "❌︙ ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","℘︙ قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
Text = '✅︙تم تفعيل تحويل الصيغ'
database:del(bot_id..'DRAGOON:change:sofi'..msg.chat_id_)  
else
Text = ' ✅︙ بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:sofi'..msg.chat_id_,true)  
Text = '\n ❎︙ تم تعطيل امر تحويل'
else
Text = '\n ❎︙ بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسيين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n☑| تم مسح قائمه المنشئين الاساسين')
return false
end

if text == 'المنشئين الاساسيين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n📮| قائمة المنشئين الاساسين \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖| لا يوجد منشئين اساسيين"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '✖| تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n📮| قائمة المنشئين \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖| لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"⚠️| حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "ASTORHBOTS")
send(msg.chat_id_, msg.id_,"👁️‍🗨️| منشئ المجموعه ← ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته منشئ'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المنشئين'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '✖|  تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n📮| قائمة المدراء \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖| لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n 🙋‍♂️| وينكم تعالو يريدوكم بالقروب \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "✖| لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مدير'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المدراء'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"📮| لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"📌| تمت ترقية { "..num2.." } من ادمنية المجموعه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '🗑|  تم مسح  قائمة الادمنية  ')
end
if text == ("الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n📮| قائمة الادمنيه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖| لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n📮| قائمة الادمنيه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {`"..v.."`}\n"
end
end
if #list == 0 then
t = "✖| لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الرفع من قبل المنشئين') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n??| تم ترقيته ادمن'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🚸| تم تعطيل الرفع من قبل المنشئين') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤|العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
statusk  = '\n📮| الايدي » `'..result.sender_user_id_..'` \n🔘| تم طرد العضو من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🔖| تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️|لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
statusk  = '\n🔘| تم طرد العضو من هنا'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃|تم تعطيل الطرد من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠¦ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
 statusk  = '\n🔘| تم طرد العضو من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n👤| العضو » '..userid..''
 statusk  = '\n🔘| تم طرده من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم مسح  قائمة الاعضاء المميزين  *')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n*📮| قائمة مميزين المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*✖| لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n 🙋‍♂️| وينكم تعالو يريدوكم بالقروب \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "*✖| لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم ترقيته مميز هنا '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
local  statuss  = '\n🔘| تم ترقيته مميز هنا'
texts = usertext..statuss
else
texts = '⚠️|لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'📃| تم تعطيل الرفع من قبل المنشئين') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤|العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n🔘| تم ترقيته مميز هنا'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n👤| العضو » '..userid..''
local  statuss  = '\n??| تم ترقيته مميز هنا '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المميزين'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'تنزيل الحمير' and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم مسح جميع الحمير في المجموعه *')
end
if text == ("تاك للحمير") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n*🔘| قائمة حمير المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الحمار [@"..username.."]\n"
else
t = t..""..k.."← الحمار`"..v.."`\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد حمير*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حمار") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو حمارفي المجموعه \nتعال حبي استلم العربانه من المدير*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حمار")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤¦ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو حمارفي المجموعه\nتعال حبي رجع العربانه لمدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الصخوله' and Mod(msg) then
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم تنزيل جميع صخل بالمجموعه *')
end
if text == ("تاك لصخوله") and Mod(msg) then
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n*??| قائمة صخوله المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الصخل [@"..username.."]\n"
else
t = t..""..k.."← الصخل `"..v.."`\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد صخل*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع صخل") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🔖| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع المتهم صخل بنجاح\nالان اصبح صخل القروب*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("تنزيل صخل")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو صخل\nارجع بيتكم*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الكلاب' and Mod(msg) then
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع كلاب المجموعه *')
end
if text == ("تاك للكلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n*🔘| قائمة الكلاب بالمجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الكلب [@"..username.."]\n"
else
t = t..""..k.."← الكلب `"..v.."`\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد كلب*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو إلى كلب بنجاح\nتعال يالكلب اعطيك عضمه 😂*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🔘| ⚡| تم تنزيل العضو كلب\nحبي رجع عضمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل القرود' and Mod(msg) then
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع القروده بالمجموعه *')
end
if text == ("تاك للقرود") and Mod(msg) then
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n*🔘| قائمة القروده المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← القرد [@"..username.."]\n"
else
t = t..""..k.."← القرد `"..v.."`\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد قرد*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قرد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🔘| ⚡| تم رفع العضو قرد\n بالقروب تعال حبي خذ الموز 😂*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قرد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو قرد\nرجع الموز 😂*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الاحصنه' and Mod(msg) then
database:del(bot_id..'Hors:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع الحصونه بالمجموعه *')
end
if text == ("تاك للاحصنه") and Mod(msg) then
local list = database:smembers(bot_id..'Hors:User'..msg.chat_id_)
t = "\n*🔘| قائمة الحصونه المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الحصان [@"..username.."]\n"
else
t = t..""..k.."← الحصان `"..v.."`\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد حصان*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حصان") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Hors:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو حصان\nتعال حبي احطلك سرج وركبك فرني فره حلوه*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حصان")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Hors:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو حصان\nرجع السرج*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل البقر' and Mod(msg) then
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع البقر بالمجموعه *')
end
if text == ("تاك للبقر") and Mod(msg) then
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n*🔘| قائمة البقرالمجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← البقره [@"..username.."]\n"
else
t = t..""..k.."← البقره "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️|  لا يوجد بقر*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بقره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو بقره\nها يالبقره تعال احلبك 😂*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو بقره\nتعال خذ الحليب يالبقره 😂*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل النعاج' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم تنزيل جميع النعاج بالمجموعه*')
end
if text == ("تاك لنعاج") and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n*🔘| قائمة النعاج المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← النعجه [@"..username.."]\n"
else
t = t..""..k.."← النعجه "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد نعاج*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع نعجه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو نعجه\nطلع برا ابو البعرور الوصخ*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل نعجه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو نعجه\nها خذ البعر حقك 😂*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل زوجاتي' and Mod(msg) then
database:del(bot_id..'Mrti:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم تنزيل جميع الزوجات بالمجموعه *')
end
if text == ("تاك للزوجات") and Mod(msg) then
local list = database:smembers(bot_id..'Mrti:User'..msg.chat_id_)
t = "\n*🔘| قائمة الزوجات المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الزوجة [@"..username.."]\n"
else
t = t..""..k.."← الزوجة "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لم تقم بالزواج من احد*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زوجتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mrti:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو زوجتك\nالآن يمكنكم أخذ راحتكم🤤😉*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زوجتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mrti:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🙋🏻‍♂╿اهــلا عزيزي\n🎫│تم تنزيل الرمه زوجتك بنجاح✔️\nالآن انتم مفترقان☹️💔*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل قلبي' and Mod(msg) then
database:del(bot_id..'Qlbi:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم تنزيل الجميع من داخل قلبك بالمجموعه *')
end
if text == ("تاك لقلبي") and Mod(msg) then
local list = database:smembers(bot_id..'Qlbi:User'..msg.chat_id_)
t = "\n*🔘| قائمة قلبك بالمجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← قـلـبـي [@"..username.."]\n"
else
t = t..""..k.."← قـلبـي "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد احـد بقلبكـ*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع لقلبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Qlbi:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🙋🏻‍♂╿اهــلا عزيزي\n🎫│تم رفع العضو داخل قلبك✔️\n🛠╽تمت ترقيته بنجاح 😻??👋🏻*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل لقلبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Qlbi:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🙋🏻‍♂╿اهــلا عزيزي\n🎫│تم تنزيله من داخل قلبك✔️\n🛠╽تمت ازالته من قائمة القلوب 😹💔*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل ازواجي' and Mod(msg) then
database:del(bot_id..'zwgi:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑|  تم تنزيل جميع ازواجك بالمجموعه *')
end
if text == ("تاك لزوجي") and Mod(msg) then
local list = database:smembers(bot_id..'Zwgi:User'..msg.chat_id_)
t = "\n*🔘| قائمة ازواجك بالمجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← زوجي  [@"..username.."]\n"
else
t = t..""..k.."← زوجي "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لم تقم بالزواج من احد*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زوجي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zwgi:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🙋🏻‍♂╿اهــلا عزيزتي\n🎫│تم زواجكم الاثنين بنجاح✔️\n🛠╽الآن يمكنكم أخذ راحتكم🤤😉*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زوجي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zwgi:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🙋🏻‍♂╿اهــلا عزيزتي\n🎫│تم تنزيل التبن زوجك بنجاح✔️\nالآن انتم مفترقان☹️💔*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الزواحف' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع الزواحف بالمجموعه *')
end
if text == ("تاك لزواحف") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n*🔘| قائمة الزواحف المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الزاحف [@"..username.."]\n"
else
t = t..""..k.."← الزاحف "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد زاحف*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زاحف") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️|  تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم رفع العضو زاحف\nكمشتك حبي جيب رقم*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زاحف")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو زاحف\n هاك حبي هاذا رقم مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الدجاج' and Mod(msg) then
database:del(bot_id..'Djajh:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑| تم تنزيل جميع الدجاج بالمجموعه *')
end
if text == ("تاك لدجاج") and Mod(msg) then
local list = database:smembers(bot_id..'Djajh:User'..msg.chat_id_)
t = "\n*🔘| قائمة دجـاج المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الدجاجه [@"..username.."]\n"
else
t = t..""..k.."← الدجاجه "..v.."\n"
end
end
if #list == 0 then
t = "*⚠️| لا يوجد دجاج*"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع دجاجه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Djajh:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
local  statuss  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n⚡| تم رفع العضو دجاجه\n لاوصيـك اهم شي الـبـيـض 😂'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل دجاجه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Djajh:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*⚡| تم تنزيل العضو دجاجه\n اكلنا البيض عليـك😂*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
---------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n🚷| تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n*📮| قائمة محظورين المجموعه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*✖| لا يوجد محظورين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸|البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n??| الايدي » `'..result.sender_user_id_..'`\n🔘| تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🎗️|  تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n👤| المستخدم » ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n*🔘| تم حظره من المجموعه*'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🔖| تم تعطيل الحظر من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n*🔘| تم حظره من المجموعه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n*🔘| تم حظره من المجموعه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️| انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n*🔘| تم الغاء حظره من هنا*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️| انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء حظره من هنا'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️| انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n*🔘| تم الغاء حظره من هنا*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤|لعضو » '..userid..''
status  = '\n🔘| تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*🗑¦  تم مسح قائمه المكتومين *')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n*🔘| قائمة المكتومين \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*✖| لا يوجد مكتومين*"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*⚠| لا تسطيع كتم البوت *")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠¦ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤|العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n??| الايدي » `'..result.sender_user_id_..'`\n*🔘| تم كتمه وداعا رح افتقد خواطرك 💔*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠|لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n*🔘| تم كتمه وداعا رح افتقد خواطرك 💔*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '⚠|لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n🔰| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n☑| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}\n🔘| تم كتمه وداعا رح افتقد خواطرك 💔*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"💢| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n☑| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'} \n🔘| تم كتمه وداعا رح افتقد خواطرك 💔'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم كتمه وداعا رح افتقد خواطرك 💔'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم كتمه وداعا رح افتقد خواطرك 💔'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم الغاء كتمه يلا حبي سولف '
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥¦ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌¦ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء كتمه يلا حبي سولف '
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء كتمه يلا حبي سولف '
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم الغاء كتمه يلا حبي سولف '
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقييد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع تقييد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تقييدك هنا يالثرثار '
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقييد @(.*)$") and Mod(msg) then
local username = text:match("^تقييد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع تقييد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تقييدك هنا يالثرثار '
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقييد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n🔰| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n☑| تم تقييده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'} \n🔘| تم تقييدك هنا يالثرثار'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقييد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"💢| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n☑| تم تقييده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'} \n🔘| تم تقييدك هنا يالثرثار'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقييد (%d+)$") and Mod(msg) then
local userid = text:match("^تقييد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠| لا تسطيع تقييد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠| عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تقييدك هنا يالثرثار '
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم تقييدك هنا يالثرثار '
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقييد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم الغاء تقييده يلا ارجع سولف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقييد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقييد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء تقييده يلا ارجع سولف'
texts = usertext..status
else
texts = '⚠| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقييد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقييد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء تقييده يلا ارجع سولف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤| العضو » '..userid..''
status  = '\n🔘| تم الغاء تقييده يلا ارجع سولف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '🔖|المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n??| تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'مكتوم عام'
else
Gmute = 'غير مكتوم عام'
end
Textt = "📑| الحظر العام » "..GBan.."\n⚠️| الكتم العام » "..Gmute.."\n⚠️| الحظر » "..Ban.."\n🚸| الكتم » "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'مكتوم عام'
else
Gmute = 'غير مكتوم عام'
end
Textt = "📑| الحظر العام » "..GBan.."\n⚠️| الكتم العام » "..Gmute.."\n⚠️| الحظر » "..Ban.."\n🚸| الكتم » "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم رفعه مشرف بالقروب '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n👤|العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم رفعه مشرف بالقروب '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله مشرف من القروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله مشرف من القروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم رفعه ادمن بالقروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم رفعه ادمن بالقروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '⚠| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n📮| الايدي » `'..result.sender_user_id_..'`\n🔘| تم تنزيله ادمن من القروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n👤| العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n🔘| تم تنزيله ادمن من القروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'اعدادات المجموعه' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '✓'
else 
lock_pin = '✘'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '✓'
else 
lock_tagservr = '✘'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '✓'
else 
lock_text = '✘'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '✓'
else 
lock_add = '✘'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '✓'
else 
lock_join = '✘'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '✓'
else 
lock_edit = '✘'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '✓'
else 
welcome = '✘'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '✓'
else 
lock_edit_med = '✘'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد 🚷'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقييد 🔏'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم 🔇'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح ⚡'           
else     
flood = '✘'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '✓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقييد 🔏'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد 🚷'   
else
lock_photo = '✘'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '✓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد 🚷'    
else
lock_phon = '✘'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '✓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد 🚷'    
else
lock_links = '✘'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '✓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم 🔇'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد 🚷'    
else
lock_cmds = '✘'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '✓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد 🚷'    
else
lock_user = '✘'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '✓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد 🚷'    
else
lock_hash = '✘'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد 🚷'    
else
lock_muse = '✘'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '✓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد 🚷'    
else
lock_ved = '✘'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '✓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد 🚷'    
else
lock_gif = '✘'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '✓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد 🚷'    
else
lock_ste = '✘'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '✓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد 🚷'    
else
lock_geam = '✘'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد 🚷'    
else
lock_vico = '✘'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '✓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقييد 🔏'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد 🚷'
else
lock_inlin = '✘'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '✓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد 🚷'    
else
lock_fwd = '✘'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '✓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد 🚷'    
else
lock_file = '✘'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '✓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد 🚷'    
else
lock_self = '✘'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '✓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقييد 🔏'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد 🚷'    
else
lock_bots = '✘'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '✓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد 🚷'    
else
lock_mark = '✘'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '✓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقييد 🔏'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد 🚷'    
else
lock_spam = '✘'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '✓'
else
rdmder = '✘'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '✓'
else
rdsudo = '✘'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '✓'
else
idgp = '✘'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '✓'
else
idph = '✘'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '✓'
else
setadd = '✘'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '✓'
else
banm = '✘'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '✓'
else
addme = '✘'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '✓'
else
sehuser = '✘'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '✓'
else
kickme = '✘'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n🔰|اعدادات المجموعه كتالي √↓'..
'\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n🔘| علامة ال {✓} تعني معطل'..
'\n🔘| علامة ال {✘} تعني مفعل'..
'\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n📌| الروابط ← { '..lock_links..
' }\n'..'📌| المعرفات ← { '..lock_user..
' }\n'..'📌| التاك ← { '..lock_hash..
' }\n'..'📌| البوتات ← { '..lock_bots..
' }\n'..'📌|التوجيه ← { '..lock_fwd..
' }\n'..'📌|التثبيت ← { '..lock_pin..
' }\n'..'📌| الاشعارات ← { '..lock_tagservr..
' }\n'..'📌| الماركدون ← { '..lock_mark..
' }\n'..'📌| التعديل ← { '..lock_edit..
' }\n'..'📌| تعديل الميديا ← { '..lock_edit_med..
' }\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n'..'🔘| الكلايش ← { '..lock_spam..
' }\n'..'🔘| الكيبورد ← { '..lock_inlin..
' }\n'..'🔘| الاغاني ← { '..lock_vico..
' }\n'..'🔘| المتحركه ← { '..lock_gif..
' }\n'..'🔘| الملفات ← { '..lock_file..
' }\n'..'🔘| الدردشه ← { '..lock_text..
' }\n'..'🔘| الفيديو ← { '..lock_ved..
' }\n'..'🔘| الصور ← { '..lock_photo..
' }\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n'..'🔖| الصوت ← { '..lock_muse..
' }\n'..'🔖| الملصقات ← { '..lock_ste..
' }\n'..'🔖| الجهات ← { '..lock_phon..
' }\n'..'🔖| الدخول ← { '..lock_join..
' }\n'..'🔖| الاضافه ← { '..lock_add..
' }\n'..'🔖| السيلفي ← { '..lock_self..
' }\n'..'🔖| الالعاب ← { '..lock_geam..
' }\n'..'🔖| التكرار ← { '..flood..
' }\n'..'🔖| الترحيب ← { '..welcome..
' }\n'..'🔖| عدد التكرار ← { '..NUM_MSG_MAX..
' }\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n🔰| علامة ال {✓} تعني مفعل'..
'\n🔰| علامة ال {✘} تعني معطل'..
'\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●'..
'\n'..'📮| امر صيح ← { '..kickme..
' }\n'..'📮| امر اطردني ← { '..sehuser..
' }\n'..'📮| امر منو ضافني ← { '..addme..
' }\n'..'📮| ردود المدير ← { '..rdmder..
' }\n'..'📮| ردود المطور ← { '..rdsudo..
' }\n'..'📮| الايدي ← { '..idgp..
' }\n'..'📮| الايدي بالصوره ← { '..idph..
' }\n'..'📮| الرفع ← { '..setadd..
' }\n'..'📮| الحظر ← { '..banm..' }\n\n┉  ┉  ┉  ┉ ┉  ┉  ┉  ┉  ┉  ┉\n🔖| CH » [Channel ALASTORH](https://t.me/ASTORHBOTS)\n'
send(msg.chat_id_, msg.id_,text)     
end    
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"🔘| التثبيت والغاء التثبيت تم قفله من قبل المنشئين")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"🔖| تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"🔖| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"📫| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"💠| التثبيت والغاء التثبيت تم قفله من قبل المنشئين")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"📮| تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"🔖| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"💠| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⚠️| لا تستطيع استخدام البوت \n ⚠️| يرجى الاشتراك بالقناه اولا \n ⚠️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️| عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"❃∫ تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"⚠️| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'🔖| تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'📮| تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"📥| ارسل رابط المجموعه او رابط قناة المجموعه")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"📌| تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"📌| تم تعطيل الرابط") 
return false end
end
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if BasicConstructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"📌┇ تم تفعيل الصوره") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if BasicConstructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"📌┇ تم تعطيل الصوره") 
return false end
end
if text == "الرابط" then 
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"⚠️| الرابط معطل") 
return false  
end
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'🔖| *Link* -\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n ['..link..']')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,linkgpp.result)
linkgp = '🔖| *Link* -\n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n ['..linkgpp.result..']'
else
linkgp = '⚠️| لا يوجد رابط ارسل ضع رابط'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end            
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"🔘| تم مسح الرابط ")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'🎇| ارسل لي الصوره') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'📌| تم ازالة صورة المجموعه') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'📥| ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '🔖| ارسل لي الترحيب الان'
tt = '\n🔘| تستطيع اضافة مايلي !\n👤| دالة عرض الاسم »{`name`}\n💠| دالة عرض المعرف »{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '🔘| لم يتم تعيين ترحيب للمجموعه'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'📮| تم تفعيل ترحيب المجموعه') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'📮| تم تعطيل ترحيب المجموعه') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'💠| تم ازالة ترحيب المجموعه') 
end

if text == "مسح قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"🖇️| تم مسح قائمه المنع")  
end
if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."List:Filter"..msg.chat_id_)  
t = "\n🔘| قائمة المنع \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do  
local MARCOS_Msg = database:get(bot_id.."Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..''..k..'- '..v..' » {'..MARCOS_Msg..'}\n'    
end  
if #list == 0 then  
t = "⚠️|لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  
if text and text == 'منع' and msg.reply_to_message_id_ == 0 and Manager(msg) then       
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'🔘| ارسل الكلمه لمنعها')  
database:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == 'rep' then   
send(msg.chat_id_, msg.id_,"⚠️| ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == 'repp' then  
send(msg.chat_id_, msg.id_,'🔖| تم منع الكلمه مع التحذير')  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == 'الغاء منع' and msg.reply_to_message_id_ == 0 and Manager(msg) then    
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'🔖| ارسل الكلمه الان')  
database:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == 'reppp' then   
send(msg.chat_id_, msg.id_,"📮| تم الغاء منعها ")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."List:Filter"..msg.chat_id_,text)  
return false  end  
end
end
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '📮| تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '📮| تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🔖| تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🔖| تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🔖| تم مسح قائمه منع الملصقات')  
end
if text == 'المطور' or text == 'مطور' or text == 'المطوره' then
local Text_Dev = database:get(bot_id..'Text:Dev:Bot')
if Text_Dev then 
send(msg.chat_id_, msg.id_,Text_Dev)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == 'حذف كليشه المطور' and SudoBot(msg) then
database:del(bot_id..'Text:Dev:Bot')
send(msg.chat_id_, msg.id_,'⚠️| تم حذف كليشه المطور')
end
if text == 'ضع كليشه المطور' and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,'💠| ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🔘| تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'Text:Dev:Bot',text)
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🚸| تم حفظ كليسه المطور')
return false
end
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
🔘| ارسل الان النص
🔘| يمكنك اضافه :
ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
1 - {`تعليق الصوره`} > تعليق الصوره
 2 -{`الاسم`} > اسم المستخدم
3 - {`الرسائل`} > عدد رسائل المستخدم
4 - {`الصور`} > عدد صور المستخدم
5 - {`ايدي`} > ايدي المستخدم
6 - {`التفاعل`} > تفاعل المستخدم
7 - {`الرتبه`} > موقع المستخدم 
8 - {`التعديل`} > عدد التعديلات
9 - {`النقاط`} > النقاط
ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
قناة خاصة بكلايش الايدي
[اضغط هنا للحصول على كليشة](t.me/ksax4)
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '📌| تم ازالة كليشة الايدي ')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"⚠️| تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'📌| تم تعين الايدي بنجاح')    
end

if text == 'مسح البوتات' or text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "📌| لا توجد بوتات في المجموعه")
else
local t = '📮| عدد البوتات هنا >> {'..c..'}\n🔘| عدد البوتات التي هي ادمن >> {'..x..'}\n🔖| تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n💠| قائمة البوتات الموجوده \n━━━━━━━━━━━━━\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "*📌| لا توجد بوتات في المجموعه*")
return false 
end
if #admins == i then 
local a = '\n━━━━━━━━━━━━━\n*💠| عدد البوتات التي هنا >> {'..n..'} بوت\n*'
local f = '*🔖| عدد البوتات التي هي ادمن >> {'..t..'}\n⚠| ملاحضه علامة ال (✯) تعني ان البوت ادمن \n💥*'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "🔘| تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"*🔘| تم حفظ قوانين المجموعه*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"*🔖| ارسل لي القوانين الان*")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"*🔖| تم ازالة قوانين المجموعه*")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' or text == 'قوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"*💠| 🔏 قوانين\n🔅¦➖➖➖➖➖\n❌ممنوع الكلام أو النشر غير اللائق \n❌ممنوع الإساءة أو التجاوز على الآخرين \n❌ممنوع التكلم بالطائفيه\n❌ممنوع وضع صور مخلة بالآداب بالبروفايل الخاص \n❌ ممنوع إرسال همسات سرية في القروب \n❌- ممنوع السب والشتم\n❌ممنوع ارسال صور مخلة بالآداب\n❌ ممنوع نشر أي رابط لأي مجموعة أو قناة\n📜 عقوبة مخالفة القوانين أعلاه يتم مسح الرسائل ، وفي حالة تكرار المخالفة يتم التنبيه والحظر \n🔅¦➖➖➖➖➖\nإدارة القـروب تتمنى لكم التوفيق والعون والسداد وشكرا\n••┉┉┉┉┉┉┉┉┉┉┉┉┉••*")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| العضو ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'sajad13p')..') \n🔘| تـم قفـل التفليش\n🚸| الحاله ← المسح ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤| العضو ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'sajad13p')..') \n🔘| تـم فـتح التفليش\n🚸| الحاله ← المسح ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'*🛰️| تم طرد جميع الحسابات المحذوفه*')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا توجد صلاحيات مضافه')
return false
end
t = "\n🔘| قائمة الصلاحيات المضافه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' » ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "📝 | دز نـوع رتـبـه ?\n📥 | {عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "*⚠️| تم مسح الصلاحيه *\n✓") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"*💠| تم الغاء الامر *\n✓") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"*🔘| تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n💠| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"*🔘| تستطيع اضافه صلاحيات {مميز - عضو} \n💠| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"*🔘| تستطيع اضافه صلاحيات {عضو} \n💠| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "⚠️| تـم اضـافـه الامـر √") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'..'\n🔘| تم تنزيله من '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم رفعه '..text1[2]..' هنا')   
end
else
info = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤| العضو » ['..result.title_..'](t.me/'..(text1[3] or 'ASTORHBOTS')..')'..'\n🔘| تم تنريله من '..text1[2]..' هنا')   
end
else
info = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ▫️⁝ تم مسح المنظفيه')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
t = "\n ▫️⁝ قائمة المنظفين \n≪━━━━━━AST━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ▫️⁝ لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
local list = database:smembers(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
t = "\n ▫️⁝ وينكم تعالو يريدوكم بكروب \n≪━━━━━━AST━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ▫️⁝ لا يوجد منظفيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ▫️⁝ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ▫️⁝ العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته منظف'
texts = usertext..status
else
texts = ' ▫️⁝ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ▫️⁝ العضو » '..userid..''
status  = '\n ▫️⁝ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ▫️⁝ العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من المنظفيه'
texts = usertext..status
else
texts = ' ▫️⁝ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ▫️⁝ العضو » '..userid..''
status  = '\n ▫️⁝ تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح الوزراء' and BasicConstructor(msg) then
database:del(bot_id..'WZ:EE:R'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ▫️⁝ تم مسح الوزراء')
end
if text == ("الوزراء") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'WZ:EE:R'..msg.chat_id_)
t = "\n ▫️⁝ قائمة الوزراء \n≪━━━━━━AST━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ▫️⁝ لا يوجد الوزراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للوزراء") or text == ("صيح الوزراء") then
local list = database:smembers(bot_id..'WZ:EE:R'..msg.chat_id_)
t = "\n ▫️⁝ وينكم يالوزراء تعالو ☆ \n≪━━━━━━AST━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ▫️⁝ لا يوجد وزيريه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع وزير") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'WZ:EE:R'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته وزير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع وزير @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع وزير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ▫️⁝ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'WZ:EE:R'..msg.chat_id_, result.id_)
usertext = '\n ▫️⁝ العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته وزير'
texts = usertext..status
else
texts = ' ▫️⁝ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع وزير (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع وزير (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ▫️⁝ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'WZ:EE:R'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم ترقيته وزير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ▫️⁝ العضو » '..userid..''
status  = '\n ▫️⁝ تم ترقيته وزير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل وزير") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'WZ:EE:R'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من الوزراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل وزير @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل وزير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'WZ:EE:R'..msg.chat_id_, result.id_)
usertext = '\n ▫️⁝ العضو » ['..result.title_..'](t.me/'..(username or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من الوزراء'
texts = usertext..status
else
texts = ' ▫️⁝ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل وزير (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل وزير (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ▫️⁝ لا تستطيع استخدام البوت \n  ▫️⁝ يرجى الاشتراك بالقناه اولا \n  ▫️⁝ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'WZ:EE:R'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ▫️⁝ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..')'
status  = '\n ▫️⁝ تم تنزيله من الوزراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ▫️⁝ العضو » '..userid..''
status  = '\n ▫️⁝ تم تنزيله من الوزراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,'⚠️| تم مسح رسائلك جميعها'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'💌|  عدد رسائلك هنا* » { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}*' ) 
end 
if text == 'تفعيل الاذاعه' and SudoBot(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n🔘| تم تفعيل الاذاعه ' 
else
Text = '\n💠| بالتاكيد تم تفعيل الاذاعه '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and SudoBot(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n🔘| تم تعطيل الاذاعه' 
else
Text = '\n💠| بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n📞| تم تفعيل التواصل ' 
else
Text = '\n💠| بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n📞| تم تعطيل التواصل' 
else
Text = '\n💠| بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n🔰| تم تفعيل البوت الخدمي ' 
else
Text = '\n💠| بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n🔰| تم تعطيل البوت الخدمي' 
else
Text = '\n💠| بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التنظيف' and Manager(msg) then   
database:del(bot_id..'lock:del'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'☑┇تم تفعيل التنظيف') 
end
if text == 'تعطيل التنظيف' and Manager(msg) then  
database:set(bot_id..'lock:del'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'☑┇تم تعطيل التنظيف') 
end
if text and text:match('^مسح (%d+)$') and cleaner(msg) then
local num = tonumber(text:match('^مسح (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,'🔘| تستطيع التنظيف ل1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'🔘| تم حذف *{'..num..'}* من رسائل القروب')  
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) or (msg.content_.voice_) or (msg.content_.audio_) and msg.reply_to_message_id_ == 0 then      
database:sadd(bot_id.."allM"..msg.chat_id_, msg.id_)
end
if text == ("مسح الميديا") and Constructor(msg) or text == ("تنظيف الميديا") and Constructor(msg) or text == ("حذف الميديا") and Constructor(msg) then  
local list = database:smembers(bot_id.."allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "✔┇ تم مسح "..k.." من الوسائط الموجوده"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "✔┇ لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and Constructor(msg) then  
local num = database:smembers(bot_id.."allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "✔┇ عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = "✔┇ لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "تنظيف التعديل" and Constructor(msg) or text == "حذف التعديل" and Constructor(msg) or text == "مسح التعديل" and Constructor(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'✔┇ تم حذف جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"💠| ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'الاسطورة').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'الاسطورة')
local MARCOS_Msg = {
'روووح '..Namebot..'',
'♥️ لبى من يصوت ',
'وش بغيت',
'هلا رووووح '..Namebot..' انت',
'هلا بعد قلبي😎',
'آمــــر',
'عـيـون '..Namebot..'',
'لـبـيـة',
'شعندك !؟ 👀',
'هـــلا',
'اطلق من ينادي',
'ٲمـر شتبي',
'اطلق من ينادي لبيه ياعيون '..Namebot..' 😍',
}
send(msg.chat_id_, msg.id_,'['..MARCOS_Msg[math.random(#MARCOS_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥| ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⚠️| للخروج ارسل الغاء ") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"📥| ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⚠️| للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"💠| ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"💠| ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⚠| البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية تغير اسم المجموعه")  
else
sebd(msg.chat_id_,msg.id_,'📮| تم تغيير اسم المجموعه الى {['..Name..']}')  
end
end,nil) 
end

if text == "تاك للكل" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,MARCOS)
local t = "\n🔘| قائمة الاعضاء \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
x = 0
local list = MARCOS.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"⚠️| لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n🔖| تم تنزيل الشخص من الرتب التاليه \n💠| { "..dev..''..crr..''..cr..''..own..''..mod..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n⚠️| ليس لديه رتب حتى استطيع تنزيله \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_,"📌| تم مسح ردود المطور")
end

if text == ("ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n🔘| قائمة ردود المطور \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه 🎭'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه 📢'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق 🃏'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله ✉'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره 🎇'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو 📹'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف 📁'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه 🎵'
end
text = text..""..k.." >> ("..v..") » {"..db.."}\n"
end
if #list == 0 then
text = "⚠️| لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'📌| تم حفظ الرد بنجاح')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'📥| ✔️ ارسل الرد الذي تريده سواء كان {صوره,فيديو,متحركه,ملصق,بصمه,صوت}')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'📌| تم ازالة الرد من قائمه ردود المطور')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد عام' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'📥|  تمام الحين ارسل الكلمه الي تبي تضيفها')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد عام' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'📫| حلوو ارسل الكلمه التي تريد حذفها')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"📌| تم مسح ردود المدير")
end

if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = "💠| قائمه ردود المدير \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه ??'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه 📢'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق 🃏'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله ✉'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره 🎇'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو 📹'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف 📁'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه 🎵'
end
text = text..""..k..">> ("..v..") » {"..db.."}\n"
end
if #list == 0 then
text = "⚠️| لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'📌| تم حفظ الرد بنجاح')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'📥| ✔️ ارسل الرد الذي تريده سواء كان {صوره,فيديو,متحركه,ملصق,بصمه,صوت}')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,'📌| تم ازالة الرد ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'💠|  تمام الحين ارسل الكلمه الي تبي تضيفها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'🚸| حلوو ارسل الكلمه التي تريد حذفها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
-----------
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n ✓ : ارسل لي الكلمه الان')
database:set(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:NightRang:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:NightRang:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:NightRang:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"✓ : تم حذف الرد من الردود المتعدده")
database:del(bot_id..'botss:NightRang:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:NightRang:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:NightRang:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:NightRang:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:NightRang:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and SudoBot(msg) then 
local list = database:smembers(bot_id.."botss:NightRang:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:NightRang:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:NightRang:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:NightRang:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:NightRang:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✓ : تم حذف الردود المتعدده")
end
if text == ("الردود المتعدده") and SudoBot(msg) then 
local list = database:smembers(bot_id.."botss:NightRang:List:Rd:Sudo")
text = "\nقائمة الردود المتعدده \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and SudoBot(msg) then 
database:set(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"\n 📩 : حسنآ ارسل الرد الذي تريد\n📩 : اضافتة يمكنك اضافـة\n📩 : 3 ردود علئ رد واحد\n")
end
if text == "حذف رد متعدد" and SudoBot(msg) then 
database:set(bot_id.."botss:NightRang:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"✓ : ارسل الان الكلمه لحذفها")
end
if text then  
local test = database:get(bot_id.."botss:NightRang:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:NightRang:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✓ : تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:NightRang:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:NightRang:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✓ : تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:NightRang:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:NightRang:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:NightRang:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✓ : تم حفظ الردود")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:NightRang:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:NightRang:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:NightRang:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'الاسطورة').."مغاداره" or text == 'مغاندره' or text == 'مةنغادرة' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'رح اشتاق لكم يلا معسلامه 😹😿') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == "بوت" or text == "الاسطورة"  then  
local ASTORH_Msg = {
'ها عمري ♥',
'شعندك !؟ 👀',
'انت البوت',
'نادني بااسمي ',
'عيون البوت انت ',
'اعمى ماتشوف اسمي '..Namebot..'',
'اسمي '..Namebot..'',
'ياخي انا مو بوت',
'عندي اسم ياقلبي',
'انت البوت',
'بوت بعينك',
'هلوات اذا عندك قروبات ضيفني🤷🏼‍♀️❤️',
'اسممممممي '..Namebot..'',
}
send(msg.chat_id_, msg.id_,'['..ASTORH_Msg[math.random(#ASTORH_Msg)]..']') 
return false
end
if text == 'الاحصائيات' or text == 'المجموعات' or text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '🔰| احصائيات البوت\n'..'👥| عدد المجموعات »{'..Groups..'}'..'\n👤| عدد المشتركين »{'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'مسح المشتركين' and is_devtaha(msg) then   
local list = tahadevstorm:smembers(DEVSTOR..'usersbot')   
local pv = 0
for k,v in pairs(list) do    
tahadevstorm:srem(DEVSTOR..'usersbot',v)  
pv = pv + 1
end   
storm_sendMsg(msg.chat_id_, msg.id_, 1, '*🎲¦ تم مسح » ❪'..pv..'❫ من المشتركين *\n', 1, 'md') 
end  
if text and text == "تفعيل تاك المشرفين" and Manager(msg) then 
database:set(bot_id.."S0DRG:Tag:Admins:"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,"✅︙تم تفعيل تاك المشرفين")
end
if text and text == "تعطيل تاك المشرفين" and Manager(msg) then 
database:del(bot_id.."S0DRG:Tag:Admins:"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "❎︙تم تعطيل تاك المشرفين")
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
if database:get(bot_id.."S0DRG:Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end --
local t = "\n👤| المستخدم ~ ["..User_id .."] يصيح المشرفين \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end


if text == "الساعه" then
local ramsesj20 = "\n🕰️| الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n📆| التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
if text == 'تفعيل المغادره' and SudoBot(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '🔘| تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = '💠| بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and SudoBot(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '🔘| تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = '💠| بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = '🎗️| تم تفعيل ردود المدير'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = '📮| تم تفعيل ردود المدير'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n⚠️| تم تعطيل ردود المدير' 
else
Text = '\n💠| بالتاكيد تم تعطيل ردود المدير'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n🔘| تم تفعيل ردود المطور' 
else
Text = '\n💠| بالتاكيد تم تفعيل ردود المطور'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n⚠️| تم تعطيل ردود المطور' 
else
Text = '\n💠| بالتاكيد تم تعطيل ردود المطور'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n🔰| تم تفعيل الايدي' 
else
Text = '\n💠| بالتاكيد تم تفعيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n🚸| تم تعطيل الايدي' 
else
Text = '\n💠| بالتاكيد تم تعطيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n🔘| تم تفعيل الايدي بالصور ' 
else
Text = '\n💠| بالتاكيد تم تفعيل الايدي بالصوره '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n🔘| تم تعطيل الايدي بالصوره' 
else
Text = '\n💠| بالتاكيد تم تعطيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n🔰| تم تفعيل الحظر ' 
else
Text = '\n💠|  بالتاكيد تم تفعيل الحظر '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n🔰| تم تعطيل الحظر' 
else
Text = '\n💠| بالتاكيد تم تعطيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n🔘| تم تفعيل الرفع ' 
else
Text = '\n📮| بالتاكيد تم تفعيل الرفع '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n📌| تم تعطيل الرفع' 
else
Text = '\n💠| بالتاكيد تم تعطيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'🎟️| ايديه »(`'..iduser..'`)\n🎭| معرفه »('..username..')\n📌| رتبته »('..rtp..')\n✏| تعديلاته »('..edit..')\n🗳️| النقاط »('..NUMPGAME..')\n🔖| جهاته »('..Contact..')\n📨| رسائله »('..Msguser..')')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'🎟️| ايديه »(`'..iduser..'`)\n🎭| معرفه »('..username..')\n📌| رتبته »('..rtp..')\n✏| تعديلاته »('..edit..')\n🗳️| النقاط »('..NUMPGAME..')\n🔖| جهاته »('..Contact..')\n📨| رسائله »('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'⚠| المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'*📌| رتبتك في البوت* » '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = '*💠| اسمك الاول ← {`'..(result.first_name_)..'`}*'
else
first_name = ''
end   
if result.last_name_ then 
last_name = '🔘| اسمك الثاني ← {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'📮| ايديك » '..msg.sender_user_id_)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'🎟️| الايدي » ('..iduser..')\n📌| المعرف » ('..username..')\n👮‍♂️| الرتبه » ('..rtp..')\n👁️‍🗨️| نوع الكشف » بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'🎟| الايدي » ('..iduser..')\n📌| المعرف » ('..username..')\n👮‍♂️| الرتبه » ('..rtp..')\n👁️‍🗨️| نوع الكشف » بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'✖| المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد القروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"⚠¦ البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local taha = '👤| عدد الادمنيه : '..data.administrator_count_..
'\n\n🚸| عدد المطرودين : '..data.kicked_count_..
'\n\n👥| عدد الاعضاء : '..data.member_count_..
'\n\n💌| عدد رسائل القروب : '..(msg.id_/2097152/0.5)..
'\n\n🔰| اسم المجموعه : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, taha) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*⚠| عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )*')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'⚠| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'⚠| عذرا لا استطيع طرد ادمنية المجموعه') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'*تم تنفيذ طلبك يلا انقلع😂✌️*') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'⚠| امر اطردني تم تعطيله من قبل المدراء ') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'⚠| المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات القنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات البوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات المجموعات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'👤| تعال ياهطف يـبـونـك بـالقـروب 😂 [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'⚠| امر صيح تم تعطيله من قبل المدراء ') 
end
return false
end

if text == 'منو ضافني' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'*🔘| انت منشئ المجموعه*') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '*👤| الشخص الذي قام باضافتك هو* » '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'*📌| انت دخلت عبر الرابط *') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'⚠| امر منو ضافني تم تعطيله من قبل المدراء ') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '🔘| تم تفعيل امر منو ضافني'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '💠| بالتاكيد تم تفعيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n🔘| تم تعطيل امر منو ضافني'
else
Text = '\n💠| بالتاكيد تم تعطيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '🔘| تم تفعيل امر صيح'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '💠| بالتاكيد تم تفعيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n🔘| تم تعطيل امر صيح'
else
Text = '\n💠| بالتاكيد تم تعطيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n🔰| تم تنزيل الكل من الرتب الاتيه \n♻️| المميزين ، الادمنيه ، المدراء ، المنشئين \n')
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = '*🔰| تم تفعيل امر اطردني*'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = '*💠| بالتاكيد تم تفعيل امر اطردني*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n*📌|  تم تعطيل امر اطردني*'
else
Text = '\n*⚠️| بالتاكيد تم تعطيل امر اطردني*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"*📛┇ الصوره معطله*") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_,"🎇┇ عدد صورك   ←  "..result.total_count_.." صوره‌‏ ✨", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 الاسم 𖥲 .
゠𝙼𝚂𝙶 𖨈 الرسائل 𖥲 .
゠𝚂𝚃𝙰 𖨈 الرتبه 𖥲 .
゠𝙸𝙳 𖨈 ايدي 𖥲 .
]],
[[
➭- 𝒔𝒕𝒂𓂅 الرتبه 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 الاسم 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 الرسائل 𓍯. 💕
➭- 𝒊𝒅 𓂅 ايدي 𓍯. 💕
]],
[[
🔘• 𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 ايدي .
🔘• 𝐌𝐒𝐆𝐒 𖠰 الرسائل .
🔘• 𝐔𝐒𝐄𝐑 𖠰 الاسم .
🔘• 𝐒𝐓𝐀𝐒𝐓 𖠰 الرتبه .
🔘• 𝐀𝐔𝐓𝐎 𖠰 التفاعل .
🔘• 𝗘𝗗𝗜𝗧 𖠰 التعديل .
]],
[[
𝐘𝐨𝐮𝐫 𝐈𝐃 ☤♔ - ايدي 
𝐔𝐬𝐞𝐫𝐍𝐚☤♔ - الاسم
𝐒𝐭𝐚𝐬𝐓 ☤♔ - الرتبه 
𝐌𝐬𝐠𝐒☤♔ - الرسائل
]],
[[
‎⿻┊Yor iD 𖠄 ايدي ☆
‌‎⿻┊UsEr 𖠄 الاسم ☆
‌‎⿻┊MsGs 𖠄 الرسائل ☆
‌‎⿻┊StAtS 𖠄 الرتبه ☆
‌‎⿻┊‌‎EdiT 𖠄 التعديل ☆
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : الاسم ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : الرتبه 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : ايدي ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : الرسائل 𓆊
]],
[[
┌ 𝐔𝐒𝐄?? 𖤱 الاسم 𖦴 .
├ 𝐌𝐒𝐆 𖤱 الرسائل 𖦴 .
├ 𝐒𝐓𝐀 𖤱 الرتبه 𖦴 .
└ 𝐈𝐃 𖤱 ايدي 𖦴 .
]],
[[
𓄼🇾🇪 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :الاسم 
𓄼🇾🇪 𝑺𝒕𝒂𝒔𝒕 :الرتبه 
𓄼🇾🇪 𝒊𝒅 :ايدي 
𓄼🇾🇪 𝑮𝒂𝒎𝒆𝑺 :النقاط 
𓄼🇾🇪 𝑴𝒔𝒈𝒔 :الرسائل
]],
[[
❤️|-وف اتفاعل يحلو😍🙈
👨‍👧|- ☆يوزرك الاسم 🎫
💌|- ☆رسائلك الرسائل 💌
🎫|- ☆ايديك ايدي   🥇
🎟|- ☆موقعك الرتبه🌐 
🤸‍♂|- ☆جفصاتك التعديل 🌬
🥉|- ☆تفاعلك التفاعل🚀
🏆|- ☆مجوهراتك النقاط 🕹
🌏|- ☆اشترك يحلو🌐《 قناة الكروب》
]],
[[
➞: 𝒔𝒕𝒂𓂅 الرتبه 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 الاسم 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 الرسائل 𓍯➸💞.
➞: 𝒊𝒅 𓂅 ايدي 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : الاسم 𖣬  
☆•𝐦𝐬𝐠  : الرسائل 𖣬 
☆•𝐬𝐭𝐚 : الرتبه 𖣬 
☆•𝐢𝐝  : ايدي 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : الاسم 𓂅 .
- 𓏬 𝐌𝐬𝐆  : الرسائل 𓂅 .
- 𓏬 𝐒𝐭𝐀 : الرتبه 𓂅 .
- 𓏬 𝐈𝐃 : ايدي 𓂅 .
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , الاسم 
.𖣂 𝙨𝙩𝙖𝙨𝙩 , الرتبه
.𖣂 𝙡𝘿 , ايدي
.𖣂 𝙂𝙖𝙢𝙨 , النقاط
.𖣂 𝙢𝙨𝙂𝙨 , الرسائل
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'🎫| تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then      
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,taha,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (taha.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local tahaa = {
"😍😍😍😍",
"فديت الحلو🤗",
"يالــبـيـه💋💘",
" قديمه غيرها😒",
"وش ذا الزين 💋",
"يالبيه😘🌷",
"مـنـور♥",
" كشخه ❤️",
"ممكن سلفي😻",
"اطلق ايدي😍",
"احلا ايدي🥰",
}

local rdphoto = tahaa[math.random(#tahaa)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('تعليق الصوره',rdphoto) 
get_id_text = get_id_text:gsub('ايدي',iduser) 
get_id_text = get_id_text:gsub('الاسم',username) 
get_id_text = get_id_text:gsub('الرسائل',Msguser) 
get_id_text = get_id_text:gsub('التعديل',edit) 
get_id_text = get_id_text:gsub('الرتبه',rtp) 
get_id_text = get_id_text:gsub('التفاعل',interaction) 
get_id_text = get_id_text:gsub('النقاط',NUMPGAME) 
get_id_text = get_id_text:gsub('الصور',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, taha.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n⚠️| ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, taha.photos_[0].sizes_[1].photo_.persistent_id_,'𓆰'..rdphoto..'\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n• |𝗜𝗗  ⁞ '..msg.sender_user_id_..'\n• |𝗨𝗦𝗘 ⁞ '..username..'\n• |𝗦𝗧𝗔  ⁞ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n• |𝗦𝗧𝗔  ⁞ '..rtpa..'\n• |𝗔𝗨𝗧𝗢 ⁞'..Total_Msg(Msguser)..'\n• |𝗠𝗦𝗚  ⁞ '..Msguser..'\n• |𝗣𝗢𝗜𝗡𝗧𝗦 ⁞ '..NUMPGAME..'\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n')   
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n• |𝗜𝗗  ⁞'..msg.sender_user_id_..'\n• |𝗨𝗦𝗘 ⁞ '..username..'\n• |𝗦𝗧𝗔  ⁞'..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n• |𝗦𝗧𝗔  ⁞ '..rtpa..'\n• |𝗔𝗨𝗧𝗢 ⁞'..Total_Msg(Msguser)..'\n• |𝗠𝗦𝗚  ⁞ '..Msguser..'\n• |𝗣𝗢𝗜𝗡𝗧𝗦 ⁞ '..NUMPGAME..']\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n')   
else
send(msg.chat_id_, msg.id_, '\n⚠️| الصوره ←  ليس لديك صور في حسابك 🍃'..'[\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n• |𝗜𝗗  ⁞'..msg.sender_user_id_..'\n• |𝗨𝗦𝗘 ⁞ '..username..'\n• |𝗦𝗧𝗔  ⁞ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n• |𝗦𝗧𝗔  ⁞ '..rtpa..'\n• |𝗔𝗨𝗧𝗢 ⁞'..Total_Msg(Msguser)..'\n• |𝗠𝗦𝗚  ⁞'..Msguser..'\n• |𝗣𝗢𝗜𝗡𝗧𝗦 ⁞ '..NUMPGAME..']\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n')   
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('تعليق الصوره',rdphoto) 
get_id_text = get_id_text:gsub('ايدي',iduser) 
get_id_text = get_id_text:gsub('الاسم',username) 
get_id_text = get_id_text:gsub('الرسائل',Msguser) 
get_id_text = get_id_text:gsub('التعديل',edit) 
get_id_text = get_id_text:gsub('الرتبه',rtp) 
get_id_text = get_id_text:gsub('التفاعل',interaction) 
get_id_text = get_id_text:gsub('النقاط',NUMPGAME) 
get_id_text = get_id_text:gsub('الصور',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n• |𝗜𝗗  ⁞ '..msg.sender_user_id_..'\n• |𝗨??𝗘 ⁞ '..username..'\n• |𝗦𝗧𝗔  ⁞ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n• |𝗦𝗧𝗔  ⁞ '..rtpa..'\n• |𝗔𝗨𝗧𝗢 ⁞'..Total_Msg(Msguser)..'\n• |𝗠𝗦𝗚  ⁞ '..Msguser..'\n• |𝗣𝗢𝗜𝗡𝗧𝗦 ⁞ '..NUMPGAME..']\n༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺\n')   
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'تعديلاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '*⚠️| لم تقم بالتعديل في الكتابه ليست لديك تعديلات*'
else
Text = '🚸| عدد تعديلاتك *» { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح تعديلاتي" or text == "حذف تعديلاتي" then  
send(msg.chat_id_, msg.id_,'📌| تم مسح تعديلاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,'📌| تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then 
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '*⚠️| لم تقم بااضافة اي احد*'
else
Text = '📮| عدد جهاتك *» { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'📌| عدد المشتركين الان » ( '..#pv..' )\n🔰| تم ازالة » ( '..sendok..' ) من المشتركين\n📥| الان عدد المشتركين الحقيقي » ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف القروبات" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا يوجد مجموعات وهميه في البوت\n')   
else
local MARCOS = (w + q)
local sendok = #group - MARCOS
if q == 0 then
MARCOS = ''
else
MARCOS = '\n🔰| تم ازالة » { '..q..' } مجموعات من البوت'
end
if w == 0 then
MARCOSk = ''
else
MARCOSk = '\n⚠️| تم ازالة » {'..w..'} مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'📌| عدد المجموعات الان » { '..#group..' }'..MARCOSk..''..MARCOS..'\n*🔘| الان عدد المجموعات الحقيقي » { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end

if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "📮| تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"🎗️| تم اضافة له *{"..numadded..'}* من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "📮| تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "??| تم اضافة له {"..numadded..'} من النقاط', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
taha = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,taha)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '✉¦ ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
taha = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,taha)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '🔘| ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,"🚸| تم اضافة له *{"..Num..'}* من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n📥| تم اضافة له *{"..Num..'}* من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '📌| لم تلعب اي لعبه للحصول على النقاط'
else
Text = '📮╿*عدد النقاط التي ربحتها هي » { '..Num..' } نقطه \n📬╽تسطيع بيع نقاطك ولحصول على (50) رساله مقابل كل نقطه من النقاط*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥¦ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ??¦ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*📮| لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'📮| * ليس لديك نقاط في الالعاب \n🎗️| اذا كنت تريد ربح نقاط \n📌| ارسل الالعاب وابدأ اللعب !*') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n📮| * ليس لديك نقاط بهاذ العبه \n🔘| لزيادة نقاطك في اللعبه \n📌| ارسل الالعاب وابدأ اللعب !*') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'🚸| تم خصم *» { '..NUMPY..' }* من نقاطك \n💌| وتم اضافة* » { '..(NUMPY * 50)..' }* من الرسائل')
end 
return false 
end
if text == 'فحص البوت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end 
send(msg.chat_id_,msg.id_,'\n📌| اهلا عزيزي البوت هنا ادمن'..'\n🎗️|  وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n📝|  تغير معلومات المجموعه ↞ ❴ '..info..' ❵'..'\n💌|  حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n💠|  حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n♻|  دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n🔘|  تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n🔰|  اضافة مشرفين جدد ↞ ❴ '..promote..' ❵') 
end
end
end

if text:match("^قول (.*)$") then
local txt = {string.match(text, "^(قول) (.*)$")}
send(msg.chat_id_, 0, txt[2], "md")
local id = msg.id_
local msgs = {
[0] = id
}
local chat = msg.chat_id_
delete_msg(chat, msgs)
end
if text:match("^قولي (.*)$") then
local txt = {string.match(text, "^(قولي) (.*)$")}
send(msg.chat_id_, 0, txt[2], "md")
local id = msg.id_
local msgs = {
[0] = id
}
local chat = msg.chat_id_
delete_msg(chat, msgs)
end

if text and text:match("^تغير رتبة المطور (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة المطور الى » "..Teext)
end
if text and text:match("^تغير رتبة منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة المنشئ الاساسي الى » "..Teext)
end
if text and text:match("^تغير رتبة المالك (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 🔷|تم تغير رتبة المالك الى » "..Teext)
end
if text and text:match("^تغير رتبة المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة المنشئ الى » "..Teext)
end
if text and text:match("^تغير رتبة المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة المدير الى » "..Teext)
end
if text and text:match("^تغير رتبة الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة الادمن الى » "..Teext)
end
if text and text:match("^تغير رتبة المميز (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة المميز الى » "..Teext)
end
if text and text:match("^تغير رتبة العضو (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رتبة العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"👥| تم تغير رتبة العضو الى » "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮| تم حفظ الكليشه بنجاح')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end

if text == 'استعاده الاوامر' and SudoBot(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
send(msg.chat_id_, msg.id_, '🔘| تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🎗️| الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘| الان يمكنك ارسال الكليشه م8')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'الاوامر' or text == 'القائمه' or text == 'القائمة' or text == 'مساعده' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'• عذرا الاوامر هذا لا تخصك ') 
return false
end
local Text =[[
🔴| اهلا بك في اوامر البوت  
●ـ▬ـ▬▬ஜ۩۞۩ஜ▬▬ـ▬ـ●
🔖| م1 » لـعــرض اوامر الحمايه 
🔖| م2 » لـعــرض اوامر الادمنيه 
🔖| م3 » لـعــرض اوامر المدراء 
🔖| م4 » لـعــرض اوامر المنشئين
🔖| م5 » لـعــرض اوامر مطور اساسي
🔖| م6 » لـعــرض اوامر التحشيش
🔖| م7 » لـعــرض اوامر مطورين البوت
🔖| م8 » لـعــرض اوامر الاعضاء
●ـ▬ـ▬▬ஜ۩۞۩ஜ▬▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == 'الاللللوامرا' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالادمنيه\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help_text')
Text = [[
🔴| اهلا بك في اوامر البوت  
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| م1 » اوامر الحمايه 
🔖| م2 » اوامر الادمنيه 
🔖| م3 » اوامر المدراء 
🔖| م4 » اوامر المنشئين
🔖| م5 » اوامر مطور اساسي
🔖| م6 » اوامر التحشيش
🔖| م7 » اوامر مطورين البوت
🔖| م8 » اوامر الاعضاء
🔖| الالعاب » لعرض العاب السورس
🔖|المطور » مـطـور البـوت
🔖|السورس » سورس البوت
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م1' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالادمنيه\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help1_text')
Text = [[
🎗️| اهلا بك عزيزي √
⚜️| اوامر حماية المجموعه⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| قفل | فتح + الامر 
⚠️| ❴بالكتم,بالتقييد,بالطرد❵
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔒| قفل ⇚ فتح الاضافه
🔒| قفل ⇚ فتح الدردشه
🔒| قفل ⇚ فتح الدخول
🔒| قفل ⇚ فتح البوتات
🔒| قفل ⇚ فتح الاشعارات
🔒| قفل ⇚ فتح التعديل
🔒| قفل ⇚ فتح تعديل الميديا
🔒| قفل ⇚ فتح الروابط
🔒| قفل ⇚ فتح المعرفات
🔒| قفل ⇚ فتح التاك
🔒| قفل ⇚ فتح الشارحه
🔒| قفل ⇚ فتح الملصقات
🔒| قفل ⇚ فتح المتحركه
🔒| قفل ⇚ فتح الفيديو
🔒| قفل ⇚ فتح الصور
🔒| قفل ⇚ فتح الالعاب
🔒| قفل ⇚ فتح الاغاني
🔒| قفل ⇚ فتح الصوت
🔒| قفل ⇚ فتح الفشار
🔒| قفل ⇚ فتح الفارسيه
🔒| قفل ⇚ فتح الكيبورد
🔒| قفل ⇚ فتح التوجيه
🔒| قفل ⇚ فتح الملفات
🔒| قفل ⇚ فتح السيلفي
🔒| قفل ⇚ فتح الجهات
🔒| قفل ⇚ فتح الماركداون
🔒| قفل ⇚ فتح الكلايش
🔒| قفل ⇚ فتح التكرار
🔒| قفل ⇚ فتح التفليش
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م2' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالادمنيه\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help2_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔴| اوامر الادمنيه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| رفع/تنزيل مميز
🔖| المميزين
🔖|حظر/الغاء حظر
🔖| المحظورين
🔴| كتم/الغاء كتم
🔴| المكتومين
🔴| تعطيل + تفعيل التحويل
🔴| تعطيل + تفعيل الردود
🔴| تعطيل + تفعيل التنظيف
🔴| تعطيل + تفعيل معاني الاسماء
🔴| تعطيل + تفعيل الابراج
🔴| تعطيل + تفعيل حساب العمر
🔴| تعطيل + تفعيل الزخرفه
🔴| تقييد + الرقم + سَـاعه
🔴| تقييد + الرقم + يوم
🔴| تقييد + الرقم + دقيقه
🔴| كتم + الرقم + ساعه
🔴| كتم + الرقم + يوم
🔴| كتم + الرقم + دقيقه
📌| تقييد/الغاء تقييد
📌|طرد
📌| طرد + مسح البوتات
📌| تثبيت/الغاء تثبيت
📮| ضع تكرار + العدد
📮| الترحيب
📮| تفعيل/تعطيل الترحيب
📮| منع/الغاء منع
📃| قائمه المنع
📃| كشف البوتات
📃| الصلاحيات
📃| كشف / برد ⇚ بمعرف
💠| اضف صلاحيه + اسم الصلاحيه
💠| مسح صلاحيه + اسم الصلاحيه
💠| تعطيل اوامر التحشيش
💠| تفعيل اوامر التحشيش
🔮| تفعيل/تعطيل صورتي
🔮| صورتي لجلب صورة حسابك
📁| تاك للكل
📁| اعدادات المجموعه
📁| عدد القروب
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔴| مسح + الامر
🔰| المميزين ، المحظورين ، المكتومين
🔰| الترحيب ، الرابط ، القوانين
🔰| قائمه المنع ، البوتات ،
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔺| ضع + الامر
🔺| رابط ، ترحيب ، قوانين
🔺|صوره ، وصف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end

if text == 'م3' then
if not Manager(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالمدراء\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help3_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔖| اوامر مدراء المجموعه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📍| تغير امر الاوامر
📍| تغير امر م1 › الحد م8
📍| استعاده الاوامر
🔹| رفع/تنزيل ادمن
🔹| الادمنيه
🔹| مسح الادمنيه
🔹| تاك لادمنيه
🔹| رفع القيود
🔹| كشف القيود
💭| تعين الايدي
 💭| تغير الايدي
💭| مسح الايدي 
💭| تنظيف + العدد
💭| ضع اسم + الاسم
💭| تنزيل الكل
💭| منع + برد
❴الصور + متحركه + ملصق❵
🗑️| مسح قائمه منع الصور
🗑️| مسح قائمه منع الملصقات
🗑️| مسح قائمه منع المتحركات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
⚡| مسح ردود المدير
⚡| ردود المدير
⚡| اضف/حذف رد
💠| تغير رتبة المطور + اسم
💠| تغير رتبة منشئ الاساسي + اسم
💠| تغير رتبة المنشئ + اسم
💠| تغير رتبة المدير + اسم
💠| تغير رتبة الادمن + اسم
💠| تغير رتبة المميز + اسم
💠| تغير رتبة العضو + اسم
📮| تعطيل/تفعيل ردود المدير
📮| تعطيل/تفعيل ردود المطور
📮| تعطيل/تفعيل الايدي
📮| تعطيل/تفعيل الايدي بالصوره
📮| تعطيل/تفعيل الالعاب
🔴| تعطيل/تفعيل اطردني
🔴| تعطيل/تفعيل صيح
🔴| تعطيل/تفعيل ضافني
🔴| تعطيل / تفعيل الرابط 
🔴| تعطيل / تفعيل all
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●

]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م4' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالمنشئين\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help4_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔖| اوامر المنشئين للمجموعه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💭| اضف امر
💭| حذف امر
📍| اسم بوت + الرتبه
📍| حذف الاوامر المضافه
📍| الاوامر المضافه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔺| تنزيل جميع الرتب
🔺| مسح المنشئين
🔺| رفع/تنزيل منشئ
🔺| المنشئين
🔺| رفع/تنزيل مدير
🔺| المدراء
🔺| مسح المدراء
🔺| مسح المنظفين
🔺| مسح الميديا
🔺| مسح التعديل
🔺| رفع الادمنيه
👨‍✈️| وضع لـقـب + اللقب
👨‍✈️| رفع /تنزيل وزير
🔴| رفع مـنـظـف
🔴| تنزيل مـنـظـف
🔴| المنظفين
🔴| رفع مشرف
🔴| تنزيل مشرف
🔴| رفع ادمن بكل الصلاحيات
🔴| تنزيل ادمن بكل الصلاحيات
🔷| تفعيل/تعطيل الحظر
🔷| تفعيل/تعطيل الرفع 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م5' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالمطور الاساسي\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help5_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔘| اوامر مطور الاساسي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
⚡| تفعيل
⚡| تعطيل
📌| مسح الاساسين
📌| المنشئين الاساسين
📌| رفع/تنزيل منشئ اساسي
📌| مسح المطورين
📌| المطورين
??| رفع | تنزيل مطور
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💲| اسم البوت + مغادره
💲| مغادره/ مغادرة
🔍| اسم بوت + الرتبه
🔍| تحديث السورس
📍| حضر عام
📍| الغاء العام
📍| قائمه العام
📍| مسح قائمه العام
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
 ⚜️| المتجر 
⚜️| متجر الملفات
⚜️| الملفات
⚜️| مسح الملفات
⚜️| تعطيل + تفعيل + اسم ملف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| اذاعه خاص
🔖| اذاعه
🔖| اذاعه بالتوجيه
🔖| اذاعه بالتوجيه خاص
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📥|جلب نسخه احتياطيه
📤| رفع النسخه الاحتياطيه
🔴| ضع عدد الاعضاء + العدد
🔴| ضع كليشه المطور
🔹| تفعيل/تعطيل الاذاعه
🔹| تفعيل/تعطيل البوت الخدمي
🔹| تفعيل/تعطيل التواصل
🔰| تغير اسم البوت
🔰| اضف/حذف رد متعدد
🔰| اضف/حذف رد عام
🔰| ردود المطور
🔰| مسح ردود المطور
🔰| الردود المتعدده
🔰| مسح الردود المتعدده
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💠| الاشتراك الاجباري
💠| تعطيل الاشتراك الاجباري
💠| تفعيل الاشتراك الاجباري
💠| حذف رساله الاشتراك
💠| تغير رساله الاشتراك
💠| تغير الاشتراك
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔆| الاحصائيات
🔆| تفعيل/تعطيل المغادره
🔆| تنظيف المشتركين
🔆| تنظيف القروبات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م6' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالادمنيه\n??| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help6_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔴| اوامر التحشيش كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📌| رفع + تنزيل ⇚ الامر
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🦓| رفع + تنزيل ⇚ حمار
🦓| تاك للحمير ⇐ تنزيل الحمير
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐐| رفع + تنزيل ⇚ صخل
🐐| تاك لصخوله ⇐ تنزيل الصخوله
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐶| رفع + تنزيل ⇚ كلب
🐶| تاك للكلاب ⇐ تنزيل الكلاب
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐒| رفع + تنزيل ⇚ قرد 
🐒| تاك للقرود ⇐ تنزيل القرود
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐂| رفع + تنزيل ⇚ بقره
🐂| تاك للبقر ⇐ تنزيل البقر
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐎| رفع + تنزيل ⇚ حصان
🐎| تاك للاحصنه ⇐ تنزيل الاحصنه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐏| رفع + تنزيل ⇚ نعجه
🐏| تاك لنعاج ⇐ تنزيل النعاج
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐊| رفع + تنزيل ⇚ زاحف 
🐊| تاك لزواحف ⇐ تنزيل الزواحف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐔| رفع + تنزيل ⇚ دجاجه
🐔| تاك لدجاج ⇐ تنزيل الدجاج
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
👰| رفـع + تنزيل ⇐ زوجتي
👰| تنزيل زوجاتي ⇐ تاك للزوجات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🙋‍♂️| رفـع + تنزيل ⇐ زوجي
🙋‍♂️| تنزيل ازواجي ⇐ تاك لزوجي
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
❤️| رفـع + تنزيل ⇐ لقلبي
❤️| تنزيل قلبي ⇐ تاك لقلبي
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م7' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالمطورين\n🔖| ارسل {م8} لعرض اوامر الاعضاء') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help7_text')
Text = [[
🎗️| اهلا بك عزيزي √
🔖| اوامر المطورين البوت كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📮| تفعيل ⇚ تعطيل 
📮| القروبات ⇚ المشتركين 
📮| رفع ⇚ تنزيل منشئ اساسي
📮| مسح الاساسين ⇚ المنشئين الاساسين
📮| مسح المنشئين ⇚ المنشئين
🔹| اسم البوت + مغادره
🔹| اذاعه / اذا كان مطور اساسي مفعلها
🔹| ردود المطور 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م8' then
local help_text = database:get(bot_id..'help8_text')
Text = [[
🎗️| اهلا بك عزيزي √
⇓⇓| اوامر الاعضاء كتالي⇓⇓
🔘| عرض معلوماتك ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| قول + الكلمة
🔖| رسايلي ⇚ مسح رسايلي 
🔖| رتبتي ⇚ تعديلاتي 
🔖| مسح تعديلاتي ⇚ المنشئ 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔘| اوآمر المجموعه ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔅| الرابط ⇚ القوانين – الترحيب
🔅|  ايدي ⇚ اطردني 
🔅| اسمي ⇚ المطور  
🔅| كشف / برد بالمعرف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔘| اسم البوت + الامر ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🚸| بوسه بالرد 
📩| مقالات
✳️| انصحني
📩| صراحة/صراحه
📩| نكت / نكته
🚫| بوسني للمطور
🚫| مصني للمطور
🚸| مصه بالرد
🚸| رزله بالرد 
🚸| وش رايك بهاذا بالرد
🚸| وش رايك بهاذي بالرد
🚸| تحبني⇐احبك
🚸| تحب هذا
🔷| نسبه الحب
🔷| نسبه الكره
🔷| نسبه الرجوله
🔷| نسبه الانوثه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == "وش رايك بهاذا" or text == "وش رايك بهاذ" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"حبيب '..Namebot..' ♥"," نشبه وماعنده سالفه😂😶","كثير كلام😹","والنعم والله♥","كفوووو ♥"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "وش رايك بهاذي" or text == "وش رايك بهذي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دور حلوين ????","شـيـخـة الـشـيـخـات 🙈 ☹️😾","دلـوعـــة القروب🙈 😶😂"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تعال لا اصنك لو بهاي 👞👈","ميستاهل اتعب نفسي وياه لانه دجاجه","اتركه ياقلبي هاذا  نشبه وماعنده سالفه😂🤣"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" or text == "بوسني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋😘","ريحته يـــــعععععع😌😹","خدك نضيف 😂","البوسه بالف حبي 🌝💋","خلي يزحفلي وابوسه ??😻","كل شوي ابوسه كافي 😏","ماابوسه والله هذا خروف🐏","امووووووووح بوسه اسلاميه😂😚💋"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' 🔷|تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' 🔷|بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n 🔷|تم تعطيل امر @all'
else
Text = '\n 🔷|بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "all" and BasicConstructor(msg) or text == "@all" and BasicConstructor(msg) then
if database:get(bot_id.."all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"⚠|انتظر 5 دقائق لعمل تاك مرة اخرى 🌚??")
end
database:setex(bot_id..'all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,amir)
x = 0
tags = 0
local list = amir.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
if text == "تحبني" or text == "احبك" or text == "تحبيني" then  
local RAADLOVE = {
"\nااهواك🖤",
"\nمتيم بك",
"\nاعشقك مح 😍💋",
"\nاي احبك 😍❤️",
"\nماحبك 😌🖖",
"\nامـــوت فيك ☹️",
"\nاذا قلت لك احبك وش تستفيد 😕❤️",
"\nماحب غيرك 🙊💔",
}
send(msg.chat_id_, msg.id_,'['..RAADLOVE[math.random(#RAADLOVE)]..']') 
return false
end
if text == "هلو" and SudoBot(msg) or text == "ها" and SudoBot(msg) then  
local RAADEV = {
"\nهلا تاج راسي المطور 😎",
"\nهلا عزيزي المطور 😽❤️",
"\nاهلا سيدي المطور 😍",
"\nهلوات نورت مطوري 😍",
}
send(msg.chat_id_, msg.id_,'['..RAADEV[math.random(#RAADEV)]..']') 
return false
end
if text == "بوسني" and SudoBot(msg) or text == "مصني" and SudoBot(msg) then  
local BOSNI = {
"\nاموووووووح لخدك مطوري💋",
"\nاموووووووح ياعشقي💋",
"\nاموووووووح يقلبي مطوري💋",
"\nامووووح حبيب قلبي مطوري💋",
}
send(msg.chat_id_, msg.id_,'['..BOSNI[math.random(#BOSNI)]..']') 
return false
end
if text == "هلا" or text == "مرحبا" then  
local YAFAEVIP = {
"\nنوووورت حبي",
"\nاهلآ وسهلآ",
"\nمرحبتين😌",
"\nاهلا حبي 😶",
"\nهــلا ضـلـعـي😍",
"\nُهــلُا بّـــكِـ 😌",
"\nُهلُا وَالُلُُه نَوَرَرَتْ 😌",
"هـلا بـكـ زووود ❤☺",
}
send(msg.chat_id_, msg.id_,'['..YAFAEVIP[math.random(#YAFAEVIP)]..']') 
return false
end
if text == "هههههههههه" or text == "ههههههه" or text == "ههههه" or text == "ههههههههههههههه" or text == "هههههههههههههه" then
local haha = {
"دُۈۈۈمٌ يَـــآرَبّ",
"دوَوّم يــــ غٓـاليَ ــــا",
"عَسَـــ دُوَوّوِوُمْ ـــآھ",
" ضحكنا معاك 🤪",
"انَ شِاءالُلُُه دِايَــمٌـُهـ",
"اضحـكـ جعل مايـضـحـكـ غيـركـ",
"لا تضحك مجامله 🧐",
"عمري يالي يضحكون يا ناس 🤭",
}
send(msg.chat_id_, msg.id_,'['..haha[math.random(#haha)]..']') 
return false
end
if text == "هههههههههههه" or text == "ههههههههه" or text == "ههههههههههههه" or text == "هههههههه" or text == "ههههههههههههههههههه" then
local hahah = {
"دُۈۈۈمٌ يَـــآرَبّ",
"دوَوّم يــــ غٓـاليَ ــــا",
"عَسَـــ دُوَوّوِوُمْ ـــآھ",
" ضحكنا معاك 🤪",
"انَ شِاءالُلُُه دِايَــمٌـُهـ",
"اضحـكـ جعل مايـضـحـكـ غيـركـ",
"لا تضحك مجامله 🧐",
"عمري يالي يضحكون يا ناس 🤭",
}
send(msg.chat_id_, msg.id_,'['..hahah[math.random(#hahah)]..']') 
return false
end
if text == "😂" or text == "😂😂" or text == "😂😂😂" or text == "😂😂??😂" or text == "😄" then
local ahahah = {
"دُۈۈۈمٌ يَـــآرَبّ",
"دوَوّم يــــ غٓـاليَ ــــا",
"عَسَـــ دُوَوّوِوُمْ ـــآھ",
" ضحكنا معاك 🤪",
"انَ شِاءالُلُُه دِايَــمٌـُهـ",
"اضحـكـ جعل مايـضـحـكـ غيـركـ",
"لا تضحك مجامله 🧐",
"عمري يالي يضحكون يا ناس 🤭",
"ابتليت بحب ضحكتك وعيُونك الحلوة 🙊💗",
}
send(msg.chat_id_, msg.id_,'['..ahahah[math.random(#ahahah)]..']') 
return false
end
if text == "ههههههههههههههههههههههههههه" or text == "هههههههههههههههههههههههههههههههههههههههههههههههه" or text == "ههههههههه" or text == "هههههههه" or text == "هههههه" then
local ahahaha = {
"دُۈۈۈمٌ يَـــآرَبّ",
"دوَوّم يــــ غٓـاليَ ــــا",
"عَسَـــ دُوَوّوِوُمْ ـــآھ",
" ضحكنا معاك 🤪",
"انَ شِاءالُلُُه دِايَــمٌـُهـ",
"اضحـكـ جعل مايـضـحـكـ غيـركـ",
"لا تضحك مجامله 🧐",
"عمري يالي يضحكون يا ناس 🤭",
"ابتليت بحب ضحكتك وعيُونك الحلوة 🙊💗",
}
send(msg.chat_id_, msg.id_,'['..ahahaha[math.random(#ahahaha)]..']') 
return false
end
if text == "شلونك" or text == "شلونكم" or text == "شخباركم" then
local sss = {
"بـّخـْيرٌ دامـّگ بـْخـّيرٌ يـّٱلـّغـٌالـّے",
"تمام وانت يكيوت ؟ 💕",
"تمام انته شلونك 😁❤️",
"ع حطت ايدك مافي تغيير شسوي يدنياء🤷🏼‍♂️",
"لوني مثل لونك كافي تسئل😒",
"انا بالنسبة الي دايخ شوف بقية الاعضااء 😂🖕",
}
send(msg.chat_id_, msg.id_,'['..sss[math.random(#sss)]..']') 
return false
end
if text == "سلام" or text == "السلام عليكم" or text == "سلام عليكم" or text == "اسلام عليكم" or text == "السلام عليكم ورحمة الله وبركاته" then
local sla = {
"وْعـلُـيَــكِـمٌ الُـــسِــــلُامٌ ❥",
"وٍعَلْيّكَمُ ٱلْسَلآمّ وٍرٍحَمُةٌ اللَّــْـْہ ۆبُركَاتة❥",
"عَلْيّكَمُ ٱلْسَلآمّ وٍرٍحَمُةٌ اللَّــْـْہ ۆبُركَاتة♥",
"وعليكم السلام اغاتي🌝👋",
}
send(msg.chat_id_, msg.id_,'['..sla[math.random(#sla)]..']') 
return false
end
if text == "انا" or text =="اني" then
local ant = {
"اانت اللي له القلب يشتاق♥",
"💔 انت وبس اللي حبيبي 👈🏻♥",
"انت حبيبي انا وبس🙈♥",
}
send(msg.chat_id_, msg.id_,'['..ant[math.random(#ant)]..']') 
return false
end
if text == "نورت" or text == "نورتي" or text == "منور" or text == "منوره" then
local nor = {
"الـنـور نوووووركـ♥",
"بنورك حب....♥",
"بّـوَجْـوَدِكِ♥",
}
send(msg.chat_id_, msg.id_,'['..nor[math.random(#nor)]..']') 
return false
end
if text == "اشكرك" or text == "شكرا" or text == "شكرآ" or text == "مشكور" or text == "تسلم" or text == "يسلمو" or text  == "يسلموو" then
local skr = {
"بخدمتك/ج حبي ❤",
"عــــفٌوِاًً .. ",
"الـعـفـو❥",
"ولو تحت امركـ ❥",
 "•• الـّ~ـعـفو ••",
}
send(msg.chat_id_, msg.id_,'['..skr[math.random(#skr)]..']') 
return false
end
if text == "انجب" or text == "نجب" or text =="جب" then
local askt = {
"لخاطرك راح اسكت 😌❤",
"انجب انته لاتندفر 😏",
"ع راسي تدلل انته تاج راسي 😌",
"ابشر طال عمرك 😔",
"كـل تـبـن اسكت انــYOUــت😒",
"وش سويت عشان تقول اسكت 😔",
"اوكـ  صـار 🙊",
}
send(msg.chat_id_, msg.id_,'['..askt[math.random(#askt)]..']') 
return false
end
if text == "كفو" or text == "كفوو" or text == "كفووو" then
local kfo = {
"كـفـوك الـطـيـب🤭",
"كـــفـوكـ الــطـيـب🤗",
"اها كـفـو يبو الضلوع☺",
"كـفـوكـ الطيب يبعدي ♥☺",
"كـفـوكـ الـطـيـب ي ضلعي ♥😜",
}
send(msg.chat_id_, msg.id_,'['..kfo[math.random(#kfo)]..']') 
return false
end
if text == "اكو احد" or text == "في احد" or text == "فيه احد" or text == "موجود" or text == "موجوده" then
local ahd = {
"تفضل عزيزي 🌝🌸",
"انـا مـوجـود 😍",
"تُفَـــــٌــــضْل ...😌",
"لا مافي احـد شعندك 😒",
"نـعـم انا موجود 🧐",
 "انا موجـود🌝🌿",
}
send(msg.chat_id_, msg.id_,'['..ahd[math.random(#ahd)]..']') 
return false
end
if text == "حلو" or text == "حلوو" or text == "حلووو" or text == "حلوه" or text == "حلووه" then
local hlo = {
"مو بحلاتكـ🤭",
"انت الاحلى 🌚❤️",
"عـيـونـكـ الـحلــوه ♥☻",
"انت الحلوووو♥",
}
send(msg.chat_id_, msg.id_,'['..hlo[math.random(#hlo)]..']') 
return false
end
if text == "كيفك" or text == "كيف الحال" or text == "كيفكم" or text == "اخبارك" or text == "اخباركم" or text == "علومك" or text == "علومكم" or text == "كيف الحال" then
local kifk = {
"بـّخـْيرٌ دامـّگ بـْخـّيرٌ يـّٱلـّغـٌالـّے",
"تمامــــ الحمـ لله ـــد",
"بّخــــَيِرً أَلًحّمِـــــدِلٌلِه❥",
"الُحُـمٌـدِالُلُُه أٌنــُتَ ڳُــــيّفُڳً",
}
send(msg.chat_id_, msg.id_,'['..kifk[math.random(#kifk)]..']') 
return false
end
if text == "اسكت" and SudoBot(msg) or text == "انطم" and SudoBot(msg) or text == "انثبر" and SudoBot(msg) then  
local STO = {
"\nحاضر مو تدلل حضرة المطور😇",
"\nلخاطرك راح اسكت لانك مطوري😌",
"\n😊ابشر ياتاج راسي",
"\nابشر طال عمركـ??",
}
send(msg.chat_id_, msg.id_,'['..STO[math.random(#STO)]..']') 
return false
end
if text == "تعطيل الابراجا" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*✓| اهلا عزيزي تم تعطيل الابراج*')
database:set(bot_id.."ASTORHBOTS:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراجا" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*✓| اهلا عزيزي تم تفعيل الابراج*')
database:set(bot_id.."ASTORHBOTS:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برجا (.*)$") and database:get(bot_id.."ASTORHBOTS:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برجا (.*)$")
gk = https.request('https://forhassan.ml/Black/br.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_, br.ok.hso)
end
if text == "تعطيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_, '❎︙ تم تعطيل الابراج')
database:set(bot_id.." sofi:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_,'✅︙ تم تفعيل الابراج')
database:set(bot_id.." sofi:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and database:get(bot_id.." sofi:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://rudi-dev.tk/Amir2/Boyka.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, '℘︙ تم تعطيل حساب العمر')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"close")
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, '❎︙ تم تعطيل حساب العمر')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_,'✅︙ تم تفعيل حساب العمر')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and database:get(bot_id.." sofi:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://rudi-dev.tk/Amir3/Boyka.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '❎︙ تم تعطيل الزغرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'✅︙ تم تفعيل الزخرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and database:get(bot_id.." sofi:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه(.*)$")
zh = https.request('https://rudi-dev.tk/Amir1/Boyka.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n🔥︙ قائمه الزخرفه \n●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●\n🔥︙ ➫ .[🖨┇𝗟𝗛𝗕 𝗦𝗢𝗨𝗥𝗖𝗘 🔥](https://t.me/LSLHB)➤ ')
end
if text == "تعطيل معاني الاسماء" and Mod(msg) then
send(msg.chat_id_, msg.id_, '🚫 | تم تعطيل معاني الاسماء')
database:set(bot_id.."Tshake:Name_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل معاني الاسماء" and Mod(msg) then
send(msg.chat_id_, msg.id_,'✅ | تم تفعيل معاني الاسماء')
database:set(bot_id.."Tshake:Name_Bots"..msg.chat_id_,"open")
end
if text and text:match("^معنى (.*)$") and database:get(bot_id.."Tshake:Name_Bots"..msg.chat_id_) == "open" then
local TextName = text:match("^معنى (.*)$")
gk = https.request('http://sonicx.ml/Api/Name.php?Name='..URL.escape(TextName)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_,br.meaning)
end
if text == "تعطيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⌯ تم تعطيل الانستا')
database:set(bot_id.."ASTORHBOTS:insta_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_,'⌯ تم تفعيل الانستا')
database:set(bot_id.."ASTORHBOTS:insta_bot"..msg.chat_id_,"open")
end
if text and text:match("^معلومات (.*)$") and database:get(bot_id.."ASTORHBOTS:insta_bot"..msg.chat_id_) == "open" then
local Textni = text:match("^معلومات (.*)$")
data,res = https.request('https://forhassan.ml/Black/insta.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
local filee = download_to_file(muaed.ph,msg.sender_user_id_..'.jpg')
sendPhoto(msg.chat_id_, msg.id_,'./'..msg.sender_user_id_..'.jpg',muaed.info)     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
end
end
if text == "تعطيل الافلام" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⌯ تم تعطيل الافلام')
database:set(bot_id.."ASTORHBOTS:movie_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الافلام" and Manager(msg) then
send(msg.chat_id_, msg.id_,'⌯ تم تفعيل الافلام')
database:set(bot_id.."ASTORHBOTS:movie_bot"..msg.chat_id_,"open")
end

if text and text:match("^فلم (.*)$") and database:get(bot_id.."ASTORHBOTS:movie_bot"..msg.chat_id_) == "open" then
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤| العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'ASTORHBOTS')..') '
status  = '\n📮| الايدي » '..result.sender_user_id_..'*\n✓| تم اضافـة {'..timsh..'} كلقب له*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'تعطيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_,msg.id_,'\n• تم الامر بنجاح')  
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"close") 
return false  
end 
if text == 'تفعيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_,msg.id_,'\n• تم الامر بنجاح')  
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"open") 
return false  
end
if text and text:match('^بصمه (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^بصمه (.*)$') 
local InfoSearch = https.request('https://alsh-bg.ml/api/Search_MP3.php?Search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @ASTORHBOTS','@ASTORHBOTS')  
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
if text and text:match('^صوت (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^صوت (.*)$') 
local InfoSearch = https.request('https://alsh-bg.ml/api/Search_MP3.php?Search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendAudio(msg.chat_id_,msg.id_,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @ASTORHBOTS','@ASTORHBOTS')
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
if text == 'تفعيل التنزيل' and Manager(msg) then   
database:del(bot_id..'dw:bot:api'..msg.chat_id_) 
Text = '\n🔰| *تم تفعيل التنزيل*' 
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التنزيل' and Manager(msg) then  
database:set(bot_id..'dw:bot:api'..msg.chat_id_,true) 
Text = '\n🔘| *تم تعطيل التنزيل*' 
send(msg.chat_id_, msg.id_,Text) 
end 
if text and text:match('^(.*) بصمه$') and not database:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Ttext = text:match('^(.*) بصمه$') 
local ytddl = https.request('https://devstorm.ml/sr.php?search='..URL.escape(Ttext))
local zxe = JSON.decode(ytddl)
for k,v in pairs(zxe.results) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
https.request('https://devstorm.ml/yt.php?url='..v.url..'&token='..token..'&chat='..msg.chat_id_..'&type=mp3&msg='..msgin)
end
end
end
if text and text:match('^(.*) صوت$') and not database:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Ttext = text:match('^(.*) صوت$') 
local ytddl = https.request('https://devstorm.ml/sr.php?search='..URL.escape(Ttext))
local zxe = JSON.decode(ytddl)
for k,v in pairs(zxe.results) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
https.request('https://devstorm.ml/yt.php?url='..v.url..'&token='..token..'&chat='..msg.chat_id_..'&type=ogg&msg='..msgin)
end
end
end
if text and text:match('^(.*) فيديو$') and not database:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Ttext = text:match('^(.*) فيديو$') 
local ytddl = https.request('https://devstorm.ml/sr.php?search='..URL.escape(Ttext))
local zxe = JSON.decode(ytddl)
for k,v in pairs(zxe.results) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
https.request('https://devstorm.ml/yt.php?url='..v.url..'&token='..token..'&chat='..msg.chat_id_..'&type=mp4&msg='..msgin)
end
end
end
if text == 'تعطيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_,msg.id_,'\n• تم الامر بنجاح')  
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"close") 
return false  
end 
if text == 'تفعيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_,msg.id_,'\n• تم الامر بنجاح')  
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"open") 
return false  
end
if text and text:match('^بصمه (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^بصمه (.*)$') 
local InfoSearch = https.request('https://mode-dev.tk/tg/search.php?search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @LSLHB','@LSLHB')  
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
if text and text:match('^صوت (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^صوت (.*)$') 
local InfoSearch = https.request('https://mode-dev.tk/tg/search.php?search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendAudio(msg.chat_id_,msg.id_,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @LSLHB','@LSLHB')
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
if text == 'تفعيل الردود' and Manager(msg) then   
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = '🔰| تم تفعيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and Manager(msg) then  
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n🔘| تم تعطيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'رابط الحذف' or text == 'رابط حذف' then
t =[[
🔰| رابط الحذف التلي ،
✨| فـكـر قـبـل لاتـسـرع .
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖 | [اضغط هنا للحذف الحساب](https://telegram.org/deactivate)
]]
send(msg.chat_id_, msg.id_,t) 
return false
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg
end --end 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help1' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
⚜️| اوامر حماية المجموعه⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| قفل | فتح + الامر 
⚠️| ❴بالكتم,بالتقييد,بالطرد❵
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔒| قفل ⇚ فتح الاضافه
🔒| قفل ⇚ فتح الدردشه
🔒| قفل ⇚ فتح الدخول
🔒| قفل ⇚ فتح البوتات
🔒| قفل ⇚ فتح الاشعارات
🔒| قفل ⇚ فتح التعديل
🔒| قفل ⇚ فتح تعديل الميديا
🔒| قفل ⇚ فتح الروابط
🔒| قفل ⇚ فتح المعرفات
🔒| قفل ⇚ فتح التاك
🔒| قفل ⇚ فتح الشارحه
🔒| قفل ⇚ فتح الملصقات
🔒| قفل ⇚ فتح المتحركه
🔒| قفل ⇚ فتح الفيديو
🔒| قفل ⇚ فتح الصور
🔒| قفل ⇚ فتح الالعاب
🔒| قفل ⇚ فتح الاغاني
🔒| قفل ⇚ فتح الصوت
🔒| قفل ⇚ فتح الفشار
🔒| قفل ⇚ فتح الفارسيه
🔒| قفل ⇚ فتح الكيبورد
🔒| قفل ⇚ فتح التوجيه
🔒| قفل ⇚ فتح الملفات
🔒| قفل ⇚ فتح السيلفي
🔒| قفل ⇚ فتح الجهات
🔒| قفل ⇚ فتح الماركداون
🔒| قفل ⇚ فتح الكلايش
🔒| قفل ⇚ فتح التكرار
🔒| قفل ⇚ فتح التفليش
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔴| اوامر الادمنيه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| رفع/تنزيل مميز
🔖| المميزين
🔖|حظر/الغاء حظر
🔖| المحظورين
🔴| كتم/الغاء كتم
🔴| المكتومين
🔴| تعطيل + تفعيل التحويل
🔴| تعطيل + تفعيل الردود
🔴| تعطيل + تفعيل التنظيف
🔴| تعطيل + تفعيل معاني الاسماء
🔴| تعطيل + تفعيل الابراج
🔴| تعطيل + تفعيل حساب العمر
🔴| تعطيل + تفعيل الزخرفه
🔴| تقييد + الرقم + سَـاعه
🔴| تقييد + الرقم + يوم
🔴| تقييد + الرقم + دقيقه
🔴| كتم + الرقم + ساعه
🔴| كتم + الرقم + يوم
🔴| كتم + الرقم + دقيقه
📌| تقييد/الغاء تقييد
📌|طرد
📌| طرد + مسح البوتات
📌| تثبيت/الغاء تثبيت
📮| ضع تكرار + العدد
📮| الترحيب
📮| تفعيل/تعطيل الترحيب
📮| منع/الغاء منع
📃| قائمه المنع
📃| كشف البوتات
📃| الصلاحيات
📃| كشف / برد ⇚ بمعرف
💠| اضف صلاحيه + اسم الصلاحيه
💠| مسح صلاحيه + اسم الصلاحيه
💠| تعطيل اوامر التحشيش
💠| تفعيل اوامر التحشيش
🔮| تفعيل/تعطيل صورتي
🔮| صورتي لجلب صورة حسابك
📁| تاك للكل
📁| اعدادات المجموعه
📁| عدد القروب
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔴| مسح + الامر
🔰| المميزين ، المحظورين ، المكتومين
🔰| الترحيب ، الرابط ، القوانين
🔰| قائمه المنع ، البوتات ،
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔺| ضع + الامر
🔺| رابط ، ترحيب ، قوانين
🔺|صوره ، وصف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔖| اوامر مدراء المجموعه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📍| تغير امر الاوامر
📍| تغير امر م1 › الحد م8
📍| استعاده الاوامر
🔹| رفع/تنزيل ادمن
🔹| الادمنيه
🔹| مسح الادمنيه
🔹| تاك لادمنيه
🔹| رفع القيود
🔹| كشف القيود
💭| تعين الايدي
 💭| تغير الايدي
💭| مسح الايدي 
💭| تنظيف + العدد
💭| ضع اسم + الاسم
💭| تنزيل الكل
💭| منع + برد
❴الصور + متحركه + ملصق❵
🗑️| مسح قائمه منع الصور
🗑️| مسح قائمه منع الملصقات
🗑️| مسح قائمه منع المتحركات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
⚡| مسح ردود المدير
⚡| ردود المدير
⚡| اضف/حذف رد
💠| تغير رتبة المطور + اسم
💠| تغير رتبة منشئ الاساسي + اسم
💠| تغير رتبة المنشئ + اسم
💠| تغير رتبة المدير + اسم
💠| تغير رتبة الادمن + اسم
💠| تغير رتبة المميز + اسم
💠| تغير رتبة العضو + اسم
📮| تعطيل/تفعيل ردود المدير
📮| تعطيل/تفعيل ردود المطور
📮| تعطيل/تفعيل الايدي
??| تعطيل/تفعيل الايدي بالصوره
📮| تعطيل/تفعيل الالعاب
🔴| تعطيل/تفعيل اطردني
🔴| تعطيل/تفعيل صيح
🔴| تعطيل/تفعيل ضافني
🔴| تعطيل / تفعيل الرابط 
🔴| تعطيل / تفعيل all
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔖| اوامر المنشئين للمجموعه كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💭| اضف امر
💭| حذف امر
📍| اسم بوت + الرتبه
📍| حذف الاوامر المضافه
📍| الاوامر المضافه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔺| تنزيل جميع الرتب
🔺| مسح المنشئين
🔺| رفع/تنزيل منشئ
🔺| المنشئين
🔺| رفع/تنزيل مدير
🔺| المدراء
🔺| مسح المدراء
🔺| مسح المنظفين
🔺| مسح الميديا
🔺| مسح التعديل
🔺| رفع الادمنيه
👨‍✈️| وضع لـقـب + اللقب
👨‍✈️| رفع /تنزيل وزير
🔴| رفع مـنـظـف
🔴| تنزيل مـنـظـف
🔴| المنظفين
🔴| رفع مشرف
🔴| تنزيل مشرف
🔴| رفع ادمن بكل الصلاحيات
🔴| تنزيل ادمن بكل الصلاحيات
🔷| تفعيل/تعطيل الحظر
🔷| تفعيل/تعطيل الرفع 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help11' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📯┇ اهلا بك عزيزي 💞
📯┇ اوامر الاضافات كتالي⟱
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📪┇ كتم الاسماء
1- كتم اسم +(اسم)
2- الغاء كتم اسم +(اسم)
3- الاسماء المكتومه
4- مسح الاسماء المكتومه
5- تفعيل كتم الاسم
6- تعطيل كتم الاسم
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📋┇ وضع توحيد
1- وضع توحيد +(التوحيد)
2- تعين عدد الكتم+(العدد)
3- التوحيد
4- تفعيل التوحيد
5- تعطيل التوحيد 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📌┇ اهلا بك عزيزي 💞
📌┇ اوامر التنبيه كتالي⟱
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📳┇ تنبيه الاسماء 💗
1- تفعيل تنبيه الاسماء 
2- تعطيل تنبيه الاسماء
🆔┇ تنبيه المعرف 💗
1- تفعيل تنبيه المعرف
2- تعطيل تنبيه المعرف
🏞┇ تنبيه الصور 💗
1- تفعيل تنبيه الصور 
2- تعطيل تنبيه الصور 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Sudo(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔘| اوامر مطور الاساسي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
⚡| تفعيل
⚡| تعطيل
📌| مسح الاساسين
📌| المنشئين الاساسين
📌| رفع/تنزيل منشئ اساسي
📌| مسح المطورين
📌| المطورين
??| رفع | تنزيل مطور
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💲| اسم البوت + مغادره
💲| مغادره/ مغادرة
🔍| اسم بوت + الرتبه
🔍| تحديث السورس
📍| حضر عام
📍| الغاء العام
📍| قائمه العام
📍| مسح قائمه العام
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
 ⚜️| المتجر 
⚜️| متجر الملفات
⚜️| الملفات
⚜️| مسح الملفات
⚜️| تعطيل + تفعيل + اسم ملف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| اذاعه خاص
🔖| اذاعه
🔖| اذاعه بالتوجيه
🔖| اذاعه بالتوجيه خاص
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📥|جلب نسخه احتياطيه
📤| رفع النسخه الاحتياطيه
🔴| ضع عدد الاعضاء + العدد
🔴| ضع كليشه المطور
🔹| تفعيل/تعطيل الاذاعه
🔹| تفعيل/تعطيل البوت الخدمي
🔹| تفعيل/تعطيل التواصل
🔰| تغير اسم البوت
🔰| اضف/حذف رد متعدد
🔰| اضف/حذف رد عام
🔰| ردود المطور
🔰| مسح ردود المطور
🔰| الردود المتعدده
🔰| مسح الردود المتعدده
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
💠| الاشتراك الاجباري
💠| تعطيل الاشتراك الاجباري
💠| تفعيل الاشتراك الاجباري
💠| حذف رساله الاشتراك
💠| تغير رساله الاشتراك
💠| تغير الاشتراك
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔆| الاحصائيات
🔆| تفعيل/تعطيل المغادره
🔆| تنظيف المشتركين
🔆| تنظيف القروبات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔴| اوامر التحشيش كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📌| رفع + تنزيل ⇚ الامر
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🦓| رفع + تنزيل ⇚ حمار
🦓| تاك للحمير ⇐ تنزيل الحمير
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐐| رفع + تنزيل ⇚ صخل
🐐| تاك لصخوله ⇐ تنزيل الصخوله
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐶| رفع + تنزيل ⇚ كلب
🐶| تاك للكلاب ⇐ تنزيل الكلاب
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐒| رفع + تنزيل ⇚ قرد 
🐒| تاك للقرود ⇐ تنزيل القرود
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐂| رفع + تنزيل ⇚ بقره
🐂| تاك للبقر ⇐ تنزيل البقر
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐎| رفع + تنزيل ⇚ حصان
🐎| تاك للاحصنه ⇐ تنزيل الاحصنه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐏| رفع + تنزيل ⇚ نعجه
🐏| تاك لنعاج ⇐ تنزيل النعاج
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐊| رفع + تنزيل ⇚ زاحف 
🐊| تاك لزواحف ⇐ تنزيل الزواحف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🐔| رفع + تنزيل ⇚ دجاجه
🐔| تاك لدجاج ⇐ تنزيل الدجاج
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
👰| رفـع + تنزيل ⇐ زوجتي
👰| تنزيل زوجاتي ⇐ تاك للزوجات
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🙋‍♂️| رفـع + تنزيل ⇐ زوجي
🙋‍♂️| تنزيل ازواجي ⇐ تاك لزوجي
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
❤️| رفـع + تنزيل ⇐ لقلبي
❤️| تنزيل قلبي ⇐ تاك لقلبي
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
if not Sudo(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
🔖| اوامر المطورين البوت كتالي⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
📮| تفعيل ⇚ تعطيل 
📮| القروبات ⇚ المشتركين 
📮| رفع ⇚ تنزيل منشئ اساسي
📮| مسح الاساسين ⇚ المنشئين الاساسين
📮| مسح المنشئين ⇚ المنشئين
🔹| اسم البوت + مغادره
🔹| اذاعه / اذا كان مطور اساسي مفعلها
🔹| ردود المطور 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help8' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎗️| اهلا بك عزيزي √
⇓⇓| اوامر الاعضاء كتالي⇓⇓
🔘| عرض معلوماتك ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔖| قول + الكلمة
🔖| رسايلي ⇚ مسح رسايلي 
🔖| رتبتي ⇚ تعديلاتي 
🔖| مسح تعديلاتي ⇚ المنشئ 
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔘| اوآمر المجموعه ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔅| الرابط ⇚ القوانين – الترحيب
🔅|  ايدي ⇚ اطردني 
🔅| اسمي ⇚ المطور  
🔅| كشف / برد بالمعرف
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🔘| اسم البوت + الامر ⇓⇓
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
🚸| بوسه بالرد
📩| مقالات
✳️| انصحني
🚫| بوسني للمطور
🚫| مصني للمطور
🚸| مصه بالرد
🚸| رزله بالرد 
🚸| وش رايك بهاذا بالرد
🚸| وش رايك بهاذي بالرد
🚸| تحبني⇐احبك
🚸| تحب هذا
🔷| نسبه الحب
🔷| نسبه الكره
🔷| نسبه الرجوله
🔷| نسبه الانوثه
●ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/clos' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[*تـم اغـلاق الـلـوحـة*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help9' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🔴| اهلا بك في اوامر البوت  
●ـ▬ـ▬▬ஜ۩۞۩ஜ▬▬ـ▬ـ●
🔖| م1 » لـعــرض اوامر الحمايه 
🔖| م2 » لـعــرض اوامر الادمنيه 
🔖| م3 » لـعــرض اوامر المدراء 
🔖| م4 » لـعــرض اوامر المنشئين
🔖| م5 » لـعــرض اوامر مطور اساسي
🔖| م6 » لـعــرض اوامر التحشيش
🔖| م7 » لـعــرض اوامر مطورين البوت
🔖| م8 » لـعــرض اوامر الاعضاء
●ـ▬ـ▬▬ஜ۩۞۩ஜ▬▬ـ▬ـ●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help10' then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
⚜┇اوامر الالعاب كالتالي √
◣──◐~❉الاسطورة❉~◐──◢
✅┇تفعيل الالعاب • لتفعيل الالعاب
❎┇تعطيل الالعاب • لتعطيل الالعاب
◣──◐~❉الاسطورة❉~◐──◢
🕹┇الالعاب الخاصه بالسورس √
◣──◐~❉الاسطورة❉~◐──◢
📜╿•⊱محيبس ༜ لعبه محيبس الشهيره
🎰│•⊱سمايلات ༜  ارسال السمايلات
🎯│•⊱رياضيات ༜ لعبة الرياضيات
📜│⊱امثله ༜ لعبه امثله قديمه
🎰│•⊱معاني ༜ لعبه معاني لسمايلات 
📋│•⊱اسئله ༜ لعبه اسئله عامه
🤔│•⊱حزوره ༜ لعبه الحزورات
🎨│•⊱ترتيب ༜ لعبه ترتيب الكلمات
♻️│•⊱العكس ༜ لعبه عكس الكلمه
🎁│•⊱تخمين ༜ لعبه تخمين الكلمه 
🤹‍♂│•⊱الاسرع ༜ لعبه اسرع واحد 
♻️│•⊱كت تويت ༜ لعبه التسليه 
🔆│•⊱انجليزي ༜ لعبه ترجمة انجليزي
♒│•⊱تفكيك ༜ لعبه تفكيك الكلمات
✅│•⊱تركيب ༜ لعبه تركيب الكلمات
🏁│•⊱علم الدول ༜ لعبة اعلام الدول
🚦╽•⊱المختلف ༜ لعبه اختلاف لسمايل
◣──◐~❉الاسطورة❉~◐──◢
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1️⃣', callback_data="/help1"},{text = '2️⃣', callback_data="/help2"},{text = '3️⃣', callback_data="/help3"},
},
{
{text = '4️⃣', callback_data="/help4"},{text = '5️⃣', callback_data="/help5"},{text = '6️⃣', callback_data="/help6"},
},
{
{text = '7️⃣', callback_data="/help7"},{text = '8️⃣', callback_data="/help8"}
},
{
{text = 'الالعاب', callback_data="/help10"},{text = 'الاضافات', callback_data="/help11"},
},
{
{text = 'القائمة الرئيسية', callback_data="/help9"},
},
{
{text = 'اغلاق اللوحة', callback_data="/clos"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.date_ and msg.date_ < tonumber(os.time() - 15) then
print('OLD MESSAGE')
return false
end
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then
return false
end
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
-------------------------------------------------------------------------------------------------------------- 
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'📄| تم حذف الامر')  
else
send(msg.chat_id_, msg.id_,'🚸| لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
-------------------------------------------------------------------------------------------------------------- 
if text then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '🔖| تم تعطيل اوامر التحشيش')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, ' 📮| تم تفعيل اوامر التحشيش')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'الاسطورة')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' وش رايك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'هذا الله يعينه على نفسه 😒','والله والنعم فيـه💋🙄','يلعب ع البنات 🙄', 'كفـــــــووووووو♥ 😶🙊','حلو يخبل ومعضل','مــدري??🏼‍♀️','اموت عليه 🌝','هذا حبيبي قلبي 🤓❤️','نشبه وماعنده سالفه😂صراحه ☹️','كـفـوووو','هذا واحد نشبه 🙄😒','ماطيقه كل ما اكمشه ريحته كنها بخاخ بف باف حشرات 😂🤷‍♀️','نشبه وماعنده سالفه😂🤓'} 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'القلب حقي🥰','يارجال ماحبه ',' لٱ ايع ','متيم فيه 💔','ماحب مهابيل اسف','اقولك ۿذﭑ يقلي احبكك أو لا ﭑݩٺ شتقول','اووووووووف امووت فـيــه ','ايععععععععع','وربي اعشقك','ماحب مخابيل','احب مطوري وبس','لٱ ماحبه','بالله هذا سوال تقولي احبه?  ؟ ','بربك انته والله فاضي وماعندك شي تسويه جاي تسئلني احبه أو لا','اف بس حبيبي هذا'}
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال اليافعي و البوت'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال اليافعي و البوت'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \n مثال اليافعي'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \n مثال نونه'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
if text == "نسبه الجمال" or text == "نسبه جمال" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:anoo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":anoo_Bots"..msg.chat_id_,"sendanooe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه جماله\n مثال نونه'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الجمال" and database:get(bot_id..":"..msg.sender_user_id_..":anoo_Bots"..msg.chat_id_) == "sendanooe" then
numjj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnumjj = numjj[math.random(#numjj)]
xll = 'نسبه الجمال'..text..' هي : \n '..sendnumjj..'%'
send(msg.chat_id_, msg.id_,xll) 
database:del(bot_id..":"..msg.sender_user_id_..":anoo_Bots"..msg.chat_id_)
end
if text == "نسبه الهياط" or text == "نسبه هياط" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not database:get(bot_id..'Cick:hnjmh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":hnjmh_Bots"..msg.chat_id_,"sendhnjmhe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه الهياط 😂 \n مثال وهيب 😂'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الهياط" and database:get(bot_id..":"..msg.sender_user_id_..":hnjmh_Bots"..msg.chat_id_) == "sendhnjmhe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الهياط '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":hnjmh_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
MARCOS = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(MARCOS)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
MARCOS = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(MARCOS)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceMARCOS(data.message_,data)
plugin_Poyka(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
-----------------------------------------------
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
local Get_Re_Name = database:get(bot_id.."Chen:Name"..msg.sender_user_id_) 
if Get_Re_Name then 
if Get_Re_Name ~= data.first_name_ then 
tahan = '['..(Get_Re_Name or '')..']'
taham = '['..data.first_name_..']'
local taha ={ 
'\n ليش غيرت اسمك  يا حلو 😹🌚',
'\n شهل اسم الفيطي '..taham.. ' \n رجعه ؏ قديم \n '..tahan..'',
'\n  ها ها ليش غيرت اسمك 🤔??',
'\n ليش غيرت اسمك شنو قطيت وحده جديده 😹😹🌚',
'\n ليش غيرت اسمك شنو تعاركت ويه الحب ؟😹🌞',
'\n ها ولك مو جان  اسمك   '..tahan..'  ليش غيرته ',
'\n ليش غيرت اسمك شسالفه ؟؟ 🤔🌞'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:Name"..msg.sender_user_id_, data.first_name_) 
return false
end  
end
--------------------------------------------------------------------------------------------------------------
local Getredis = database:get(bot_id.."Chen:User:Name"..msg.sender_user_id_)
if data.username_ then  
if Getredis and Getredis ~= data.username_ then 
tahan = '['..(database:get(bot_id.."Chen:User:Name"..msg.sender_user_id_) or '')..']'
local taha ={ 
'\n ليش غيرت معرفك  يا حلو 😹🌚',
'\n  ها ها ليش غيرت معرفك 🤔😹',
'\n ليش غيرت معرفك شنو قطيت وحده جديده 😹😹🌚',
'\n ليش غيرت معرفك شنو تعاركت ويه الحب ؟😹🌞',
'\n ها ولك مو جان  معرفك   '..tahan..'  ليش غيرته ',
'\n ليش غيرت معرفك شسالفه ؟؟ 🤔🌞'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:User:Name"..msg.sender_user_id_, data.username_) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
local Getredis = database:get(bot_id.."Chen:Photo"..msg.sender_user_id_)
if data.profile_photo_ then  
if Getredis and Getredis ~= data.profile_photo_.id_ then 
local taha ={ 
'\n ليش غيرت صورتك  يا حلو 😹🌚',
'\n  ها ها ليش غيرت صورتك 🤔😹',
'\n ليش غيرت صورتك شنو قطيت وحده جديده 😹😹🌚',
'\n ليش غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞',
'\n ليش غيرت صورتك شسالفه ؟؟ 🤔🌞'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:Photo"..msg.sender_user_id_, data.profile_photo_.id_) 
return false
end
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock:edit"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
send(msg.chat_id_,0,'⚠¦ تم التعديل على الميديا \n\n📌¦ الشخص الي قام بالتعديل\n➺➺➺ •⊱{ '..users..' }⊰•') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("[hH][tT][tT][pP][sT]") or text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
local MARCOSbot = database:get(bot_id.."Add:Filter:Rp2"..text..result.chat_id_)   
if MARCOSbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠¦العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n📛¦["..MARCOSbot.."] \n") 
else
send(msg.chat_id_,0,"⚠¦العضو : {["..data.first_name_.."](T.ME/ASTORHBOTS)}\n📛¦["..MARCOSbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
end
------------------------------------------------------------------------
end,nil)
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end
end -- end new msg
end -- end callback

