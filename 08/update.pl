#!/usr/bin/perl

use strict;
use warnings;

my %registers = ();

my $max = 0;
while( my $line = <> )
{
   chomp($line);
   my @cols = split(/ /,$line);

   $registers{$cols[0]} = 0 if( !exists( $registers{$cols[0]} ) );
   $registers{$cols[4]} = 0 if( !exists( $registers{$cols[4]} ) );

   if( operate( $registers{$cols[4]}, $cols[5], $cols[6] ) )
   {
      if( $cols[1] eq "inc" ) {
         $registers{$cols[0]} += $cols[2];
      } else {
         $registers{$cols[0]} -= $cols[2];
      }
   $max = $registers{$cols[0]} if( $registers{$cols[0]} > $max );
   } 
}
print "all time max is: $max\n";

$max = 0;
foreach my $key (keys %registers)
{
   $max = $registers{$key} if( $registers{$key} > $max );
}
print "max is $max\n";

sub operate 
{
   my $a = shift;
   my $operator = shift;
   my $b = shift;

   return $a >= $b if( $operator eq ">=" );
   return $a == $b if( $operator eq "==" );
   return $a <= $b if( $operator eq "<=" );
   return $a != $b if( $operator eq "!=" );
   return $a > $b if( $operator eq ">" );
   return $a < $b if( $operator eq "<" );
}

