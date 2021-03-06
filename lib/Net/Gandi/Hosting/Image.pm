package Net::Gandi::Hosting::Image;

# ABSTRACT: Disk image interface

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;

=attr id

rw, Int. Id of the image.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $image->list;

List avaible disk image.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of disk image

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( 'image.list', $params );
}

=method info

Perform a image.info

  input: None
  output: (HashRef) : Disk image informations

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call( 'image.info', $self->id );
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
