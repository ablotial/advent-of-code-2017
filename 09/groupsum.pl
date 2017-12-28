#!/usr/bin/perl

use strict;
use warnings;

while( my $line = <> )
{
   chomp($line);

my $group_level = 0;
my $in_garbage = 0;
my $escaped = 0;
my $sum = 0;
my $garbage_chars = 0;

my @input = split(//,$line);
foreach my $c (@input)
{
   if( $escaped ) {
      $escaped = 0;
      #print "$c was escaped, ignoring\n";
   } elsif( $c eq "!" ) {
      $escaped = 1;
      #print "$c: escaping\n";
   } elsif( $c eq "<" and !$in_garbage) {
      $in_garbage = 1;
      #print "$c: found garbage\n";
   } elsif( $c eq ">" ) {
      #print "$c: out of garbage\n";
      $in_garbage = 0;
   } elsif( $c eq "{" and !$in_garbage ) {
      #print "$c: new group!\n";
      ++$group_level;
      $sum += $group_level;
   } elsif( $c eq "}" and !$in_garbage ) {
      --$group_level;
      #print "$c: group end\n";
   } elsif( $in_garbage ) {
      ++$garbage_chars;
      #print "$c\n";
   }
}

print "the sum is $sum\n";
print "$garbage_chars characters are in garbage.\n";
}
