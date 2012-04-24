#! /usr/bin/env perl
use strict;
package PerlQuiz;

use base 'Exporter';
our @EXPORT = (
    'compute_product_payout',
    'set_union',
    'set_intersection'
);

# Question 1
sub compute_product_payout {
    # This expects a string and then an amount
    # It then calculates and returns the payout
    my $type = $_[0]{'size'};
    my $amount = $_[0]{'base_price'};

    my %return_val = (
	payout => undef,
	error => undef
    );

    my %payouts = (
	tiny => .05,
	medium => .5,
	large => 1,
	mammoth => 2
    );

    my $rate = $payouts{$type};
    if ($rate) {
	$return_val{'payout'} =  $rate * $amount;
    } else {
	$return_val{'error'} = "'$type' is not valid"
    };
    
    return \%return_val;
}


sub set_union{
    # Dedupes the given array and returns the sorted set
    my @source_array = @_;

    # Dedupe the list.
    my %temp_hash;
    @temp_hash{@source_array} = undef;
    my @return_val = sort(keys %temp_hash);

    return @return_val;
}


sub set_intersection{
    # Returns a list of deduped elements that exist in both arrays
    # Since the test depends on order, and no preference is given,
    # reverse alphabetic is returned. This will pass the listed test.
    # The values returned are correct

    my @array_1 = @{$_[0]};
    my @array_2 = @{$_[1]};

    my @return_val = ();
    
    # Create a hash of possible values
    my %values;
    @values{@array_1} = undef;

    foreach (&set_union(@array_2)) {
	if (exists $values{$_}) {
	    push(@return_val, $_)
	}
    }

    return reverse(@return_val);
}


1;
