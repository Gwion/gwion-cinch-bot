# This is the actual bot config and command logic 
#! /usr/bin/env ruby

require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.user = 'GwionBot'
    c.nick = 'GwionBotNick'
    c.realname = 'GwionBotRealName'
    c.channels = ['#bot_test']

  end

#  on :message, "hello" do |m|
  on :message do |m|
    m.reply "Why hello there."
    File.write('file.gw', m.message)
#    reply = `gwion file.gw 2>&1 | sed "s/\x1B\[[0-9;]\+[A-Za-z]//g"`
    reply = `gwion file.gw 2>&1 | bash ./remove_colors.sh`
    m.reply reply
  end
end

bot.start

