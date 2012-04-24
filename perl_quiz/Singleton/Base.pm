#! /usr/bin/env perl
use strict;
package Singleton::Base;

# This is assuming that there is only one for
# all inherited as is the behavior in C++. 
# To change it to one per class we can
# change the $mySingleton to %mySingleton
# and s/$mySingleton/$mySingletons{$class}/
my $mySingleton;

sub new {
    my $class = $_[0];

    if (defined $mySingleton) {
	return $mySingleton;
    }

    $mySingleton = {
	_value => undef
    };

    bless $mySingleton, $class;
    return $mySingleton;
}


sub value {
    my $self = $_[0];
    my $value = $_[1];

    if (defined $value) {
	$self->{'_value'} = $value;
    }

    return $self->{'_value'};
}


1;
