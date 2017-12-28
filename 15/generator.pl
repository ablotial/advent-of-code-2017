#!/usr/bin/perl

use strict;
use warnings;

my $A = 512;
my $B = 191;
#my $A = 65;
#my $B = 8921;

my $A_factor = 16807;
my $B_factor = 48271;

my $modulo = 2147483647;

my $judge = 0;
#my $stop = 1060;
my $stop = 5000000;
for( my $i = 0; $i < $stop; ++$i )
{
   do {$A = ($A * $A_factor) % $modulo;} while( $A % 4 != 0 );
   do {$B = ($B * $B_factor) % $modulo;} while( $B % 8 != 0 );
print "$i\n" if( $i % 100000 == 0 );
   ++$judge if( substr( sprintf( "%016b", $A ), -16 ) eq substr( sprintf( "%016b", $B ), -16 ) );
}
print "the judge approved $judge entries.\n";
