#!/usr/bin/perl

use strict;
use warnings;

my $input = <>;
chomp($input);

print "length is " . length($input) . "\n";
my $half = (length($input))/2;

my @nums = split(//,$input);

my $sum = 0;
for( my $i = 0; $i < (scalar @nums); ++$i )
{
   if( $nums[$i] == $nums[$half] )
   {
      $sum += $nums[$i];
   }

   $half = 0 if( ++$half == length($input) );
}

print "$sum\n";
