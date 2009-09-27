package SDL::Game::Rect;
use strict;
use warnings;

use base 'SDL::Rect';

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $x = shift || 0;
    my $y = shift || 0;
    my $w = shift || 0;
    my $h = shift || 0;

    my $self = $class->SUPER::new($x, $y, $w, $h);
    unless ($$self) {
        require Carp;
        Carp::croak SDL::GetError();
    }
    bless $self, $class;
    return $self;
}

#############################
## extra accessors
#############################
sub bottom {
    my ($self, $val) = (@_);
    if (defined $val) {
        $self->top($val - $self->height); # y = val - height
    }
    return $self->top + $self->height; # y + height
}

sub right {
    my ($self, $val) = (@_);
    if (defined $val) {
        $self->left($val - $self->width); # x = val - width
    }
    return $self->left + $self->width; # x + width
}

sub centerx {
    my ($self, $val) = (@_);
    if (defined $val) {
        $self->left($val - ($self->width >> 1)); # x = val - (width/2)
    }
    return $self->left + ($self->width >> 1); # x + (width/2)
}

sub centery {
    my ($self, $val) = (@_);
    if (defined $val) {
        $self->top($val - ($self->height >> 1)); # y = val - (height/2)
    }
    return $self->top + ($self->height >> 1); # y + (height/2)
}

sub size {
    my ($self, $w, $h) = (@_);
    
    return ($self->width, $self->height)  # (width, height)
        unless (defined $w or defined $h);
        
    if (defined $w) {
        $self->width($w); # width
    }
    if (defined $h) {
        $self->height($h); # height
    }
}

sub topleft {
    my ($self, $y, $x) = (@_);
    
    return ($self->top, $self->left) # (top, left)
        unless (defined $y or defined $x);

    if (defined $x) {
        $self->left($x); # left
    }
    if (defined $y) {
        $self->top($y); # top
    }
    return;
}

sub midleft {
    my ($self, $centery, $x) = (@_);
    
    return ($self->top + ($self->height >> 1), $self->left) # (centery, left)
        unless (defined $centery or defined $x);
    
    if (defined $x) {
        $self->left($x); # left
    }
    if (defined $centery) {
        $self->top($centery - ($self->height >> 1)); # y = centery - (height/2)
    }
    return;
}

sub bottomleft {
    my ($self, $bottom, $x) = (@_);
    
    return ($self->top + $self->height, $self->left) # (bottom, left)
        unless (defined $bottom or defined $x);

    if (defined $x) {
        $self->left($x); # left
    }
    if (defined $bottom) {
        $self->top($bottom - $self->height); # y = bottom - height
    }
    return;
}

sub center {
    my ($self, $centerx, $centery) = (@_);
    
    return ($self->left + ($self->width >> 1), $self->top + ($self->height >> 1))
        unless (defined $centerx or defined $centery);

    if (defined $centerx) {
        $self->left($centerx - ($self->width >> 1)); # x = centerx - (width/2)        
    }
    if (defined $centery) {
        $self->top($centery - ($self->height >> 1)); # y = centery - (height/2)
    }
    return;
}

sub topright {
    my ($self, $y, $right) = (@_);
    
    return ($self->top, $self->left + $self->width) # (top, right)
        unless (defined $y or defined $right);

    if (defined $right) {
        $self->left($right - $self->width); # x = right - width
    }
    if (defined $y) {
        $self->top($y); # top
    }
    return;
}

sub midright {
    my ($self, $centery, $right) = (@_);
    
    return ($self->top + ($self->height >> 1), $self->left + $self->width) # (centery, right)
        unless (defined $centery or defined $right);
    
    if (defined $right) {
        $self->left($right - $self->width); # x = right - width
    }
    if (defined $centery) {
        $self->top($centery - ($self->height >> 1)); # y = centery - (height/2)
    }
    return;
}

