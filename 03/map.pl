#!/usr/bin/perl

use strict;
use warnings;

my %map = ();
my $num = <>;
my $max = 0;
my $row = 0;
my $col = 0;
my $i = 0;

chomp($num);
$map{"0_0"} = 1;

while( $i <= $num or $col < 3)
{
  if( $row != 0 or $col != 0 )
  {
     $i = 0;
     for( my $idx = $col-1; $idx < $col+2; $idx++ )
     {
        for( my $idx2 = $row-1; $idx2 < $row+2; $idx2++ )
        {
           my $str = $idx2 . "_" . $idx;
           $i += $map{$str} if( exists( $map{$str} ) );
        }
     }
     my $str = $row . "_" . $col;
     $map{$str} = $i;
     print "storing $i < $num at $str\n";
     last if( $i >= $num );
  }

  if( $col == $max and $row == $max)
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
