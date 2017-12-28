#!/usr/bin/perl

use strict;
use warnings;

my $num = <>;

my @grid = ();
for( my $c = 0; $c < 620; $c++ )
{
   my @cols = ();
   for( my $d = 0; $d < 620; $d++ )
   {
      push(@cols,0);
      push(@grid,[@cols]);
   }
}

my $max = 0;
my $row = 0;
my $col = 0;


  $grid[0][0] = 1;
  $grid[1][0] = 0;
my $i = 0;
while( $i <= $num and $col < 3 )
{
  #$i = $grid[$row][$col-1] + $grid[$row][$col+1]
  #   + $grid[$row-1][$col-1] + $grid[$row-1][$col] + $grid[$row-1][$col+1] 
  #   + $grid[$row+1][$col-1] + $grid[$row+1][$col] + $grid[$row+1][$col+1];
  $i++;
print "grid[" . ($row). "][". ($col+1)."] = " . $grid[($row+1)][$col] . "\n";
print "grid[" . ($row+1). "][$col] = " . $grid[($row+1)][$col] . "\n";

  print $grid[$row-1][$col-1] ." ". $grid[$row-1][$col] ." ". $grid[$row-1][$col+1] . "\n";
  print $grid[$row][$col-1] ." ". $grid[$row][$col] . " ". $grid[$row][$col+1] . "\n";
  print $grid[$row+1][$col-1] ." ". $grid[$row+1][$col] ." ". $grid[$row+1][$col+1] . "\n";

  if( $i == $num ) {print abs($row) + abs($col) . " steps \n";}
  $grid[$row][$col] = $i;
  $grid[0][0] = 1;
  print "storing $i at [$row][$col]\n";
  if( $col == $max and $row == $max )
  {
     print "increasing col\n";
     $max++;
     ++$col;
  }
  elsif( $col == $max and $row != $max*-1 )
  {
     print "decreasing row\n";
     --$row;
  }
  elsif( $col == $max * -1 and $row == $max * -1 )
  {
     print "increasing row\n";
     ++$row;
  }
  elsif( $row == $max * -1 )
  {
      print "decreasing col\n";
      --$col;
  }
  elsif( $row == $max )
  {
      print "increasing col\n";
      ++$col;
  }
  elsif( $col == $max * -1 )
  {
     print "increasing row\n";
     ++$row;
  }
}
print "stored $i > $num \n";

