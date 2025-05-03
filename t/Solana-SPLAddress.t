# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Solana-SPLAddress.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('Solana::SPLAddress') };
use feature 'say';
my $owner_bin = pack("H*", "4f095ac26ce0478b05c698697a0420ce5d57ea6de473ac55baefd4e72dc68cdc");
my $mint_usdc = pack("H*", "cfc3059718cccbafeaa32131ae6360fdff9dcff0f0cfe383b3926db1c203fd82");
my $token_address = pack("H*", "06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9");

my ($address, $bump) = Solana::SPLAddress::find_address([$owner_bin, $token_address], $mint_usdc);

ok($address, "Address found");
ok($bump, "Bump found");


