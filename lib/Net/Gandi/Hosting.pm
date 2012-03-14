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
use Net::Gandi::Hosting::Operation;

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

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

sub operation {
    my ( $self, $id ) = validated_list(
        \@_,
        id => { isa => 'Int', optional => 1 }
    );

    my %args  = ( client => $self->client );
    $args{id} = $id if $id;

    my $operation = Net::Gandi::Hosting::Operation->new(%args);

    return $operation;
}

sub datacenter {
    my ( $self ) = @_;

    my $datacenter = Net::Gandi::Hosting::Datacenter->new(
        client => $self->client,
    );

    return $datacenter;
}

1;
