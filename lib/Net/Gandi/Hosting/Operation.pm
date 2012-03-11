package Net::Gandi::Hosting::Operation;

use Moose;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;


has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'operation.info', $self->id );
}

1;

