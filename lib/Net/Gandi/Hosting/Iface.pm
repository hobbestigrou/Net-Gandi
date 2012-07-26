package Net::Gandi::Hosting::Iface;

# ABSTRACT: Iface interface

use Moose;
use MooseX::Params::Validate;
use Net::Gandi::Types Client => { -as => 'Client_T' };
use Net::Gandi::Error qw(_validated_params);

use Carp;

=attr id

rw, Int. Id of the iface.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $iface->list;

List network interfaces.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of List network interfaces

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( "iface.list", $params );
}

=method count

  $iface->count;

Count network interfaces..

  input: opts (HashRef) : Filtering options
  output: (Int)         : number of network interfaces.

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call('iface.count', $params);
}

=method info

Returns informations about the network interface

  input: None
  output: (HashRef) : Network interfaces informations

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call( 'iface.info', $self->id );
}

=method create

Create a iface.

  input: iface_spec (HashRef)   : specifications of network interfaces to create
  output: (ArrayRef)         : Operation iface create

=cut

sub create {
    my ( $self, $params ) = validated_list(
        \@_,
        iface_spec => { isa => 'HashRef' }
    );

    _validated_params('iface_create', $params);

    return $self->client->api_call( "iface.create", $params );
}

=method update

Updates network interface attributes.

  input: iface_spec (HashRef) : specifications of network interfaces to update.
  output: (HashRef)  : Iface update operation

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        iface_spec => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );
    _validated_params('iface_update', $params);

    return $self->client->api_call( "iface.update", $self->id, $params );
}

=method delete

Deletes a network interface.

=cut

sub delete {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call('iface.delete', $self->id);
}

1;
