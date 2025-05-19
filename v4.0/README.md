Here are build instructions for the MS-DOS 4.0 sources.  The instructions are
for an installation of DOSBox or DOSEmu on a Linux host. Adaptation to a
Windows host is left as an exercise for the reader; it should be doable on
anything that has a Ruby interpreter available to run `make-disks.rb`.

DOSEMU is much faster than DOSBox, but only runs on Linux hosts with x86
hardware.

# For DOSBox

Start DOSBox and give the command `mount d ~/MS-DOS/v4.0` to point the D drive
to the directory `~/MS-DOS/v4.0`. Modify as needed if you cloned the repository
to a directory other than `~/MS-DOS`.

Change to `d:\src` and proceed with the build as described below.

You may use a different drive letter than D. If you do, you will need to edit
`src/SETENV.BAT` to reflect the change. Change the `BAKROOT` variable to match
the chosen drive letter.

# For DOSEMU

DOSEMU uses the D drive for its own purposes. You will need to choose another
letter. This will be most easily done from a command line, with
`dosemu -d ~/MS-DOS/v4.0`. This will put the `~/MS-DOS/v4.0` directory on the
first unused drive letter, which is G unless you have changed the configuration
to use that letter for something else.

You will then need to edit `src/SETENV.BAT` so that `BAKROOT` points to the
drive letter.  Then, in DOSEMU, change to `g:\src` or whatever other drive
letter is in use, and proceed with the build as described below.

# Building MS-DOS 4.0

Once you have changed to `d:\src` or whatever other drive letter is in use,
run `SETENV.BAT`. This will set the execution path and other environment
variables to use the bundled toolchain, a command-line-only distribution of
Microsoft C 5.1.

Then type `nmake`, and if you are using DOSBox, go get yourself some lunch.

# Creating the install images

This step runs on the host system. You will need a Ruby interpreter. Run
`make-disks.rb`. This script creates one set of install images. There should
be five images for 360K floppies, two for 720K floppies, one for a 1.2M floppy
and one for a 1.44M floppy.
