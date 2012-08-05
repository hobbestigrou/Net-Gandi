package Net::Gandi::Domain;

# ABSTRACT: Domain interface

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;

=attr apikey

rw, Str. The domain name.

=cut

has domain => ( is => 'rw', isa => 'Str' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $domain->list;

List domains associated to the contact represented by apikey.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of domains

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( "domain.list", $params );
}

=method count

  $domain->count;

Count domains associated to the contact represented by apikey.

  input: opts (HashRef) : Filtering options
  output: (Int)         : count of domain

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call('domain.count', $params);
}

=method info

  $domain->info

Get domain information.

  input: None
  output: (HashRef) : Domain information

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter domain attribute is not defined'
        if ( ! $self->domain );
    return $self->client->api_call( 'domain.info', $self->domain );
}

1;
