package Net::Gandi;

# ABSTRACT: A Perl interface for gandi api

use Moose;

use Net::Gandi::Client;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Net::Gandi::Hosting;
use Net::Gandi::Operation;

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

sub BUILDARGS {
    my ( $class, %args ) = @_;

    my $transport = 'XMLRPC';
    my $trait     = "Net::Gandi::Transport::" . $transport;

    my $client = Net::Gandi::Client->with_traits($trait)->new(%args);
    $args{client} = $client;

    \%args;
}

=method hosting

  my $client  = Net::Gandi->new(apikey => 'api_key');
  my $hosting = $client->hosting;

Initialize the hosting environnement, and return an object representing it.

  input: none
  output: A Net::Gandi::Hosting object

=cut

sub hosting {
    my ( $self ) = @_;

    my $hosting = Net::Gandi::Hosting->new( client => $self->client );
    $hosting;
}

=method operation

  my $operation = $client->operation;

Initialize the operation environnement, and return an object representing it.

  input: id (Int) : optional, id of operation
  output: A Net::Gandi::Hosting::Operation object

=cut

sub operation {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $operation = Net::Gandi::Operation->new(%args);

    return $operation;
}

1;
