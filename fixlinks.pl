#!/usr/bin/perl -p
# -*- coding: utf-8 -*-

use 5.018;  # RHEL 7 e.g. moria
use File::Spec;
use File::Basename;
no strict;  # 🤠


sub fixlink {
    $link = $2;
    $current_file_directory = dirname($ARGV);

    # full URL or email link -- ignore
    $link =~ m{://} && return $link;
    $link =~ m{^mailto:} && return $link;

    # Capture a link with an anchor (e.g. "foo#bar").
    # $path contains the path part of the link (left of "#")
    # $anchor contains the "#" and the rest of the link.
    # Either one may be blank.
    ($path, $anchor) = ($link =~ m{^([^#]*)([#].*)?});

    # Anchor only (internal link)
    $path !~ /\S/ && return $link;

    # Convert site-relative path (i.e. relative do the document root) to
    # a doc-relative path (i.e. relative to the current file being processed).
    if ($path =~ m{^/}) {
        $abs_path = $document_root . $path;
        $path = File::Spec->abs2rel( $abs_path, $current_file_directory );
    }

    # Chop off trailing slash(es).
    $path =~ s{/+$}{};

    # Append a .md file extension if there's no extension.
    if ($path !~ /[.]\w+$/) {
        $path .= ".md";
    }

    "${path}${anchor}"
}



BEGIN {
    $document_root = qx{git rev-parse --show-toplevel} or die "Couldn't get git repo root";
    chomp($document_root);
    $document_root .= "/docs";


    # Captures links e.g. `[text](link)` (the ] and ( may have space in between)
    #    first capture group is from `[` to `(` plus whitespace
    #    second capture group is `link` (no whitespace on either side)
    #    third capture group is whitespace plus `)`
    $markdown_link_re = qr/
        (
            \[
            [^]]+
            \]
            \s*
            [(]
            \s*
        )
        (
            [^)]+?
        )
        (
            \s*
            [)]
        )/x;
}



### main loop

s/$markdown_link_re/$1.(fixlink).$3/ge

###

