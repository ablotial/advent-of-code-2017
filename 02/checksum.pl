#!/usr/bin/perl

use strict;
use warnings;

my $sum = 0;
my $divis_sum = 0;
while( my $line = <> )
{
   chomp($line);
   my @cols = split(/\s/,$line);

   my $max = 0;
   my $min = 10000;

   foreach my $val (@cols)
   {
      $max = $val if( $val > $max );
      $min = $val if( $val < $min );
      foreach my $v2 (@cols)
      {
         $divis_sum += ($val/$v2) if( $val != $v2 and $val % $v2 == 0 );
      }
   }  

   my $diff = $max - $min;
   $sum += $diff;
}

print "$sum\n";
print "$divis_sum\n";
