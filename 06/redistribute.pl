#!/usr/bin/perl

use strict;
use warnings;

my %seen_before = ();
my $input = <>;
chomp($input);
my @array = split(/\t/,$input);
my $len = scalar(@array);
my $max = 0;
my $max_idx = 0;

my $seen = "";
for( my $i = 0; $i < $len; ++$i )
{
   $seen .= $array[$i];
   if( $array[$i] > $max )
   {
      $max = $array[$i];
      $max_idx = $i;
   } 
}

my $curr_idx = $max_idx;
my $distribute = $max;
my $count = 0;
while( !exists( $seen_before{$seen} ) )
{
   $seen_before{$seen} = $count;
   $distribute = $max;
   $array[$max_idx] = 0;
   while( $distribute > 0 )
   {
      $curr_idx = (++$max_idx) % $len;
      ($array[$curr_idx])++;
      --$distribute;
   }
   $seen = "";
   $max = 0;
   for( my $j = 0; $j < $len; ++$j ) 
   {
      if( $array[$j] > $max )
      {
         $max = $array[$j];
         $max_idx = $j;
      }
      $seen .= $array[$j];
   }
   ++$count;
}

print "I saw $seen before. It took $count times. I saw it " . ($count - $seen_before{$seen}). "times ago \n";
