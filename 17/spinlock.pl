#!/usr/bin/perl

use strict;
use warnings;

my $skip = <>;
my $insert = 2;
my $position = 1;
my $max = 50000000;

while( $insert < $max + 1 )
{
   $position = ($position + $skip) % $insert;
   ++$position;
   print "value after 0 is now: $insert\n" if( $position == 1 );
   ++$insert;
}

