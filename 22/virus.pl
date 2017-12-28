#!/usr/bin/perl

use strict;
use warnings;

my %grid = ();

my $row = 0;
my $start = 0;
while( my $line = <> )
{
   chomp($line);
   my @spots = split(//,$line);
   $start = (((scalar @spots) - 1 ) / 2 );
   for( my $col = 0; $col < scalar @spots; ++$col )
   {
      if( $spots[$col] eq '#' ) {
         $grid{$row.'_'.$col} = 'i';
         print "$row $col is infected.\n";
      } else {
         $grid{$row.'_'.$col} = 'c';
      }
   }
   ++$row;
}

my %states = ( 'c' => 'w', 'w' => 'i', 'i' => 'f', 'f' => 'c' );
my %left = ( 'u' => 'l', 'l' => 'd', 'd' => 'r', 'r' => 'u' );
my %right = ( 'u' => 'r', 'r' => 'd', 'd' => 'l', 'l' => 'u' );
my %reverse = ( 'u' => 'd', 'd' => 'u', 'r' => 'l', 'l' => 'r' );
my $current = $start . '_' . $start;
my $direction = 'u';
my $num_iters = 10000000;
my $num_infected = 0;

for( my $iter = 0; $iter < $num_iters; ++$iter )
{
    # change direction based on whether I'm infected or not.
   if( exists $grid{$current} and $grid{$current} eq 'i' ) {
      $direction = $right{$direction};
      #print "this node is already infected, cleaning up: $current\n";
   } elsif( exists $grid{$current} and $grid{$current} eq 'w' ) {
      ++$num_infected; # this node will get infected at the next step.
   } elsif( exists $grid{$current} and $grid{$current} eq 'f' ) {
      $direction = $reverse{$direction};
   } else { # node is clean.
      $grid{$current} = 'c' if( !exists $grid{$current} );
      $direction = $left{$direction};
      #print "infecting $current\n";
   }
   
    # toggle infected status
   $grid{$current} = $states{$grid{$current}};

   #print "now moving: $direction\n";
   $current = &move($current, $direction); 
}

print "i infected $num_infected nodes.\n";

sub move
{
   my $cur = shift;
   my $dir = shift;

    #row = 0, col = 1
   my @nums = split(/_/,$cur);
   
   if( $dir eq 'u' ) {
      --$nums[0];
   } elsif( $dir eq 'd' ) {
      ++$nums[0];
   } elsif( $dir eq 'l' ) {
      --$nums[1];
   } elsif( $dir eq 'r' ) {
      ++$nums[1];
   }

   return $nums[0] . '_' . $nums[1];
}
