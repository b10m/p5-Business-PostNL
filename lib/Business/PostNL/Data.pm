package Business::PostNL::Data;
use strict;
use base 'Exporter';
use vars qw($VERSION @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Carp;
use YAML;

$VERSION   = 0.10;
@EXPORT    = qw();
@EXPORT_OK = qw(zones table);
%EXPORT_TAGS = ("ALL" => [@EXPORT_OK]);

=pod

=head1 NAME

Business::PostNL::Data - Shipping cost data for Business::PostNL

=head1 DESCRIPTION

Data module for Business::PostNL containing shipping cost
information, country zones etc.

Nothing to see here, the show is over, move along please.

=head2 METHODS

The following methods are used and can be exported

=head3 zones

Returns a hashref with country and zone numbers

=cut

sub zones {
   my %zones = (
      0 => [ qw(NL) ],						# NL
      1 => [ qw(BE LU DK DE FR IT AT ES GB SE) ],		# EU 1
      2 => [ qw(BG EE FI HU IE LV LT PL PT RO SI SK CZ) ],	# EU 2
      3 => [ qw(AL AD BA IC CY FO GI GR GL IS HR LI MK MD MT 
                ME NO UA SM RS TR VA BY CH) ],			# RoW 1
   );
   my %z;
   foreach my $key (keys %zones) {
      foreach my $val (@{$zones{$key}}) {
         $z{$val} = $key;
      }
   }
   return \%z;
}

=pod

=head3 table

This method contains the heart of this module, the lookup table

=cut

sub table {
my $table = Load(<<'...');
---
# Netherlands
netherlands:
  # Letters (brievenbuspost)
  small:
    stamp:
      '0,19': 0.44
      '20,49': 0.88
      '50,99': 1.32
      '100,249': 1.76
      '250,499': 2.20
      '500,1999': 2.64
      '2000,3000': 2.64
    machine:
      '0,19': 0.40
      '20,49': 0.80
      '50,99': 1.20
      '100,249': 1.60
      '250,499': 2.00
      '500,2000': 2.40
  # Parcels (paketten)
  large:
    '0,10000': 6.75
  # Register (aangetekend)
  register:
    stamp:
      '0,4999': 7.00
      '5000,10000': 8.50
    machine:
      '0,4999': 6.80
      '5000,10000': 8.25
# Outside of the Netherlands
world:
  basic:
    # Within Europe (EU1 & EU2)
    europe:
      # Letters (brievenbuspost)
      small:
        stamp:
          priority:
            '0,19': 0.77
            '20,49': 1.54
            '50,99': 2.31
            '100,249': 3.08
            '250,499': 6.16
            '500,2000': 9.24
          standard: 
            '0,19': 0.74
            '20,49': 1.48
            '50,99': 2.22
            '100,249': 2.96
            '250,499': 4.44
            '500,2000': 7.40
        machine:
          priority:
            '0,19': 0.75
            '20,49': 1.49
            '50,99': 2.24
            '100,249': 2.99
            '250,499': 5.98
            '500,2000': 8.96
          standard: 
            '0,19': 0.72
            '20,49': 1.44
            '50,99': 2.15
            '100,249': 2.87
            '250,499': 4.31
            '500,2000': 7.18
      # Internationaal Pakket Basis
      large:
        priority:
          '0,499': 6.16
          '500,2000': 11.55
        standard: 
          '0,499': 5.92
          '500,2000': 9.62
    # Outside Europe
    world: 
      # Letters (brievenbuspost)
      small:
        stamp:
          priority:
            '0,19': 0.95
            '20,49': 1.90
            '50,99': 2.85
            '100,249': 5.70
            '250,499': 10.45
            '500,2000': 19.95
        machine:
          priority:
            '0,19': 0.92
            '20,49': 1.84
            '50,99': 2.76
            '100,249': 5.53
            '250,499': 10.14
            '500,2000': 19.35
      # Internationaal Pakket Basis
      large:
        priority:
          '0,499': 10.45
          '500,2000': 19.95
        standard: 
          '0,499': 7.40
          '500,2000': 17.76
  # Internationaal Pakket Plus (Track&Trace)
  plus: 
    zone:
      # EU1
      1: 
        '0,1999': 13.10
        '2000,4999': 19.50
        '5000,9999': 25.20
        '10000,30000': 34.10
      # EU2
      2: 
        '0,1999': 18.80
        '2000,4999': 24.50
        '5000,9999': 30.80
        '10000,30000': 39.80
      # RoW1
      3: 
        '0,1999': 18.80
        '2000,4999': 25.00
        '5000,9999': 31.20
        '10000,20000': 41.30
      # RoW2
      4: 
        '0,1999': 24.10
        '2000,4999': 34.20
        '5000,9999': 57.10
        '10000,20000': 104.10
  # Register ("aangetekend")
  register:
    europe:
      stamp:
        '0,499': 7.70
        '500,2000': 12.32
      machine:
        '0,499': 7.47
        '500,2000': 11.95
    world:
      stamp:
        '0,499': 10.45
        '500,2000': 21.85
      machine:
        '0,499': 10.14
        '500,2000': 21.19
...
   return $table;
}

=pod

=head1 AUTHOR

Menno Blom, 
E<lt>blom@cpan.orgE<gt>, 
L<http://menno.b10m.net/perl/>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Business::PostNL>,
L<http://www.tntpost.nl/>

=cut

1;
