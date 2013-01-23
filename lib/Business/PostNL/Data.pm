package Business::PostNL::Data;
use strict;
use base 'Exporter';
use vars qw($VERSION @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Carp;
use YAML;

$VERSION   = 0.12;
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
      0 => [ qw(NL) ],                                           # NL
      1 => [ qw(BE LU DK DE FR IT AT ES GB SE) ],                # EU 1
      2 => [ qw(BG EE FI HU IE LV LT PL PT RO SI SK CZ) ],       # EU 2
      3 => [ qw(AL AD BA IC CY FO GI GR GL IS HR LI MK MD MT
                ME NO UA SM RS TR VA BY CH) ],                   # EU 3
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
      '0,20': 0.54
      '21,50': 1.08
      '51,100': 1.62
      '101,250': 2.16
      '251,500': 2.70
      '501,2000': 2.70
    machine:
      '0,20': 0.47
      '21,50': 0.89
      '51,100': 1.41
      '101,250': 1.88
      '251,500': 2.35
      '501,2000': 2.82
  # Parcels (paketten)
  large:
    stamp:
      '2000,10000': 6.75
      '10001,30000': 12.40
    machine:
      '2000,10000': 6.75
  # Register (aangetekend)
  register:
    stamp:
      '0,2000': 7.70
      '2001,10000': 8.05
      '100001,30000': 13.70
    machine:
      '0,2000': 7.47
      '2001,10000': 6.75
# Outside of the Netherlands
world:
  # letters
  small:
    # Within Europe (EU1 & EU2 & EU3)
    europe:
      stamp:
        normal:
          '0,20': 0.90
          '21,50': 1.80
          '51,100': 2.70
          '101,250': 4.50
          '251,500': 7.20
          '501,2000': 9.00
        register:
          '0,2000': 9.50
      machine:
        normal:
          '0,20': 0.87
          '21,50': 1.75
          '51,100': 2.62
          '101,250': 4.37
          '251,500': 6.98
          '501,2000': 8.73
        register:
          '0,2000': 9.22
    # Outside Europe
    world:
      stamp:
        normal:
          '0,20': 0.95
          '21,50': 1.90
          '51,100': 2.85
          '101,250': 4.75
          '251,500': 9.50
          '500,2000': 12.35
        register:
          '0,2000': 16.00
      machine:
        normal:
          '0,20': 0.92
          '21,50': 1.84
          '51,100': 2.75
          '101,250': 4.61
          '251,500': 9.22
          '501,2000': 11.98
        register:
          '0,2000': 15.52
  # parcels
  large:
    zone:
      # EU1
      1:
        stamp:
          normal:
            '0,2000': 9.00
          tracktrace:
            '0,2000': 13.00
            '2001,5000': 19.50
            '5001,10000': 25.00
            '10001,20000': 34.00
            '20001,30000': 41.15
          register:
            '0,2000': 14.30
            '2001,5000': 20.80
            '5001,10000': 26.30
            '10001,20000': 35.30
            '20001,30000': 42.45
        machine:
          normal:
            '0,2000': 8.73
          tracktrace:
            '0,2000': 13.00
            '2001,5000': 19.50
            '5001,10000': 25.00
            '10001,20000': 34.00
          register:
            '0,2000': 14.30
            '2001,5000': 20.80
            '5001,10000': 26.30
            '10001,20000': 35.30
      # EU2
      2:
        stamp:
          normal:
            '0,2000': 10.80
          tracktrace:
            '0,2000': 18.50
            '2001,5000': 25.00
            '5001,10000': 31.00
            '10001,20000': 40.00
            '20001,30000': 48.40
          register:
            '0,2000': 19.80
            '2001,5000': 26.30
            '5001,10000': 32.30
            '10001,20000': 41.30
            '20001,30000': 49.70
        machine:
          normal:
            '0,2000': 10.48
          tracktrace:
            '0,2000': 18.50
            '2001,5000': 25.00
            '5001,10000': 31.00
            '10001,20000': 40.00
          register:
            '0,2000': 19.80
            '2001,5000': 26.30
            '5001,10000': 32.30
            '10001,20000': 41.30
      # EU3
      3:
        stamp:
          normal:
            '0,2000': 11.70
          tracktrace:
            '0,2000': 19.30
            '2001,5000': 26.30
            '5001,10000': 32.30
            '10001,20000': 42.30
          register:
            '0,2000': 20.60
            '2001,5000': 27.60
            '5001,10000': 33.60
            '10001,20000': 43.60
        machine:
          normal:
            '0,2000': 11.35
          tracktrace:
            '0,2000': 19.30
            '2001,5000': 26.30
            '5001,10000': 32.30
            '10001,20000': 42.30
          register:
            '0,2000': 20.60
            '2001,5000': 27.60
            '5001,10000': 33.60
            '10001,20000': 43.60
      # RoW2
      4:
        stamp:
          normal:
            '0,2000': 18.05
          tracktrace:
            '0,2000': 24.30
            '2001,5000': 34.30
            '5001,10000': 58.30
            '10001,20000': 105.30
          register:
            '0,2000': 25.60
            '2001,5000': 35.60
            '5001,10000': 59.60
            '10001,20000': 106.60
        machine:
          normal:
            '0,2000': 17.51
          tracktrace:
            '0,2000': 24.30
            '2001,5000': 34.30
            '5001,10000': 58.30
            '10001,20000': 105.30
          register:
            '0,2000': 25.60
            '2001,5000': 35.60
            '5001,10000': 59.60
            '10001,20000': 106.60
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
L<http://www.postnl.nl/>

=cut

1;
