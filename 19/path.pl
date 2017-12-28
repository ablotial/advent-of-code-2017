#!/usr/bin/perl

use strict;
use warnings;

my @grid = ();
while( my $line = <> )
{
   my @row = split(//,$line);
   push( @grid, \@row ); 
}

my $row = 0;
my $col = 0;

# find the starting point.
my @first_row = @{$grid[0]};
for( $col = 0; $col < scalar @first_row; ++$col )
{
   print "found: ' '\n";
   last if( $grid[$row][$col] eq "|" );
}

my $total_moves = 0;
print "I found the start at grid[$row][$col]\n";
my $letters = "";
my $direction = "D"; # first direction comes from top.
while( 1 ) # I'll break out when I find the end.
{
   print "trying grid[$row][$col]\n";
   die if( !exists $grid[$row][$col] or !defined $grid[$row][$col] );
   if( $grid[$row][$col] eq ' ' )
   {
      print "I found the end at grid[$row][$col]!\n";
      last;
   }
   elsif( $grid[$row][$col] eq "+" )
   {
      &findnext();
   }
   elsif( $grid[$row][$col] =~ m/([^-+|])/ )
   {
      $letters .= $1;
      print "$letters\n";
   }

   &move();
}
print "I moved $total_moves times.\n";

sub findnext
{
   if( $grid[$row+1][$col] =~ m/\S/ and $direction ne 'U' )
   {
      $direction = 'D';
   }
   elsif( $grid[$row-1][$col] =~ m/\S/ and $direction ne 'D' )
   {
      $direction = 'U';
   }
   elsif( $grid[$row][$col+1] =~ m/\S/ and $direction ne 'L' )
   {
      $direction = 'R';
   }
   elsif( $grid[$row][$col-1] =~ m/\S/ and $direction ne 'R' )
   {
      $direction = 'L';
   }
   else
   {
      die "something went wrong, i find it unlikely they end on +\n";
   }
}

sub move
{
   if( $direction eq 'D' )
   {
      $row += 1;
   }
   elsif( $direction eq 'U' )
   {
      $row -= 1;
   }
   elsif( $direction eq 'L' )
   {
      $col -= 1;
   }
   elsif( $direction eq 'R' )
   {
      $col += 1;
   }
   ++$total_moves;
}