sub bottomright {
    my ($self, $bottom, $right) = (@_);
    
    return ($self->top + $self->height, $self->left + $self->width) # (bottom, right)
        unless (defined $bottom or defined $right);

    if (defined $right) {
        $self->left($right - $self->width); # x = right - width
    }
    if (defined $bottom) {
        $self->top($bottom - $self->height); # y = bottom - height
    }
    return;
}

sub midtop {
    my ($self, $centerx, $y) = (@_);
    
    return ($self->left + ($self->width >> 1), $self->top) # (centerx, top)
        unless (defined $centerx or defined $y);
    
    if (defined $y) {
        $self->top($y); # top
    }
    if (defined $centerx) {
        $self->left($centerx - ($self->width >> 1)); # x = centerx - (width/2)
    }
    return;
}

sub midbottom {
    my ($self, $centerx, $bottom) = (@_);
    
    return ($self->left + ($self->width >> 1), $self->top + $self->height) # (centerx, bottom)
        unless (defined $centerx or defined $bottom);
    
    if (defined $bottom) {
        $self->top($bottom - $self->height); # y = bottom - height
    }
    if (defined $centerx) {
        $self->left($centerx - ($self->width >> 1)); # x = centerx - (width/2)
    }
    return;    
}


42;
__END__

=head1 NAME

SDL::Game::Rect - SDL::Game object for storing and manipulating rectangular coordinates

=head1 SYNOPSIS


=head1 DESCRIPTION

C<< SDL::Game::Rect >> object are used to store and manipulate rectangular areas. Rect objects are created from a combination of left (or x), top (or y), width (or w) and height (or h) values, just like raw C<< SDL::Rect objects >>.

All C<< SDL::Game::Rect >> methods that change either position or size of a Rect return B<a new copy> of the Rect with the affected changes. The original Rect is B<not> modified. If you wish to modify the current Rect object, you can use the equivalent "in-place" methods that do not return but instead affects the original Rect. These "in-place" methods are denoted with the "ip" suffix. Note that changing a Rect's attribute is I<always> an in-place operation.


=head2 ATTRIBUTES

All Rect attributes are acessors, meaning you can get them by name, and set them by passing a value:

   $rect->left(15);
   $rect->left;       # 15

The Rect object has several attributes which can be used to resize, move and align the Rect.


=over 4

=item * width, w - gets/sets object's width

=item * height, h - gets/sets object's height

=item * left, x - moves the object left position to match the given coordinate

=item * top, y  - moves the object top position to match the given coordinate

=item * bottom - moves the object bottom position to match the given coordinate

=item * right - moves the object right position to match the given coordinate

=item * centerx - moves the object's horizontal center to match the given coordinate

=item * centery - moves the object's vertical center to match the given coordinate

=back

Some of the attributes above can be fetched or set in pairs:

  $rect->topleft(10, 15);   # top is now 10, left is now 15

  my ($width, $height) = $rect->size;


=over 4

=item * size - gets/sets object's size (width, height)

=item * topleft - gets/sets object's top and left positions

=item * midleft - gets/sets object's vertical center and left positions

=item * bottomleft - gets/sets object's bottom and left positions

=item * center - gets/sets object's center (horizontal(x), vertical(y))

=item * topright - gets/sets object's top and right positions

=item * midright - gets/sets object's vertical center and right positions

=item * bottomright - gets/sets object's bottom and right positions

=item * midtop - gets/sets object's horizontal center and top positions

=item * midbottom - gets/sets object's horizontal center and bottom positions

=back


=head2 METHODS 

Methods denoted as receiving Rect objects can receive either C<<SDL::Game::Rect>> or raw C<<SDL::Rect>> objects.

=head3 new ($left, $top, $width, $height)

Returns a new Rect object with the given coordinates. If any value is omitted (by passing undef), 0 is used instead.

=head3 copy

=head3 duplicate

Returns a new Rect object having the same position and size as the original

=head3 move(x, y)

Returns a new Rect that is moved by the given offset. The x and y arguments can be any integer value, positive or negative.

=head3 move_ip(x, y)

Same as C<<move>> above, but moves the current Rect in place and returns nothing.

