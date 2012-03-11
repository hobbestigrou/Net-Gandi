package Net::Gandi::Hosting::Image;

use Moose;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);


sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->client->call_rpc( 'image.list', $params );
}

=head1 info

Perform a image.info

Params: None

=cut 

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'image.info', $self->id );
}

1;
