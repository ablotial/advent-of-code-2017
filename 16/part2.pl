#!/usr/bin/perl

use strict;
use warnings;

#my %moves = (6 => 0, 10 => 1, 12 => 2, 13 => 3, 3 => 4, 0 => 5, 7 => 6, 14 => 7, 11 => 8, 9 => 9, 1 => 10, 5 => 11, 2 => 12, 4 => 13, 15 => 14, 8 => 15 );

my @moves = ( 6, 10, 12, 13, 3, 0, 7, 14, 11, 9, 1, 5, 2, 4, 15, 8 );
my @programs = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p' );
my %seen = ();

for( my $i = 0; $i < 100; ++$i )
{
   my @temp = ();
   foreach my $m (@moves)
   {
      push( @temp, $programs[$m]);
   }
   @programs = @temp;
   my $str = join( "", @programs );
   if( !exists( $seen{$str} ) )
   {
      $seen{$str} = $i+1;
   }
   else
   {
      print "I'm at ". ($i+1) . "This string was last seen at " . $seen{$str} . "->" . (($i +1)% 24) . "\n";
   }

   print "".($i+1)." $str\n" if( $i < 41 );
}
print "it is the same as: " . (1000000001 % 24 ) . "\n";
