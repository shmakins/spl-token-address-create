package Solana::SPLAddress;

use 5.034000;
use strict;
use warnings;

our $VERSION = '0.01';
use Carp qw(croak);
use constant PDA_MAKER => "ProgramDerivedAddress";
use Digest::SHA qw(sha256);

require XSLoader;
XSLoader::load('Solana::SPLAddress', $VERSION);

sub find_address {
    my ($seeds, $program_id) = @_;

    my $seed = join "", @$seeds;
    for my $bump ( reverse(0..255) ) {
        my $address = create_address($seed, $program_id, $bump);
        if (defined $address) {
            return ($address, $bump);
        }
    }
    croak "Failed to generate SPL address";
}

sub create_address {
    my ($seed, $program_id, $bump) = @_;
    $seed .=  pack("C", $bump) . $program_id . PDA_MAKER;
    my $hash = sha256($seed);
    if (check_pub_address_is_ok($hash)) {
        return unpack('H*', $hash);
    }
    return undef;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Solana::SPLAddress - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Solana::SPLAddress;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Solana::SPLAddress, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 AUTHOR

Denys Fisher, E<lt>shmakins at gmail dot comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2025 by Denys Fisher

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.38.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
