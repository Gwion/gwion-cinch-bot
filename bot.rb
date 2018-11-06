# This is the actual bot config and command logic 
#! /usr/bin/env ruby

require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.sasl.username = 'gwion_bot'
    c.sasl.password = 'm2p2gwion_bot'
    c.server = 'irc.freenode.net'
    c.user = 'GwionBot'
    c.nick = 'GwionBot'
    c.realname = 'GwionBotRealName'
    c.channels = ['#bot_test']

  end

  on :dcc_send  do |m|
  m.reply "tu m'envoie un truc?"
  end

  on :message  do |m|
# if m.action? then return end
#  if m.ctcp? then return end
    File.write('file.gw', m.message.gsub('GwionBot', ''))
    reply = `gwion/gwion file.gw 2>&1 | bash ./remove_colors.sh`
    m.reply reply
  end
end

bot.start

