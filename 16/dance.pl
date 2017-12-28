#!/usr/bin/perl

use strict;
use warnings;

my $line = <>;
chomp $line;
my @values = split(/,/,$line);
my $str = "abcdefghijklmnop";
my @programs = ();
my %seen = ();

for( my $i = 0; $i < 100; $i++ )
{
   print "$i: $str\n";
@programs = split("", $str);
if( exists( $seen{$str} ) )
{
   print "I've seen this string before at position " . $seen{$str} . "\n";
}
else
{
   $seen{$str} = $i;
}

foreach my $m (@values)
{
   my $type = substr($m, 0, 1);
   my $move = substr( $m, 1 );
   if( $type eq "s" )
   {
      my @end = splice( @programs, -1 * $move, $move );
      push( @end, @programs );
      @programs = @end;
   }
   elsif( $type eq "x" )
   {
      my @swap = split( /\//, $move );
      my $temp = $programs[$swap[0]];
      $programs[$swap[0]] = $programs[$swap[1]];
      $programs[$swap[1]] = $temp;
   }
   else
   {
      my @swap = split( /\//, $move );
      for( my $i = 0; $i < scalar @programs; ++$i )
      {
         if( $programs[$i] eq $swap[0] )
         {
            $programs[$i] = $swap[1];
         }
         elsif( $programs[$i] eq $swap[1] )
         {
            $programs[$i] = $swap[0];
         }
      }
   }
}
   $str = join( "", @programs );
}
print "$str\n";
print "1bil mod 60 is: " .(1000000000%60). "\n";
