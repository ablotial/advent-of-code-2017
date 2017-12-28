#!/usr/bin/perl

use strict;
use warnings;

my $count = 0;
my $in = <>;
chomp $in;
for( my $j = 0; $j < 128; ++$j )
#for( my $j = 0; $j < 8; ++$j )
{
   my $input = $in . "-$j";
   #print "$input: ";
   my @lengths = split(//,$input);
   for( my $l = 0; $l < scalar @lengths; ++$l )
   {
      $lengths[$l] = ord($lengths[$l]);
   }
   my @temp = (17, 31, 73, 47, 23);
   push( @lengths, @temp );
   
   my $position = 0;
   my @list = (0..255);
   #my @list = (0,1,2,3,4);
      #print "list is " . join( ",", @list ) . "\n";
   
   for( my $skip = 0; $skip < 64* scalar @lengths; ++$skip )
   {
      my $idx = $skip % scalar @lengths;
      my $currlen = $lengths[$idx];
      if( $position + $currlen < scalar @list )
      {
         my @arr = reverse( splice( @list, $position, $currlen ) );
         splice @list, $position, 0, @arr;
      }
      else
      {
         my @arr = splice( @list, $position, $currlen ); # get the end of the array
         my $missing = $currlen - scalar @arr;           # how many things missing?
         push( @arr, splice( @list, 0, $missing ) );     # get that many from the beginning
         @arr = reverse( @arr );			      # reverse the entire thing.
         splice( @list, 0, 0, splice( @arr, -1*$missing, $missing ) );
         splice( @list, $position, 0, @arr );      
      }
      #print join( ',', @list ) . "\n";
      $position += ( $currlen + $skip );
      $position = $position % scalar @list;
   }
   
   for( my $i = 0; $i < 16; ++$i )
   {
      my $calc = 0;
      for( my $j = 0; $j < 16; ++$j )
      {
         my $idx = $i*16 + $j;
         #print "$idx\n";
         $calc = $calc ^ $list[$idx];
      }
      #print sprintf("%02x", $calc);
      $count += () = sprintf("%b", $calc) =~ m/1/g;
      print sprintf("%08b", $calc);
   }
   print "\n";
}
print "I found $count 1s\n";
print "\n";
