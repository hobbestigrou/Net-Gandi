package Net::Gandi::Hosting;

# ABSTRACT: Hosting interface

use Moose;
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
    my ( $self, $id ) = @_;

    my $vm = Net::Gandi::Hosting::VM->new(
        client => $self->client,
        id     => $id // 0
    );

    return $vm;
}

sub disk {
    my ( $self, $id ) = @_;

    my $disk = Net::Gandi::Hosting::Disk->new(
        client => $self->client,
        id     => $id // 0
    );

    return $disk;
}

sub image {
    my ( $self, $id ) = @_;

    my $image = Net::Gandi::Hosting::Image->new(
        client => $self->client,
        id     => $id // 0
    );

    return $image;
}

sub iface {
    my ( $self, $id ) = @_;

    my $iface = Net::Gandi::Hosting::Iface->new(
        client => $self->client,
        id     => $id // 0
    );

    return $iface;
}

sub ip {
    my ( $self, $id ) = @_;

    my $ip = Net::Gandi::Hosting::IP->new(
        client => $self->client,
        id     => $id // 0
    );

    return $ip;
}

sub operation {
    my ( $self, $id ) = @_;

    my $operation = Net::Gandi::Hosting::Operation->new(
        client => $self->client,
        id     => $id // 0
    );

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
