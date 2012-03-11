package Net::Gandi::Hosting::Datacenter;

use Moose;
use Net::Gandi::Types Client => { -as => 'Client_T' };

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->client->call_rpc( 'datacenter.list', $params );
}

1;

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>
