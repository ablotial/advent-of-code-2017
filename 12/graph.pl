#!/usr/bin/perl

use strict;
use warnings;

my %nodes = ();
my $num_groups = 0;
while( my $line = <> )
{
   chomp( $line );
   $line =~ s/,//g;
   my @cols = split(/ /,$line);
   my $n = $cols[0];

   splice(@cols,0,2);
   $nodes{$n} = \@cols;
}

my @root = @{$nodes{"0"}};
my %seen = ();
foreach my $grp ( keys %nodes )
{
   if( !exists( $seen{$grp} ) )
   {
      ++$num_groups;
      &traverse($grp);
   }
   my $size = scalar keys %seen;
   print "size is :$size\n";
}
print "i found $num_groups groups\n";



sub traverse
{
   my $node = shift;
   $seen{$node} = 1;
   my @children = @{$nodes{$node}};
   foreach my $child (@children)
   {
      &traverse($child) if( !exists($seen{$child}) );
   }
}
