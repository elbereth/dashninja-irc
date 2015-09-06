#!/usr/bin/tclsh
# Simple text return command for dashircbot

set dashircbot_simpletext_subversion "1.7"
set dashircbot_simpletext_script [file tail [ dict get [ info frame [ info frame ] ] file ]]

putlog "++ $::dashircbot_simpletext_script v$dashircbot_simpletext_subversion loading..."

# -----------------------------------------------------------------------------
# Send text action
# -----------------------------------------------------------------------------
proc do_sendtext {action nick chan} {
  putlog "dashircbot v$::dashircbot_version ($::dashircbot_simpletext_script v$::dashircbot_simpletext_subversion) \[I\] [lindex [info level 0] 0] action $action from $nick in $chan"
  if {[string tolower $nick] == "alit"} {
    set header "PRIVMSG $nick :"
    puthelp "PRIVMSG $chan :$nick: 8===3 ~º ( O )"
    return
  }
  if {$action == "donate"} {
    set outtextfr "Donations aprecies sur Xbon36F261wXDL4p1CEZAX28t8U4ayR9uu"
    set outtexten "Donations and tips appreciated on Xbon36F261wXDL4p1CEZAX28t8U4ayR9uu"
  } elseif {$action == "infotest"} {
    set outtexten "COMMANDS: $::dashircbot_commandlist_en"
    set outtextfr "COMMANDES: $::dashircbot_commandlist_fr"
  } else {
    set outtexten "Commands: ( !mnstatsusd & !mnstatseur - MasterNodes Statistics )|( !mnworthusd & !mnwortheur - Daily earnings for masternodes )|( !worthusd & !wortheur - Trading prices )|( !marketcap & !marketcapeur - Market cap for DASH )|( !diff - Difficulty info )|( !donate )"
    set outtextfr "Commandes: ( !mnstatsusd & !mnstatseuro - Statistiques MasterNodes )|( !mnvaleur & !mnvaleureur - Gain Masternode )|( !valeur & !valeurusd - Valeur DASH )|( !marketcap & !marketcapusd - Capitalisation marche )|( !diff - Information difficulte )|( !donate )"
  }
  if {$chan == "#dash-fr"} {
    puthelp "PRIVMSG $chan :$nick: $outtextfr"
  } elseif {$chan == "PRIVATE"} {
    puthelp "PRIVMSG $nick :$outtexten"
  } else {
    puthelp "PRIVMSG $chan :$nick: $outtexten"
  }
}

# Bindings

# !donate
proc pub:donate {nick host handle chan {text ""}} {
  do_sendtext "donate" $nick $chan
}
proc msg:donate {nick uhost handle text} {
  do_sendtext "donate" $nick "PRIVATE"
}
# !info
proc pub:dashinfo {nick host handle chan {text ""}} {
  do_sendtext "infotest" $nick $chan
}
proc msg:dashinfo {nick uhost handle text} {
  do_sendtext "infotest" $nick "PRIVATE"
}

bind msg - !donate msg:donate
bind pub - !donate pub:donate

bind msg - !list msg:dashinfo
bind pub - !list pub:dashinfo
bind msg - !commands msg:dashinfo
bind pub - !commands pub:dashinfo
bind msg - !help msg:dashinfo
bind pub - !help pub:dashinfo

lappend dashircbot_command_fr { {!donate} {} }
lappend dashircbot_command_en { {!donate} {} }

putlog "++ $::dashircbot_simpletext_script v$dashircbot_simpletext_subversion loaded!"
