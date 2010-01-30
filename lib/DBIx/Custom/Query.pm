package DBIx::Custom::Query;

use strict;
use warnings;

use base 'Object::Simple';

__PACKAGE__->attr([qw/sql key_infos bind_filter fetch_filter sth/]);
__PACKAGE__->attr(_no_bind_filters => sub { {} });
__PACKAGE__->attr(no_fetch_filters => sub { [] });

sub new {
    my $self = shift->SUPER::new(@_);
    
    # Initialize attributes
    $self->no_bind_filters($self->{no_bind_filters})
      if $self->{no_bind_filters};
    
    return $self;
}

sub no_bind_filters {
    my $self = shift;
    
    if (@_) {
        # Set
        $self->{no_bind_filters} = $_[0];
        
        # Cached
        my %no_bind_filters = map { $_ => 1 } @{$self->{no_bind_filters}};
        $self->_no_bind_filters(\%no_bind_filters);
        
        return $self;
    }
    
    return $self->{no_bind_filters};
}

1;

=head1 NAME

DBIx::Custom::Query - DBIx::Custom query

=head1 SYNOPSIS
    
    # New
    my $query = DBIx::Custom::Query->new;
    
    # Create by using create_query
    my $query = DBIx::Custom->create_query($template);
    
    # Set attributes
    $query->bind_filter($dbi->filters->{default_bind_filter});
    $query->no_bind_filters('title', 'author');
    
    $query->fetch_filter($dbi->filters->{default_fetch_filter});
    $query->no_fetch_filters('title', 'author');

=head1 ATTRIBUTES

=head2 sth

Statement handle

    $query = $query->sth($sth);
    $sth   = $query->sth;

=head2 sql

SQL

    $query = $query->sql($sql);
    $sql   = $query->sql;

=head2 bind_filter

Filter excuted when value is bind

    $query       = $query->bind_filter($bind_filter);
    $bind_filter = $query->bind_filter;

=head2 no_bind_filters

Key list which dose not have to bind filtering

    $query           = $query->no_bind_filters($no_filters);
    $no_bind_filters = $query->no_bind_filters;

=head2 fetch_filter

Filter excuted when data is fetched

    $query        = $query->fetch_filter($fetch_filter);
    $fetch_filter = $query->fetch_filter;

=head2 no_fetch_filters

Key list which dose not have to fetch filtering

    $query            = $query->no_fetch_filters($no_filters);
    $no_fetch_filters = $query->no_fetch_filters;

=head2 key_infos

Key informations

    $query     = $query->key_infos($key_infos);
    $key_infos = $query->key_infos;

=head1 METHODS

This class is L<Object::Simple> subclass.
You can use all methods of L<Object::Simple>

=head2 new

    my $query = DBIx::Custom::Query->new;

=cut
