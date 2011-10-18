package Net::Gandi::Hosting::Datacenter;

use Moose;

extends 'Net::Gandi';

=head1 NAME

=encoding utf-8 

Net::Gandi::Hosting::Datacenter - Interface to manage datacenter. 

=head1 DESCRIPTION

A datacenter represents the location that hosts servers. Resources are bound to a datacenter. A VM in a datacenter can attach disks and network interfaces only from the same datacenter. You can migrate a VM, disks, and network interfaces to another datacenter.

=cut

=head1 list 

Perform a datacenter.list

=cut

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( 'datacenter.list', $params );
}

1;

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>
