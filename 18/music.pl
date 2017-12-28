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
my %A = ();
$A{"p"} = 0;
$registers{"A"} = \%A;
my %B = ();
$B{"p"} = 1;
$registers{"B"} = \%B;


my %sent = ();

my %stuck = ();
$stuck{"A"} = 0;
$stuck{"B"} = 0;

my %iters = ();
$iters{"A"} = 0;
$iters{"B"} = 0;

my $A_counter = 0;

while( (!$stuck{"A"} or !$stuck{"B"}) and $iters{"B"} < scalar @instructions )
{
   my $Ainst = $instructions[$iters{"A"}];
   my $Binst = $instructions[$iters{"B"}];

   print "A $iters{'A'}, B $iters{'B'}\n";
   &move( $Ainst, "A" );
   &move( $Binst, "B" );
   ++$iters{"A"} unless( $stuck{"A"} );
   ++$iters{"B"} unless( $stuck{"B"} );
}
print "Program B sent $A_counter times\n";

###########
# METHODS #
###########
sub move 
{
   my $inst = shift;
   my $which = shift;

   my @cols = split(/ /,$inst);
 
   while( $cols[0] eq "jgz" and &get_value($cols[1],$which) > 0 )
   {
      $iters{$which} += &get_value($cols[2],$which);
      $inst = $instructions[$iters{$which}];
      @cols = split(/ /,$inst);
   }

   if( $cols[0] eq "snd" )
   {
      my $value =  &get_value($cols[1], $which);
      my @sent = ();
      @sent = @{$sent{$which}} if( exists( $sent{$which} ) );
      push( @sent, $value );
      $sent{$which} = \@sent;

      ++$A_counter if( $which eq "B" );
      print "$which sent value $value\n";
   }
   elsif( $cols[0] eq "set" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = &get_value($cols[2], $which );
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "add" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = 0 unless exists( $reg{$cols[1]} );
      $reg{$cols[1]} += &get_value($cols[2], $which);
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "mul" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = 0 unless exists( $reg{$cols[1]} );
      $reg{$cols[1]} *= &get_value($cols[2], $which);
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "mod" )
   {
      my %reg = ();
      %reg = %{$registers{$which}} if( exists( $registers{$which} ) );
      $reg{$cols[1]} = 0 unless exists( $reg{$cols[1]} );
      $reg{$cols[1]} %= &get_value($cols[2], $which);
      $registers{$which} = \%reg;
   }
   elsif( $cols[0] eq "jgz" and &get_value($cols[1], $which) > 0 )
   {
      $iters{$which} += $cols[2];
   }
   elsif( $cols[0] eq "rcv" )
   {
      my @recvd = ();
      @recvd = @{$sent{"A"}} if( $which eq "B" and exists( $sent{"A"} ) );
      @recvd = @{$sent{"B"}} if( $which eq "A" and exists( $sent{"B"} ) );
      if( scalar @recvd == 0 )
      {
         $stuck{$which} = 1;
      }
      else
      {
         $stuck{$which} = 0;
         my %reg = ();
         %reg = %{$registers{$which}} if( exists( $registers{$which} ) );

         my $last = shift @recvd;
         $reg{$cols[1]} = $last;
         print "$which recovered value $last and stored in register $cols[1]\n";
         $registers{$which} = \%reg;
      }

      if( $which eq "A" ) {
         $sent{"B"} = \@recvd;
      } else {
         $sent{"A"} = \@recvd;
      }
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
