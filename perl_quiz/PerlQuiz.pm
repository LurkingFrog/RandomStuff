#! /usr/bin/env perl
use strict;
package PerlQuiz;

use base 'Exporter';
our @EXPORT = (
    'compute_product_payout',
    'set_union',
    'set_intersection',
    'set_difference',
    'set_eq'
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


# Question 2
sub set_union{
    # Dedupes the given array and returns the sorted set
    my @source_array = @_;

    # Dedupe the list.
    my %temp_hash;
    @temp_hash{@source_array} = undef;
    my @return_val = sort(keys %temp_hash);

    return @return_val;
}


sub common_elements{
    # This is the basis for finding either the intersection or
    # the difference. Making the code DRY, since the functions return
    # mutually exclusive sets

    # INTERSECTION - Returns a list of deduped elements that exist 
    # in both arrays
    
    # DIFFERENCE - Returns a list of deduped elements that exist 
    # in only one array

    # Can be either INTERSECTION or DIFFERENCE
    my $filter_type = $_[0];
    my @array_1 = @{$_[1]};
    my @array_2 = @{$_[2]};

    my @return_val = ();
    
    # Create a hash of potential values
    my %values;
    @values{@array_1} = undef;

    # Now we filter it down by the values in the other array
    foreach (&set_union(@array_2)) {
	if (exists $values{$_}) {
	    if ($filter_type eq 'INTERSECTION') {
		 push(@return_val, $_);

	    } elsif ($filter_type eq 'DIFFERENCE') {
		delete($values{$_});
	    }

	} elsif ($filter_type eq 'DIFFERENCE') {
	    push(@return_val, $_);
        }
    }

    # Add the remaining values, if necessary
    if ($filter_type eq 'DIFFERENCE') {
	@return_val = (@return_val, keys %values);
    }

    return sort(@return_val);
}


# Question 3
sub set_intersection{
    # Since the test depends on order and no preference is given,
    # reverse alphabetic is returned.

    return reverse(&common_elements("INTERSECTION", @_));
}


# Question 4
sub set_difference{
    return &common_elements("DIFFERENCE", @_);
}


# Question 5
sub set_eq{
    # Test if two arrays are equal

    my @array_1 = sort(@{$_[0]});
    my @array_2 = sort(@{$_[1]});

    if (scalar(@array_1) != scalar(@array_2)) {
	return "";
    }

    foreach (0..(scalar(@array_1) - 1)) {
	if ($array_1[$_] != $array_2[$_]) {
	    return "";
	}
    }
    
    # If we made it this far, it's true
    return 1;
}
1;
