#! /usr/bin/env ruby

require 'cinch'
require "tempfile"

bot = Cinch::Bot.new do
  configure do |c|
    c.sasl.username = 'gwion_bot'
    c.sasl.password = 'm2p2gwion_bot'
    c.server = 'irc.freenode.net'
    c.user = 'GwionBot'
    c.nick = 'gwionbot'
    c.realname = 'I\'m a cinch bot that talks Gwion language.'
    c.channels = ['#gwion_lang', '#proglangdesign']
#    c.channels = ['#gwion_lang']
  end

  on :dcc_send, method: :incoming_dcc do |m, dcc|
    if dcc.from_private_ip? || dcc.from_localhost? then
      @bot.loggers.debug "Not accepting potentially dangerous file transfer"
      m.reply "test"
    else
      m.reply "You want me to receive " + dcc.filename
      t = File.open('dcc.gw', 'w')
      dcc.accept(t)
      t.close
      reply = `Gwion/gwion dcc.gw 2>&1 | bash ./remove_colors.sh`
      m.reply reply
    end
  end

  on :message  do |m|
    if m.action? then end
    if m.ctcp? then end
    if m.message[0..5] != 'gwionbot:' then end
    if m.message[0] != ':' then end
    if m.message =~ /^gwionbot:/ then 
      message = m.message.gsub('gwionbot:', '')
      File.write('file.gw', message)
      reply = `Gwion/gwion file.gw 2>&1 | bash ./remove_colors.sh`
      m.reply reply
    end
  end
end

bot.start
