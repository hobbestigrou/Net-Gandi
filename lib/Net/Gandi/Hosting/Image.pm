package Net::Gandi::Hosting::Image;

use Moose;
use utf8;

extends 'Net::Gandi';

=head1 NAME

Net::Gandi::Hosting::Image - Interface to manage image. 

=head1 DESCRIPTION

A image describes a system image with an operating system. It is associated with a disk that stores the filesystem. Methods below are read-only they do not modify any data or state.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 image_list 

Perform a image.list

Params: 

=over 

=item * 

label: Take a string, this a name of the operation system

=item * 

datacenter_id: Take a integer, this a location of the resource

=item * 

disk_id: Take a integer, this a id of the disk to use as a source

=item * 

visibility: Take a string ( public | private | alpha ), who can access this image

=item * 

os_arch: Take a string ( x86-32 | x86-64 ), CPU architecture this image is made for

=item * 

author_id: Take a integer, who is the author of this image

=back

=cut

sub image_list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( 'image.list', $params );
}

=head1 image_info

Perform a image.info

Params: None

=cut 

sub image_info {
    my ( $self ) = @_;

    return $self->call_rpc( 'image.info', $self->id );
}

1;

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>
