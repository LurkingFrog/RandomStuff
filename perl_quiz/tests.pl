#! /usr/bin/env perl
use strict;

use Test::More qw(no_plan);
use PerlQuiz;


# Tests for question 1
print "Running compute_product_payout tests\n";
my $result = compute_product_payout({size => 'mammoth', base_price => 2.31});
is $result->{payout}, 4.62;

$result = compute_product_payout({size => 'tiny', base_price => 100});
is $result->{payout}, 5;

$result = compute_product_payout({size => 'micro', base_price => 100});
is $result->{payout}, undef;
is $result->{error}, "'micro' is not valid";


# Tests for question 2
print "\n\nRunning set_union tests\n";
my @union = set_union(1, 2, 4, 3, 7, 4, 3, 1);

# This only passes if @union is ordered
is_deeply([@union], [1, 2, 3, 4, 7]);


# Tests for question 3
print "\n\nRunning set_intersection tests\n";
my @overlapping = set_intersection(['a', 'b', 2, 7, 0], [9, 10, 3, 'c', 'a', 2]);
is_deeply([@overlapping], ['a', 2]);

# Test the empty set
@overlapping = set_intersection([], [9, 10, 3, 'c', 'a', 2]);
is_deeply([@overlapping], []);


# Tests for question 4
print "\n\nRunning set_difference tests\n";
my @difference = set_difference( [1..5], [4..8] );
is_deeply([@difference], [1..3, 6..8]);


# Tests for question 5
print "\n\nRunning set_eq tests\n";
ok( set_eq([1, 2, 3], [3, 1, 2]) );
ok( !set_eq([1, 2, 3], [3, 3, 1, 2]) );


# Tests for question 6
print "\n\nRunning deep_set_eq tests\n";
ok( 
    deep_set_eq(
	[1, 2, [4, 3], ['banana', 'apple']],
	[['apple', 'banana'], 2, [3, 4], 1]
    ) 
);
ok( 
    !deep_set_eq(
	 [1, 2, [4, 3], ['cherimoya', 'apple']],
	 [['apple', 'banana'], 2, [3, 4], 1]
    ) 
);


1;