=head3 inflate(x, y)

Grows or shrinks the rectangle. Returns a new Rect with the size changed by the given offset. The rectangle remains centered around its current center. Negative values will return a shrinked rectangle instead.

=head3 inflate_ip(x, y)

Same as C<<inflate>> above, but grows/shrinks the current Rect in place and returns nothing.

=head3 clamp($rect)

Returns a new Rect moved to be completely inside the Rect object passed as an argument. If the current Rect is too large to fit inside the passed Rect, it is centered inside it, but its size is not changed.

=head3 clamp_ip($rect)

Same as C<<clamp>> above, but moves the current Rect in place and returns nothing.

=head3 clip($rect)

Returns a new Rect with the intersection between the two Rect objects, that is, returns a new Rect cropped to be completely inside the Rect object passed as an argument. If the two rectangles do not overlap to begin with, a Rect with 0 size is returned.

=head3 clip_ip($rect)

Same as C<<clip>> above, but crops the current Rect in place and returns nothing. As the original method, the Rect becomes zero-sized if the two rectangles do not overlap to begin with.

=head3 union($rect)

Returns a new rectangle that completely covers the area of the current Rect and the one passed as an argument. There may be area inside the new Rect that is not covered by the originals.

=head3 union_ip($rect)

Same as C<<union>> above, but resizes the current Rect in place and returns nothing.

=head3 unionall( [$rect1, $rect2, ...] )

Returns the union of one rectangle with a sequence of many rectangles, passed as an ARRAY REF.

=head3 unionall_ip( [$rect1, $rect2, ...] )

Same as C<<unionall>> above, but resizes the current Rect in place and returns nothing.

=head3 fit($rect)

Returns a new Rect moved and resized to fit the Rect object passed as an argument. The aspect ratio of the original Rect is preserved, so the new rectangle may be smaller than the target in either width or height. 

=head3 fit_ip($rect)

Same as C<<fit>> above, but moves/resizes the current Rect in place and returns nothing.

=head3 normalize

Corrects negative sizes, flipping width/height of the Rect if they have a negative size. No repositioning is made so the rectangle will remain in the same place, but the negative sides will be swapped. This method returns nothing.

=head3 contains($rect)

Returns true (non-zero) when the argument is completely inside the Rect. Otherwise returns undef.

=head3 collidepoint(x, y)

Returns true (non-zero) if the given point is inside the Rect, otherwise returns undef. A point along the right or bottom edge is not considered to be inside the rectangle.

=head3 colliderect($rect)

Returns true (non-zero) if any portion of either rectangles overlap (except for the top+bottom or left+right edges).

=head3 collidelist( [$rect1, $rect2, ...] )

Test whether the rectangle collides with any in a sequence of rectangles, passed as an ARRAY REF. The index of the first collision found is returned. Returns undef if no collisions are found.

=head3 collidelistall( [$rect1, $rect2, ...] )

Returns an ARRAY REF of all the indices that contain rectangles that collide with the Rect. If no intersecting rectangles are found, an empty list ref is returned. 

=head3 collidehash( {key1 => $rect1, key2 => $rect2, ...} )

Receives a HASH REF and returns the a (key, value) list with the key and value of the first hash item that collides with the Rect. If no collisions are found, returns (undef, undef).

=head3 collidehashall( {key1 => $rect1, key2 => $rect2, ...} )

Returns a HASH REF of all the key and value pairs that intersect with the Rect. If no collisions are found an empty hash ref is returned. 


=head1 AUTHOR

Breno G. de Oliveira, C<< <garu at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to the bug tracker. I will be notified, and then you'll automatically be notified of progress on your bug as we make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SDL::Game::Rect


=head1 ACKNOWLEDGEMENTS

Many thanks to all SDL_Perl contributors, and to the authors of pygame.rect, in which this particular module is heavily based.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Breno G. de Oliveira, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=head1 SEE ALSO

perl, L<SDL>, L<SDL::Rect>, L<SDL::Game>