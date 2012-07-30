package Net::Gandi::Domain;

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };

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

1;
