#!/usr/bin/perl

use strict;
use warnings;

my %weights = ();
my %children = ();
while( my $line = <> )
{
   my @cols = split(/\s/,$line);
   $cols[1] =~ s/[)(]//g;
   $weights{$cols[0]} = $cols[1];
   if( defined( $cols[2] ) )
   {
      my @temp = splice(@cols,3);
      my $str = join( " ", @temp);
      $str =~ s/,//g;
      $children{$cols[0]} = $str;
   }
}

#my $root = "tknk";
my $root = "gmcrj";

get_weight( $root );

sub get_weight
{
   my $node = shift;
   return $weights{$node} if( !exists($children{$node} ) );
   
   my $wt = $weights{$node};
   my @kids = split(/ /,$children{$node});
   my @kid_weights = ();
   foreach my $k (@kids)
   {
      push( @kid_weights, get_weight($k) );
   }

   my $temp = $kid_weights[0];
   for( my $i = 0; $i < scalar(@kids); ++$i )
   {
      $wt += $kid_weights[$i];
      if( $kid_weights[$i] != $temp ) {print "$node:  my kids have different weights. ". join(", ", @kid_weights) . "(" . join(", ", @kids) .")\n";
      print "I am $node, my weight is $wt\n";}
   }
   return $wt;
}
