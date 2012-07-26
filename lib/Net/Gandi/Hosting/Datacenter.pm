package Net::Gandi::Hosting::Datacenter;

# ABSTRACT: Datacenter interface

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $datacenter->list;

List available datacenters..

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of datacenter

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( 'datacenter.list', $params );
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
