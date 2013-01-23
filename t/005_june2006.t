# -*- perl -*-

use Test::More tests => 4;

use Business::PostNL;

my $tpg  = Business::PostNL->new ();
my $cost = $tpg->calculate(
               country => 'PL',
               weight  => '345',
               register=> 1
           );
is($cost, '7.70');

$tpg  = Business::PostNL->new ();
$cost = $tpg->calculate(
               country => 'NL',
               weight  => '11337',
               priority=> 1,
               large   => 1 
           );
is($cost, undef);
is($Business::PostNL::ERROR, '1337 grams too heavy (max: 10000 gr.)');

$tpg  = Business::PostNL->new ();
$cost = $tpg->calculate(
               country => 'NL',
               weight  => '1337',
               priority=> 1,
               large   => 1 
           );
is($cost, '6.75');
