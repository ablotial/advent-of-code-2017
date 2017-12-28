#!/usr/bin/perl

use warnings;
use strict;

my $max = 0;
# Candidate solution to <https://adventofcode.com/2017/day/11>

# Map a direction to the corresponding x and y increments
my %dirs = (
  n  => [ 0,  2],
  ne => [ 1,  1],
  se => [ 1, -1],
  s  => [ 0, -2],
  sw => [-1, -1],
  nw => [-1,  1],
);

# Convert a sequence of moves to a location, assuming you started at [0, 0]
sub get_location {
  my (@path) = @_;
  my $x = 0;
  my $y = 0;
  foreach my $step (@path) {
    my $increments = $dirs{$step};
    die "$step is not a known direction" unless $increments;
    $x += $increments->[0];
    $y += $increments->[1];
    my $dist =  &location2distance($x, $y);
    $max = $dist if( $dist > $max );
  }
  return($x, $y);
}

# Convert a location to a distance
sub location2distance {
  my ($x, $y) = @_;
  # Convert the point to the upper right quadrant
  $x = abs($x);
  $y = abs($y);
  # Different calculation depending upon whether we're above or below the diagonal
  $x >= $y + 2 ? $x : ($x + $y) / 2;
}

# Read eval print loop
for (;;) {
  print "> ";
  $_ = <>;
  last unless $_;
  chomp;
  my @directions = split(/\s+/);
  my @directions = split(/,/);
  my ($x, $y) = &get_location(@directions);
  my $dist =  &location2distance($x, $y);
  print "location = [$x, $y]; distance = ", $dist, "\n";
  $max = $dist if( $dist > $max );
}
print "max distance: $max\n";

1;
