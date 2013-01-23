# -*- perl -*-
# More random testing

use Test::More tests => 4;

use Business::PostNL;

my $tnt  = Business::PostNL->new ();
my $cost = $tnt->calculate(
               country => 'NL',
               weight  => '345',
               register=> 1,
               machine => 1
           );
is($cost, '6.80');

$tnt  = Business::PostNL->new ();
$cost = $tnt->calculate(
               country => 'MK',
               weight  => '1234',
               priority=> 1,
           );
is($cost, '9.24');

$tnt  = Business::PostNL->new ();
$cost = $tnt->calculate(
               country => 'US',
               weight  => '3513',
               large   => 1,
           );
is($cost, '34.20');

$tnt  = Business::PostNL->new ();
$cost = $tnt->calculate(
               country => 'VA',
               weight  => '666',
               register=> 1
           );
is($cost, '12.32');
