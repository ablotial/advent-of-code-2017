#!/usr/bin/perl

use strict;
use warnings;

my @list = ();
while( my $line = <> )
{
   chomp($line);
   push(@list,$line);
}
print "length of list is " . scalar(@list) . "\n";

my $steps = 0;
my $i = 0;
my $length = scalar(@list);
while( $i < $length )
{
   $steps++;
   print "moving " . $i;
   my $temp = $list[$i];
   if( $list[$i] > 2 )
   {
      ($list[$i])--;
   }
   else
   {
      ($list[$i])++;
   }
   $i += $temp;
   print ", now i=$i\n";
   print "I am on step $steps\n";
}
print "It took me $steps steps to escape.\n";
