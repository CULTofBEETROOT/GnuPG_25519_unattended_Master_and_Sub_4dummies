#!/usr/bin/expect -f

# ==========================================================
# CONFIGURATION
# ==========================================================
set timeout -1
set USER_HOME "/root/gpg"
set KEY_DIR $USER_HOME
set GNUPG_HOME "$USER_HOME/.gnupg"

set NAME_REAL "someUserRealName"
set EMAIL "some.body@example.com"
set COMMENT "automated ED25519 key"
set EXPIRATION "1d"

set ::env(GNUPGHOME) $GNUPG_HOME

# Ensure GNUPGHOME exists
file mkdir $GNUPG_HOME
exec chmod 700 $GNUPG_HOME

# ==========================================================
# STEP 1 — GENERATE MASTER KEY (ED25519)
# ==========================================================

puts "\n=== Generating Master Key (ED25519) ===\n"

spawn gpg --expert --full-gen-key

expect "Please select what kind of key you want"
send "9\r"

expect "Please select which elliptic curve you want"
send "1\r"

expect "Key is valid for"
send "$EXPIRATION\r"

expect "Is this correct"
send "y\r"

expect "Real name"
send "$NAME_REAL\r"

expect "Email address"
send "$EMAIL\r"

expect "Comment"
send "$COMMENT\r"

expect "Change (N)ame"
send "O\r"

puts "\n======================================================"
puts "ENTER YOUR PASSPHRASE NOW"
puts "Move mouse / type if entropy is requested"
puts "======================================================\n"

interact
wait

# ==========================================================
# STEP 2 — EXTRACT MASTER FINGERPRINT (SAFE METHOD)
# ==========================================================

puts "\n=== Collecting Master Key Fingerprint ===\n"

set KEY_FPR ""

#set out [exec gpg --list-secret-keys --with-colons]
set out [exec sh -c "gpg --batch --with-colons --list-secret-keys 2>&1"]

foreach line [split $out "\n"] {
    if {[string match "fpr:*" $line]} {
        set fields [split $line ":"]
        set KEY_FPR [lindex $fields 9]
        break
    }
}

if {$KEY_FPR eq ""} {
    puts "ERROR: Could not extract fingerprint."
    exit 1
}

puts "Master Key Fingerprint: $KEY_FPR"

# ==========================================================
# STEP 3 — ADD SUBKEYS
# ==========================================================

puts "\n=== Adding SIGN subkey (ed25519) ==="
spawn gpg --quick-add-key $KEY_FPR ed25519 sign $EXPIRATION
interact
wait

puts "\n=== Adding ENCRYPTION subkey (cv25519) ==="
spawn gpg --quick-add-key $KEY_FPR cv25519 encrypt $EXPIRATION
interact
wait

puts "\n=== Adding AUTH subkey (ed25519) ==="
spawn gpg --quick-add-key $KEY_FPR ed25519 auth $EXPIRATION
interact
wait

# ==========================================================
# STEP 4 — GENERATE REVOCATION CERTIFICATE
# ==========================================================

puts "\n=== Exporting Auto-Generated Revocation Certificate ==="

set auto_rev "$GNUPG_HOME/openpgp-revocs.d/${KEY_FPR}.rev"
set export_rev "$KEY_DIR/${KEY_FPR}_revocation.asc"

if {[file exists $auto_rev]} {
    file copy -force $auto_rev $export_rev
    exec chmod 600 $export_rev
    puts "Revocation certificate exported."
} else {
    puts "WARNING: Auto revocation certificate not found."
}

# ==========================================================
# STEP 5 — EXPORT KEYS
# ==========================================================

puts "\n=== Exporting Keys ==="

exec gpg --export-secret-keys $KEY_FPR > "$KEY_DIR/master_backup.gpg"
exec gpg --export-secret-subkeys $KEY_FPR > "$KEY_DIR/subkeys_backup.gpg"

# ==========================================================
# STEP 6 — CREATE README
# ==========================================================

puts "\n=== Creating README ==="

set readme [open "$KEY_DIR/README.txt" w]

puts $readme "Master Key Fingerprint: $KEY_FPR"
puts $readme "Owner: $NAME_REAL <$EMAIL>"
puts $readme "Created: [exec date]"
puts $readme "Expiration: $EXPIRATION"
puts $readme ""
puts $readme "Files generated:"
puts $readme "- master_backup.gpg"
puts $readme "- subkeys_backup.gpg"
puts $readme "- ${KEY_FPR}_revocation.asc"
puts $readme ""
puts $readme "Security Notes:"
puts $readme "- Keep master key offline."
puts $readme "- Use subkeys for daily operations."
puts $readme "- Store revocation certificate offline."

close $readme

# Secure backup permissions
exec chmod 600 "$KEY_DIR/master_backup.gpg"
exec chmod 600 "$KEY_DIR/subkeys_backup.gpg"
exec chmod 600 "$KEY_DIR/${KEY_FPR}_revocation.asc"

puts "\n======================================================"
puts "ALL OPERATIONS COMPLETE"
puts "Keys and backups stored in $KEY_DIR"
puts "======================================================\n"

exit
