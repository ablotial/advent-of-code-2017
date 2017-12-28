#!/usr/bin/perl

use strict;
use warnings;

my @nodes = ();
my $num_groups = 0;
my $n = 0;
while( my $line = <> )
{
   chomp( $line );
   $nodes[$n] = $line;
   ++$n;
}

my $sz = 128;
my %seen = ();
for( my $i = 0; $i < $sz; ++$i ) #rows
{
   for( my $j = 0; $j < $sz; ++$j ) #cols
   {
      my $grp = $i . '_' . $j;
      if( !exists( $seen{$grp} ) and substr($nodes[$i], $j, 1) eq "1"  )
      {
         ++$num_groups;
         &traverse($grp);
      }
   }
   my $size = scalar keys %seen;
}
print "i found $num_groups groups\n";



sub traverse
{
   my $node = shift;
   $seen{$node} = 1;
   my @parts = split(/_/,$node);
   my $row = $nodes[$parts[0]];

   return if( substr($row, $parts[1], 1) eq "0" );
   
   if( $parts[1] - 1 >= 0 )
   {
      my $child = $parts[0] . '_' . ($parts[1]-1);
      &traverse($child) if( !exists $seen{$child} ); 
   }

   if( $parts[1] + 1 < $sz )
   {
      my $child = $parts[0] . '_' . ($parts[1]+1);
      &traverse($child) if( !exists $seen{$child} );
   }

   if( $parts[0] - 1 >= 0 )
   {
      my $child = ($parts[0] - 1) . '_' . $parts[1];
      &traverse($child) if( !exists $seen{$child} );
   }

   if( $parts[0] + 1 < $sz )
   {
      my $child = ($parts[0] + 1) . '_' . $parts[1];
      &traverse($child) if( !exists $seen{$child} );
   }
}
