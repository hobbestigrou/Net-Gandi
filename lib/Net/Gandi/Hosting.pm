package Net::Gandi::Hosting;

# ABSTRACT: Hosting interface

use Moose;
use MooseX::Params::Validate;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Net::Gandi::Hosting::Datacenter;
use Net::Gandi::Hosting::VM;
use Net::Gandi::Hosting::Disk;
use Net::Gandi::Hosting::Image;
use Net::Gandi::Hosting::Iface;
use Net::Gandi::Hosting::IP;

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method vm

  my $vm = $hosting->vm;

Initialize the virtual machine environnement, and return an object representing it.

  input: id (Int) : optional, id of virtual machine
  output: A Net::Gandi::Hosting::VM object

=cut

sub vm {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $vm = Net::Gandi::Hosting::VM->new(%args);

    return $vm;
}

=method disk

  my $disk = $hosting->disk;

Initialize the disk environnement, and return an object representing it.

  input: id (Int) : optional, id of disk
  output: A Net::Gandi::Hosting::Disk object

=cut

sub disk {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $disk = Net::Gandi::Hosting::Disk->new(%args);

    return $disk;
}

=method image

  my $image = $hosting->image;

Initialize the image environnement, and return an object representing it.

  input: id (Int) : optional, id of image
  output: A Net::Gandi::Hosting::Image object

=cut

sub image {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $image = Net::Gandi::Hosting::Image->new(%args);

    return $image;
}

=method iface

  my $iface = $hosting->iface;

Initialize the iface environnement, and return an object representing it.

  input: id (Int) : optional, id of iface
  output: A Net::Gandi::Hosting::Iface object

=cut

sub iface {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $iface = Net::Gandi::Hosting::Iface->new(%args);

    return $iface;
}

=method ip

  my $ip = $hosting->ip;

Initialize the ip environnement, and return an object representing it.

  input: id (Int) : optional, id of ip
  output: A Net::Gandi::Hosting::IP object

=cut

sub ip {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $ip = Net::Gandi::Hosting::IP->new(%args);

    return $ip;
}

=method datacenter

  my $datacenter = $hosting->datacenter;

Initialize the datacenter environnement, and return an object representing it.

  input: none
  output: A Net::Gandi::Hosting::Datacenter object

=cut

sub datacenter {
    my ( $self ) = @_;

    my $datacenter = Net::Gandi::Hosting::Datacenter->new(
        client => $self->client,
    );

    return $datacenter;
}

1;
