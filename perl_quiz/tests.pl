#! /usr/bin/env perl
use strict;

use Test::More qw(no_plan);
use PerlQuiz;


# Tests for question 1
print "compute_product_payout tests\n";
my $result = compute_product_payout({size => 'mammoth', base_price => 2.31});
is $result->{payout}, 4.62;

$result = compute_product_payout({size => 'tiny', base_price => 100});
is $result->{payout}, 5;

$result = compute_product_payout({size => 'micro', base_price => 100});
is $result->{payout}, undef;
is $result->{error}, "'micro' is not valid";


# Tests for question 2
print "\n\nset_union tests\n";
my @union = set_union(1, 2, 4, 3, 7, 4, 3, 1);

# This only passes if @union is ordered
is_deeply([@union], [1, 2, 3, 4, 7]);


# Tests for question 3
print "\n\nset_intersection tests\n";
my @overlapping = set_intersection(['a', 'b', 2, 7, 0], [9, 10, 3, 'c', 'a', 2]);
is_deeply([@overlapping], ['a', 2]);

# Test the empty set
@overlapping = set_intersection([], [9, 10, 3, 'c', 'a', 2]);
is_deeply([@overlapping], []);


1;