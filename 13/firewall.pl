#!/usr/bin/perl

use strict;
use warnings;

my $highest_scanner = 0;
my %max = ();
my %current = ();
my %direction = ();

while( my $line = <> )
{
   chomp $line;
   $line =~ s/ //g;
   my @cols = split(/:/,$line);

   $max{$cols[0]} = $cols[1];
   $current{$cols[0]} = 0;
   $direction{$cols[0]} = 1;
   $highest_scanner = $cols[0] if( $cols[0] > $highest_scanner );
}

my $step = 0;
my $safe = 0;
while( !$safe )
{
   print "0 -> $current{0}\n";
   if( $current{0} != 0 )
   {
      $safe = 1;
      print "it is safe to start at step $step\n";

      for( my $j = 1; $j <= $highest_scanner; ++$j )
      {
         if( exists( $max{$j} ) and (($step+$j) % (($max{$j} * 2) - 2)) == 0 )
         {
            print "caught at step $j.\n";
            $safe = 0;
            last;
         }
         else
         {
            print "$j will be at " . (($step+$j) % (($max{$j} * 2) - 2)). "\n" if( exists( $max{$j} ) );
         }
      }
   }

   if( $direction{0} == 1 )
   {
      ++$current{0};
      $direction{0} = 0 if( $current{0} == ($max{0}-1) );
   }
   else
   {
      --$current{0};
      $direction{0} = 1 if( $current{0} == 0 );
   }
   ++$step;
}

my $cost = 0;
   #part 1
   #if( exists $current{$i} and $current{$i} == 0 )
   #{
   #   print "caught at $i\n";
   #   $cost += ($i * ($max{$i}+1));
   #}

   #print "$i: ";
   #foreach my $k (keys %current)
   #{
   #   if( $direction{$k} == 1 )
   #   {
   #      ++$current{$k};
   #      $direction{$k} = 0 if( $current{$k} == $max{$k} );
   #   }
   #   else
   #   {
   #      --$current{$k};
   #      $direction{$k} = 1 if( $current{$k} == 0 );
   #   }
   #}
   #print "\n";


#print "cost of the trip was: $cost\n";


