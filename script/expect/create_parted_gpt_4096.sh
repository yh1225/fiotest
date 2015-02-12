#!/usr/bin/expect
set dev [lindex $argv 0]
spawn parted /dev/$dev

expect {
	"Welcome*" { send "mklabel\r" ;exp_continue }
	"New disk label type*" { send "gpt\r" ;exp_continue }
	"*Yes*" { send "Yes\r"  }

}
send "Yes\r"
send "mkpart\r"
send "$dev\r"
send "\r"
expect {
	"Start*" { send "4096\r" ;exp_continue }
	"End*" { send "'-1'\r" }
}
send "q\r"

expect eof
