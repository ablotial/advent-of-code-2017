#!/usr/bin/perl

use strict;
use warnings;

my %tower = ();
while( my $line = <> )
{
   my @cols = split(/\s/,$line);
   if( exists( $cols[2] ) )
   {
      my $parent = $cols[0];
      for( my $i = 3; $i < scalar(@cols); ++$i )
      {
          $cols[$i] =~ s/,//;
          $tower{$cols[$i]} = $parent;
      }
   }
}

my $last = "lbhigx";
while( exists( $tower{$last} ) )
{
   print "I am $last. my parent is $tower{$last}\n";
   $last = $tower{$last};
}
