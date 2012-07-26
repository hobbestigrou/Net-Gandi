package Net::Gandi::Operation;

# ABSTRACT: Operation interface

use Moose;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;


has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method info

  $operation->info;

Get operation information.

  input: None
  output: (HashRef) : Operation information

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call( 'operation.info', $self->id );
}

1;

