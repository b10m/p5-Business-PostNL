# -*- perl -*-

use Test::More tests => 2;

use Business::TNTPost::NL;

my $tpg  = Business::TNTPost::NL->new ();
my $cost = $tpg->calculate(
               country => 'GB',
               weight  => '250',
           );
is($cost, '4.44');

# UK is not the ISO code, so it should take the same value as, say, Japan
$tpg  = Business::TNTPost::NL->new ();
$cost = $tpg->calculate(
               country => 'UK',
               weight  => '250',
           );
is($cost, '10.45');
