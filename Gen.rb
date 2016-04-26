require 'openssl'
require 'gitlab/license'

license_text=<<HERE
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA7hl4YCe8Xdix4W2zm5+ODqqYQAEZOqZ/YvYjUrkoXRSMSP8q
848+h/obwbr1uHw/FSHMFT94qYh4JH2zug1MDojn5iBMWkHbzDr9dixmuMGh/8eO
2pbOcEfrB3MmjWcXbbmbDTAu2d3GbL3rcyUUBlF0js8ieXLz9QROA3jeRf8Z8GGq
ERY8yIwCKAQt/Ij96xvYLmhLvU+MeYxfO0U5+aUId2XTNVQWbLAoILmmhZUgY4hy
h/FicjNjHfu6AVhdvKkR+19Px41IPQiJOGXBsmKzwOSR21T3L2IYwQDxlJ5NkpN1
frJXIQiW1Ogt1q646oci4pC2lIbUWM7PngM15QIDAQABAoIBAQDJNLDq4OlnjPVV
APVkr4LGlhcvDz6Yt5aytDnJcDrR3clm7msHg6deFVdbcXiwvB4652KlGgwHiBGv
FKLKuO3q4nrFl8muBDWP8tG6CW+M9eTGV4c65XHypHPSydZsbA/6Y3zJukv9RFKo
Fh5gIZc4d6E+BYCmjSPnjAm5GW0MTBP3R4j1JibKtODW3h1ULX4lCiED+LlvP4dp
ARI4VqTAu4sAbzPA933quVH8cHmTIYeLe6/n6ShoihpCf5Q9RzoHpnhZJICXe9jD
D27qTxGHiWPovX4VOzytLQduMk35BXpDJjEhCTbciInUoI6nKJIHlzHuZkyTlGRj
7+hj5N/JAoGBAPrADVdrTcVOsuKU37TLE2DiXvY7BGwuEPW9f+3F8oCL9ddedZk6
JfPnnJm6OaPLZrc3eJkMr4M4nU6tH0XKtfO8XEZEnPjMh2dSp5aEeCa6TXj/qID8
CjFh1rN9la6IBvn7e46rV/E0j/XjLtEz6tHGoiMcVf9jW1x+F//GJVzTAoGBAPMV
nS4/USJRQWFFI5XCLyp6dTTxCwq+FXbro5diLqeuYO9iiTNezBt3CXUinzsFa5cf
rWT1+mq0MIMLOUKJZaaRz+W9ctEIEyAXQv6oXOVee/YQk7QdcHbnujV2LxFVVRcb
d/3eDp5KedaMxwUWjT3dnle7ZK7Ouc/PAjrou49nAoGAQTBYx5df+qHBI+LsXcZF
3XQ8l+sz9SPsyNZhQeGqb/zzBvDJxfI2F7jpH5Yokgq5Q3yqX6/KmWTIkMG1VaGj
uCAKJUKFRLF3qkb0xs7dpcPdjE168z2TMM9sz/EgTuWSWr8kmiy1ikHOA3DypPTI
YY0wbcxaFzEveVZWyuoqoH0CgYEArtFwhP4MP33oYyfx+5X3jbkb6cMgic1Cao/0
yr5Vh0oldIOM4GDgsS/eoVsQ4MV5JuolLWKpgWutJ9E+kNd3P1/GABdLJ4GDH6Ub
DUHP7TUSOViaoQI7C4iDpkckenbAByo+FVlJchVloiMETmh1k3R6l+Ww9va9MvJR
TERr/ykCgYEA6bKCm24IlNX24D82qO0LYu3Y+tthrVrLeyuIqzD/eFouquEJ7nNB
l6dush2tZep+egsgl5xFjRrc3gTaxNncLOFn6ABEf+fB9t2OEt/OlPoCZoG9Z0Mz
yTPbowz//zo4Hn0k03aQ2Cw1FNir6hM52tBBsPInt++ZNpcDczDG0Mk=
-----END RSA PRIVATE KEY-----
HERE

private_key = OpenSSL::PKey::RSA.new license_text
Gitlab::License.encryption_key = private_key
license = Gitlab::License.new
license.licensee = {
  "Name"    => "Douwe Maan",
  "Company" => "GitLab B.V.",
  "Email"   => "douwe@gitlab.com"
}

license.starts_at = Date.new(2015, 4, 24)
license.expires_at = Date.new(2016, 5, 23)
license.notify_admins_at  = Date.new(2016, 5, 19)
license.notify_users_at   = Date.new(2016, 5, 23)
license.block_changes_at  = Date.new(2016, 6, 7)

license.restrictions  = {
  active_user_count: 10000
}



puts "License:"

puts license

data = license.export

puts "Exported license:"

puts data

Gitlab::License.encryption_key = private_key.public_key

$license = Gitlab::License.import(data)

puts "Imported license:"

puts $license