# This is the actual bot config and command logic 
#! /usr/bin/env ruby

require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.sasl.username = 'gwion_bot'
    c.sasl.password = 'm2p2gwion_bot'
    c.server = 'irc.freenode.net'
    c.user = 'GwionBot'
    c.nick = 'gwion'
    c.realname = 'I\'m a cinch bot that talks Gwion language.'
    c.channels = ['#gwion_lang', '#proglangdesign']
  end

#  on :dcc_send  do |m|
#  m.reply "I don't known what to do yet, sorry."
# we need a way to get file.
#  m.reply "/dcc accept #{m.user}"
#  end

  on :message  do |m|
    if m.action? then return end
    if m.ctcp? then return end
#   if message[0..5] != 'gwion:' then return end
#    if message[0] != ':' then return end
    if m.message =~ /^gwion:/ then 
      message = m.message.gsub('gwion:', '')
      File.write('file.gw', message)
      reply = `gwion/gwion file.gw 2>&1 | bash ./remove_colors.sh`
      m.reply reply
    end
  end
end

bot.start
