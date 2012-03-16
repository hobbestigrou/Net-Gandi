package Net::Gandi;

# ABSTRACT: A Perl interface for gandi api

use Moose;

use Net::Gandi::Client;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Net::Gandi::Hosting;

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

=method

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

1;
