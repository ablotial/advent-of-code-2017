#!/usr/bin/perl

use strict;
use warnings;

my $count = 0;
my $valid = 1;
while( my $line = <> )
{
   $valid = 1;
   print "$line";
   chomp($line);
   my @words = split(/\s/,$line);
   my %sorted = ();

   my $len = scalar(@words);
   for( my $i = 0; $i < $len; ++$i )
   {
      my @chars = split(//,$words[$i]);
      my @sort = sort @chars;
      my $new_word = "";
      foreach my $letter (@sort)
      {
         $new_word .= $letter;
      }
      print $words[$i] ."-> $new_word\n";
      if( exists( $sorted{$new_word} ) )
      {
         $valid = 0;
         next;
      }
      $sorted{$new_word} = 1;
   }
   $count++ if( $valid );
}

print "there are $count valid phrases\n";
