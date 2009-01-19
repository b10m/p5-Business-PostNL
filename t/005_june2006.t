# -*- perl -*-

use Test::More tests => 4;

use Business::TNTPost::NL;

my $tpg  = Business::TNTPost::NL->new ();
my $cost = $tpg->calculate(
               country => 'PL',
               weight  => '345',
               register=> 1
           );
is($cost, '7.70');

$tpg  = Business::TNTPost::NL->new ();
$cost = $tpg->calculate(
               country => 'NL',
               weight  => '11337',
               priority=> 1,
               large   => 1 
           );
is($cost, undef);
is($Business::TNTPost::NL::ERROR, '1337 grams too heavy (max: 10000 gr.)');

$tpg  = Business::TNTPost::NL->new ();
$cost = $tpg->calculate(
               country => 'NL',
               weight  => '1337',
               priority=> 1,
               large   => 1 
           );
is($cost, '6.75');
