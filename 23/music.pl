#!/usr/bin/perl

use strict;
use warnings;

my @instructions = ();
while( my $line = <> )
{
   chomp($line);
   push( @instructions, $line );
}

my %registers = ();
my %reg = ();
$registers{"A"} = \%reg;

my %sent = ();

my %iters = ();
$iters{"A"} = 0;

my $mul_count = 0;
while( $iters{"A"} < scalar @instructions )
{
   print "I am on step ". $iters{"A"} ."\n";
   my $inst = $instructions[$iters{"A"}];

   &move( $inst, "A" );
   ++$iters{"A"};
}
print "I multiplied $mul_count times.\n";

###########
# METHODS #
###########
sub move 
{
   my $inst = shift;
   my $which = shift;

   my @cols = split(/ /,$inst);
 
   while( $cols[0] eq "jnz" and &get_value($cols[1],$which) != 0 and $iters{$which} < @instructions )
   {
      $iters{$which} += &get_value($cols[2],$which);
      $inst = $instructions[$iters{$which}];
      @cols = split(/ /,$inst);
   }

   if( $cols[0] eq "set" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = &get_value($cols[2], $which );
      print "I set $cols[1] to $reg{$cols[1]}\n";
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "sub" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = 0 unless exists( $reg{$cols[1]} );
      $reg{$cols[1]} -= &get_value($cols[2], $which);
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "mul" )
   {
      ++$mul_count;
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = 0 unless exists( $reg{$cols[1]} );
      $reg{$cols[1]} *= &get_value($cols[2], $which);
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "jnz" and &get_value($cols[1], $which) != 0 )
   {
      $iters{$which} += $cols[2];
   }
   printreg( $which );
}

sub get_value
{
   my $val = shift;
   my $which = shift;

   my %reg = %{$registers{$which}} if( exists( $registers{$which} ) );

   if( $val =~ m/[a-z]/ )
   {
      if( exists( $reg{$val} ) )
      { $val = $reg{$val} }
      else
      { $val = 0; }
   }

   return $val;
}

sub printreg
{
   my $which = shift;
   my %reg = ();
   %reg = %{$registers{$which}} if( exists( $registers{$which} ) );

   print "reg $which: ";
   foreach my $key (keys %reg)
   {
      print "$key,$reg{$key}; ";
   }
   print "\n";
}
