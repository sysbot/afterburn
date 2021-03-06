#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

check() {
    return 0
}

depends() {
    echo systemd network
}

install() {
    inst_multiple afterburn

    inst_simple "$moddir/afterburn-hostname.service" \
        "$systemdutildir/system/afterburn-hostname.service"

    # We want the afterburn-hostname to be firstboot only, so Ignition-provided
    # hostname changes do not get overwritten on subsequent boots

    mkdir -p "$initdir/$systemdsystemunitdir/ignition-complete.target.requires"
    ln -s "../afterburn-hostname.service" "$initdir/$systemdsystemunitdir/ignition-complete.target.requires/afterburn-hostname.service"
}
