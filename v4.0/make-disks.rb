#!/usr/bin/env ruby

require 'set'

# These are the lists of files to include on the disks:

# 360 KB install disk
Distribution360_install = [
    # These two must be first
    'src/BIOS/io.sys',
    'src/DOS/msdos.sys',

    'src/CMD/COMMAND/command.com',
    'src/setup/autoexec.bat',
    'src/setup/config.sys',
    'src/DEV/COUNTRY/country.sys',
    'src/CMD/DISKCOPY/diskcopy.com',
    'src/DEV/DISPLAY/display.sys',
    'src/CMD/FDISK/fdisk.exe',
    'src/CMD/FORMAT/format.com',
    'src/CMD/KEYB/keyb.com',
    'src/DEV/KEYBOARD/keyboard.sys',
    'src/CMD/REPLACE/replace.exe',
    'src/SELECT/select.com',
    'src/SELECT/select.hlp',
    'src/SELECT/select.prt',
    'src/CMD/SYS/sys.com',
]

# 360 KB select disk
Distribution360_select = [
    'src/CMD/BACKUP/backup.com',
    'src/DEV/DISPLAY/EGA/ega.cpi',
    'src/CMD/FORMAT/format.com',
    'src/DEV/DISPLAY/LCD/lcd.cpi',
    'src/CMD/MODE/mode.com',
    'src/CMD/RESTORE/restore.com',
    'src/SELECT/select.dat',
    'src/SELECT/select.exe',
    'src/DEV/XMA2EMS/xma2ems.sys',
]

# 360 KB operating disk #1
Distribution360_operating_1 = [
    'src/CMD/COMMAND/command.com',
    'src/CMD/ASSIGN/assign.com',
    'src/CMD/ATTRIB/attrib.exe',
    'src/CMD/CHKDSK/chkdsk.com',
    'src/CMD/COMP/comp.com',
    'src/CMD/DEBUG/debug.com',
    'src/CMD/DISKCOMP/diskcomp.com',
    'src/CMD/EDLIN/edlin.com',
    'src/CMD/FC/fc.exe',
    'src/CMD/FILESYS/filesys.exe',
    'src/CMD/FIND/find.exe',
    'src/CMD/IFSFUNC/ifsfunc.exe',
    'src/CMD/JOIN/join.exe',
    'src/CMD/LABEL/label.com',
    'src/CMD/MEM/mem.exe',
    'src/CMD/MORE/more.com',
    'src/CMD/SHARE/share.exe',
    'src/CMD/SORT/sort.exe',
    'src/CMD/SUBST/subst.exe',
    'src/CMD/TREE/tree.com',
    'src/DEV/VDISK/vdisk.sys', # extra
    'src/CMD/XCOPY/xcopy.exe',
]

# 360 KB operating disk #2
Distribution360_operating_2 = [
    'src/CMD/COMMAND/command.com',
    'src/MEMM/MEMM/emm386.sys',
    'src/CMD/EXE2BIN/exe2bin.exe',
    # Missing: gwbasic.exe
    # Missing: link.exe
    'src/CMD/PRINT/print.com',
    'src/DEV/RAMDRIVE/ramdrive.sys',
    'src/DEV/SMARTDRV/smartdrv.sys',
    'src/DEV/XMA2EMS/xma2ems.sys',
]

# 360 KB operating disk #3
Distribution360_operating_3 = [
    # These two must be first
    'src/BIOS/io.sys',
    'src/DOS/msdos.sys',

    'src/CMD/COMMAND/command.com',
    'src/DEV/ANSI/ansi.sys',
    'src/CMD/APPEND/append.exe',
    'src/DEV/COUNTRY/country.sys',
    'src/DEV/DISPLAY/display.sys',
    'src/DEV/DRIVER/driver.sys',
    'src/CMD/FASTOPEN/fastopen.exe',
    'src/CMD/GRAFTABL/graftabl.com',
    'src/CMD/GRAPHICS/graphics.com',
    'src/CMD/GRAPHICS/graphics.pro',
    # Missing: himem.sys
    'src/CMD/KEYB/keyb.com',
    'src/DEV/KEYBOARD/keyboard.sys',
    'src/CMD/MODE/mode.com',
    'src/CMD/NLSFUNC/nlsfunc.exe',
    'src/DEV/PRINTER/printer.sys',
    'src/DEV/RAMDRIVE/ramdrive.sys',
    'src/CMD/RECOVER/recover.com',
    'src/DEV/PRINTER/4201/4201.cpi',
    'src/DEV/PRINTER/4208/4208.cpi',
    'src/DEV/PRINTER/5202/5202.cpi',
    # Missing: readme.txt
]

# 720 KB install
Distribution720_install = [
    # These two must be first
    'src/BIOS/io.sys',
    'src/DOS/msdos.sys',

    'src/CMD/COMMAND/command.com',
    'src/DEV/PRINTER/4201/4201.cpi',
    'src/DEV/PRINTER/4208/4208.cpi',
    'src/DEV/PRINTER/5202/5202.cpi',
    'src/DEV/ANSI/ansi.sys',
    'src/setup/autoexec.bat',
    'src/setup/config.sys',
    'src/DEV/COUNTRY/country.sys',
    'src/CMD/DISKCOPY/diskcopy.com',
    'src/DEV/DISPLAY/display.sys',
    'src/DEV/DRIVER/driver.sys',
    'src/DEV/DISPLAY/EGA/ega.cpi',
    'src/CMD/FASTOPEN/fastopen.exe',
    'src/CMD/FDISK/fdisk.exe',
    'src/CMD/FORMAT/format.com',
    'src/CMD/GRAFTABL/graftabl.com',
    'src/CMD/GRAPHICS/graphics.com',
    'src/CMD/GRAPHICS/graphics.pro',
    # Missing: himem.sys
    'src/CMD/KEYB/keyb.com',
    'src/DEV/KEYBOARD/keyboard.sys',
    'src/DEV/DISPLAY/LCD/lcd.cpi',
    'src/CMD/NLSFUNC/nlsfunc.exe',
    'src/CMD/PRINT/print.com',
    'src/DEV/PRINTER/printer.sys',
    'src/DEV/RAMDRIVE/ramdrive.sys',
    'src/CMD/REPLACE/replace.exe',
    'src/SELECT/select.dat',
    'src/SELECT/select.exe',
    'src/SELECT/select.hlp',
    'src/SELECT/select.prt',
    'src/CMD/SHARE/share.exe',
    'src/DEV/SMARTDRV/smartdrv.sys',
    'src/CMD/SYS/sys.com',
    'src/DEV/XMA2EMS/xma2ems.sys',
] # free: 19K

# 720 KB operating
Distribution720_operating = [
    'src/CMD/APPEND/append.exe',
    'src/CMD/ASSIGN/assign.com',
    'src/CMD/ATTRIB/attrib.exe',
    'src/CMD/BACKUP/backup.com',
    'src/CMD/CHKDSK/chkdsk.com',
    'src/CMD/COMMAND/command.com',
    'src/CMD/COMP/comp.com',
    'src/CMD/DEBUG/debug.com',
    'src/CMD/DISKCOMP/diskcomp.com',
    'src/CMD/DISKCOPY/diskcopy.com',
    'src/CMD/EDLIN/edlin.com',
    'src/MEMM/MEMM/emm386.sys',
    'src/CMD/EXE2BIN/exe2bin.exe',
    'src/CMD/FC/fc.exe',
    'src/CMD/FILESYS/filesys.exe',
    'src/CMD/FIND/find.exe',
    # Missing: gwbasic.exe
    'src/CMD/IFSFUNC/ifsfunc.exe',
    'src/CMD/JOIN/join.exe',
    'src/CMD/LABEL/label.com',
    # Missing: link.exe
    'src/CMD/MEM/mem.exe',
    'src/CMD/MODE/mode.com',
    'src/CMD/MORE/more.com',
    'src/CMD/PRINT/print.com',
    'src/CMD/RECOVER/recover.com',
    'src/CMD/REPLACE/replace.exe',
    'src/CMD/RESTORE/restore.com',
    'src/CMD/SORT/sort.exe',
    'src/CMD/SUBST/subst.exe',
    'src/CMD/TREE/tree.com',
    'src/DEV/VDISK/vdisk.sys', # extra
    'src/CMD/XCOPY/xcopy.exe',
    # Missing: readme.txt
    'src/DEV/XMAEM/xmaem.sys', # extra
] # free: 31K

# 1.2 MB and 1.44 MB
Distribution1440 = [
    # These two must be first
    'src/BIOS/io.sys',
    'src/DOS/msdos.sys',

    'src/CMD/COMMAND/command.com',
    'src/setup/autoexec.bat',
    'src/setup/config.sys',
    'src/DEV/PRINTER/4201/4201.cpi',
    'src/DEV/PRINTER/4208/4208.cpi',
    'src/DEV/PRINTER/5202/5202.cpi',
    'src/DEV/ANSI/ansi.sys',
    'src/CMD/APPEND/append.exe',
    'src/CMD/ASSIGN/assign.com',
    'src/CMD/ATTRIB/attrib.exe',
    'src/CMD/BACKUP/backup.com',
    'src/CMD/CHKDSK/chkdsk.com',
    'src/CMD/COMP/comp.com',
    'src/DEV/COUNTRY/country.sys',
    'src/CMD/DEBUG/debug.com',
    'src/CMD/DISKCOMP/diskcomp.com',
    'src/CMD/DISKCOPY/diskcopy.com',
    'src/DEV/DISPLAY/display.sys',
    'src/DEV/DRIVER/driver.sys',
    'src/CMD/EDLIN/edlin.com',
    'src/DEV/DISPLAY/EGA/ega.cpi',
    'src/MEMM/MEMM/emm386.sys',
    'src/CMD/EXE2BIN/exe2bin.exe',
    'src/CMD/FASTOPEN/fastopen.exe',
    'src/CMD/FC/fc.exe',
    'src/CMD/FDISK/fdisk.exe',
    'src/CMD/FILESYS/filesys.exe',
    'src/CMD/FIND/find.exe',
    'src/CMD/FORMAT/format.com',
    'src/CMD/GRAFTABL/graftabl.com',
    'src/CMD/GRAPHICS/graphics.com',
    'src/CMD/GRAPHICS/graphics.pro',
    'src/CMD/IFSFUNC/ifsfunc.exe',
    'src/CMD/JOIN/join.exe',
    'src/CMD/KEYB/keyb.com',
    'src/DEV/KEYBOARD/keyboard.sys',
    'src/CMD/LABEL/label.com',
    'src/DEV/DISPLAY/LCD/lcd.cpi',
    'src/CMD/MEM/mem.exe',
    'src/CMD/MODE/mode.com',
    'src/CMD/MORE/more.com',
    'src/CMD/NLSFUNC/nlsfunc.exe',
    'src/CMD/PRINT/print.com',
    'src/DEV/PRINTER/printer.sys',
    'src/DEV/RAMDRIVE/ramdrive.sys',
    'src/CMD/RECOVER/recover.com',
    'src/CMD/REPLACE/replace.exe',
    'src/CMD/RESTORE/restore.com',
    'src/SELECT/select.dat',
    'src/SELECT/select.exe',
    'src/SELECT/select.hlp',
    'src/SELECT/select.prt',
    'src/CMD/SHARE/share.exe',
    'src/DEV/SMARTDRV/smartdrv.sys',
    'src/CMD/SORT/sort.exe',
    'src/CMD/SUBST/subst.exe',
    'src/CMD/SYS/sys.com',
    'src/CMD/TREE/tree.com',
    'src/DEV/VDISK/vdisk.sys', # extra
    'src/CMD/XCOPY/xcopy.exe',
    'src/DEV/XMA2EMS/xma2ems.sys',
    'src/DEV/XMAEM/xmaem.sys', # extra
    # Missing: himem.sys
    # Missing: gwbasic.exe
    # Missing: link.exe
    # Missing: readme.txt
]

# These are text files and need CR-LF translation
CRLFFiles = Set.new([
    'autoexec.bat',
    'config.sys',
    'graphics.pro',
    'select.prt'
])

# Describes a disk format
class FloppyFormat
    attr :sector_size
    attr :cluster_size
    attr :reserved_sectors
    attr :num_fats
    attr :root_dir_size
    attr :total_sectors
    attr :media_descriptor
    attr :sectors_per_track
    attr :num_heads
    attr :hidden_sectors
    attr :drive_number
    attr :fat_size
    attr :sectors_per_fat
    attr :root_dir_sectors
    attr :num_clusters
    attr :num_bytes
    attr :fat_start
    attr :fat_bytes
    attr :root_dir_start
    attr :data_start
    attr :cluster_bytes

    DirEntrySize = 32

    def set_boot_params(bootsec, **args)
        if total_sectors < 0xFFFF then
            sectors1 = total_sectors
            sectors2 = 0
        else
            sectors1 = 0xFFFF
            sectors2 = total_sectors
        end
        fsize = sectors_per_fat
        serialnum = Time.now.tv_sec & 0xFFFFFFFF
        subst = [
            # DOS 2.0 BPB
            sector_size & 0xFF, sector_size >> 8,
            cluster_size,
            reserved_sectors & 0xFF, reserved_sectors >> 8,
            num_fats,
            root_dir_size & 0xFF, root_dir_size >> 8,
            sectors1 & 0xFF, sectors1 >> 8,
            media_descriptor,
            fsize & 0xFF, fsize >> 8,
            # DOS 3.31 BPB
            sectors_per_track & 0xFF, sectors_per_track >> 8,
            num_heads & 0xFF, num_heads >> 8,
            hidden_sectors & 0xFF, (hidden_sectors >> 8) & 0xFF,
                (hidden_sectors >> 16) & 0xFF, hidden_sectors >> 24,
            sectors2 & 0xFF, (sectors2 >> 8) & 0xFF,
                (sectors2 >> 16) & 0xFF, sectors2 >> 24,
            # DOS 4.0 BPB
            drive_number,
            0, # Reserved
            0x29,   # Indicates that this part is valid
            serialnum & 0xFF, (serialnum >> 8) & 0xFF,
                (serialnum >> 16) & 0xFF, serialnum >> 24,
        ]
        subst = (subst.map {|x| x.chr('ASCII-8BIT')}).join('')
        label = args[:volume_label] || 'NO NAME'
        label = (label + '           ')[0...11]
        fstype = 'FAT%02d   ' % fat_size
        label.force_encoding('ASCII-8BIT')
        fstype.force_encoding('ASCII-8BIT')

        bootsec[0x0B..0x3D] = subst + label + fstype
    end

    def initialize(**args)
        @sector_size = args[:sector_size] || 512
        @cluster_size = args[:cluster_size] || 1
        @reserved_sectors = args[:reserved_sectors] || 1
        @num_fats = args[:num_fats] || 2
        @root_dir_size = args[:root_dir_size] || 112
        args[:total_sectors] or raise RuntimeError, "Must specify total_sectors"
        @total_sectors = args[:total_sectors]
        @media_descriptor = args[:media_descriptor] || 0xF0
        @sectors_per_track = args[:sectors_per_track] || 16
        @num_heads = args[:num_heads] || 2
        @hidden_sectors = args[:hidden_sectors] || 0
        @drive_number = args[:drive_number] || 0x00

        # Layout and other derived attributes
        root_dir_bytes = root_dir_size * DirEntrySize
        @root_dir_sectors = (root_dir_bytes + sector_size - 1) / sector_size
        @fat_size = 12 # TODO: support FAT16
        @num_bytes = sector_size * (total_sectors + hidden_sectors)
        @num_clusters = (total_sectors - reserved_sectors - root_dir_sectors) / cluster_size
        max_cluster = num_clusters + 2
        @fat_bytes = (max_cluster * fat_size + 7) / 8
        @sectors_per_fat = (fat_bytes + sector_size - 1) / sector_size
        @fat_bytes = sectors_per_fat * sector_size
        @fat_start = reserved_sectors * sector_size
        @root_dir_start = fat_start + fat_bytes * num_fats
        @data_start = root_dir_start + root_dir_sectors * sector_size
        @cluster_bytes = sector_size * cluster_size
    end
end

# Describes a File Allocation Table
class FileAllocTable
    attr :table
    attr :fat_size
    attr :floppy
    attr :next_cluster

    def size
        table.size
    end

    def initialize(floppy)
        @table = []
        @floppy = floppy
        @fat_size = floppy.fat_size
        case fat_size
        when 12 then
            table[0] = floppy.media_descriptor | 0xF00
            table[1] = 0xFFF
        when 16 then
            table[0] = floppy.media_descriptor | 0xFF00
            table[1] = 0xFFFF
        when 32 then
            table[0] = floppy.media_descriptor | 0x0FFFFF00
            table[1] = 0x0FFFFFFF
        else
            raise RuntimeError, "fat_size must be 12, 16 or 32"
        end
    end

    # Cluster number used for end of file
    def eof
        table[1]
    end

    # Return a single copy of the FAT as a string
    def build_fat
        fat = []
        case fat_size
        when 12 then
            rec = nil
            table.each do |x|
                if rec.nil? then
                    rec = x
                else
                    rec = (x << 12) | rec
                    fat << (rec & 0xFF)
                    fat << ((rec >> 8) & 0xFF)
                    fat << (rec >> 16)
                    rec = nil
                end
            end
            if rec then
                fat << (rec & 0xFF)
                fat << (rec >> 8)
            end
        when 16 then
            table.each do |x|
                fat << (x & 0xFF)
                fat << (x >> 8)
            end
        when 32 then
            table.each do |x|
                fat << (x & 0xFF)
                fat << ((rec >> 8) & 0xFF)
                fat << ((rec >> 16) & 0xFF)
                fat << (rec >> 24)
            end
        end
        (fat.map {|x| x.chr('ASCII-8BIT')}).join('')
    end
end

# Describes a directory on the disk
class DiskDirectory
    attr :directory

    def size
        directory.size
    end

    def initialize
        @directory = []
    end

    def add_file(path, first_cluster, size)

        first_cluster ||= 0

        base_name = File.basename(path).upcase
        if base_name =~ /(.{0,8}).*\.(.{0,3})/ then
            name = '%-8s%-3s' % [ $1, $2 ]
        else
            name = '%-8.8s   ' % base_name
        end
        name.force_encoding('ASCII-8BIT')

        mtime = File.mtime(path)
        mod_time = (mtime.hour << 11) | (mtime.min << 5) | (mtime.sec >> 1)
        mod_date = ((mtime.year - 1980) << 9) | (mtime.month << 5) | mtime.day
        if File.directory?(path) then
            attr = 0x10 # Directory
        elsif (base_name == 'IO.SYS' || base_name == 'MSDOS.SYS') then
            attr = 0x07 # Hidden, system, read-only
        else
            attr = 0x00 # Normal file
        end
        entry = [
            attr,
            0, 0, 0, 0, 0, 0, 0, 0,
            (first_cluster >> 16) & 0xFF, first_cluster >> 24,
            mod_time & 0xFF, mod_time >> 8,
            mod_date & 0xFF, mod_date >> 8,
            first_cluster & 0xFF, (first_cluster >> 8) & 0xFF,
            size & 0xFF, (size >> 8) & 0xFF, (size >> 16) & 0xFF, size >> 24
        ]

        directory << name + (entry.map {|x| x.chr('ASCII-8BIT')}).join()

    end

    def build_dir
        directory.join('')
    end
end

# 360 KB floppy
floppy_360kb = FloppyFormat.new(
        sector_size: 512,
        cluster_size: 2,
        reserved_sectors: 1,
        num_fats: 2,
        root_dir_size: 112,
        total_sectors: 720,
        media_descriptor: 0xFD,
        sectors_per_track: 9,
        num_heads: 2,
        hidden_sectors: 0,
        drive_number: 0x00
    )

# 720 KB floppy
floppy_720kb = FloppyFormat.new(
        sector_size: 512,
        cluster_size: 2,
        reserved_sectors: 1,
        num_fats: 2,
        root_dir_size: 112,
        total_sectors: 1440,
        media_descriptor: 0xF9,
        sectors_per_track: 9,
        num_heads: 2,
        hidden_sectors: 0,
        drive_number: 0x00
    )

# 1.2 MB floppy
floppy_1200kb = FloppyFormat.new(
        sector_size: 512,
        cluster_size: 1,
        reserved_sectors: 1,
        num_fats: 2,
        root_dir_size: 112,
        total_sectors: 2400,
        media_descriptor: 0xF9,
        sectors_per_track: 15,
        num_heads: 2,
        hidden_sectors: 0,
        drive_number: 0x00
    )

# 1.44 MB floppy
floppy_1440kb = FloppyFormat.new(
        sector_size: 512,
        cluster_size: 1,
        reserved_sectors: 1,
        num_fats: 2,
        root_dir_size: 224,
        total_sectors: 2880,
        media_descriptor: 0xF0,
        sectors_per_track: 18,
        num_heads: 2,
        hidden_sectors: 0,
        drive_number: 0x00
    )

# Generated files may have upper- or lowercase names, according to what
# environment built them. Look for a file that matches without regard
# to case.
def find_file(path)
    # Separate the base name from the directory
    dname = File.dirname(path)
    bname = File.basename(path).downcase

    # Look for a file that matches bname without regard to case
    Dir.foreach(dname) do |n|
        if n.downcase == bname then
            return File.join(dname, n)
        end
    end

    # No match. Return the file name and let File.open report the error
    return path
end

# Build one floppy disk image
def build_disk_image(**args)
    [ :name, :floppy, :file_list ].each do |sym|
        args[sym] or raise RuntimeError, "Must specify: #{sym}"
    end
    # :label is optional

    name = args[:name]
    floppy = args[:floppy]
    file_list = args[:file_list]
    label = args[:label]

    File.open(name, "w+b") do |imgdisk|

        imgdisk.seek(floppy.num_bytes-1)
        imgdisk.write("\0")

        # Write the boot sector
        bootsec = nil
        File.open(find_file("src/BOOT/msboot.bin"), "rb") do |msboot|
            msboot.seek(0x7C00)
            bootsec = msboot.read(512)
        end
        floppy.set_boot_params(bootsec, volume_label: label)
        imgdisk.seek(0)
        imgdisk.write(bootsec)

        # Set up the FAT amd the root directory
        fat = FileAllocTable.new(floppy)
        rootdir = DiskDirectory.new

        # Write the files to the file system
        next_cluster = 2
        file_list.each do |src|

            src = find_file(src)

            # Get the text of the file
            text = File.read(src, mode: "rb")

            if text.empty? then
                # Marks an empty file; no changes to the FAT
                first_cluster = 0
            else
                # Write beginning at this cluster
                first_cluster = next_cluster

                # These need CR-LF translation
                base_name = File.basename(src).downcase
                if CRLFFiles.include?(base_name) then
                    text.gsub!(/(?<!\r)\n/, "\r\n")
                end

                # Write to the data area
                imgdisk.seek(floppy.data_start + floppy.cluster_bytes * (next_cluster-2))
                imgdisk.write(text)

                # Update the FAT
                pos = 0
                while pos + floppy.cluster_bytes < text.size do
                    if fat.size >= floppy.num_clusters + 2 then
                        raise RuntimeError, "#{name}: No space left in the volume"
                    end
                    fat.table[next_cluster] = next_cluster + 1
                    pos += floppy.cluster_bytes
                    next_cluster += 1
                end
                fat.table[next_cluster] = fat.eof
                next_cluster += 1

            end

            # Add to root directory
            if rootdir.size >= floppy.root_dir_size then
                raise RuntimeError, "#{name}: Too many files in the volume"
            end
            rootdir.add_file(src, first_cluster, text.size)
        end

        # Write the FAT
        fat_bytes = fat.build_fat
        floppy.num_fats.times do |i|
            imgdisk.seek(floppy.fat_start + floppy.fat_bytes * i)
            imgdisk.write(fat_bytes)
        end

        # Add the volume label if specified
        if rootdir.size < floppy.root_dir_size and not label.nil? then
            label_rec = ("%-11.11s\x08" % label) + ("\x00" * 20)
            label_rec.force_encoding('ASCII-8BIT')
            rootdir.directory << label_rec
        end

        # Write the root directory
        dir_bytes = rootdir.build_dir
        imgdisk.seek(floppy.root_dir_start)
        imgdisk.write(dir_bytes)
    end
end

# Build the disk images

build_disk_image(
    name: "dos40-360kb-install.img",
    file_list: Distribution360_install,
    floppy: floppy_360kb,
    label: "INSTALL" )

build_disk_image(
    name: "dos40-360kb-select.img",
    file_list: Distribution360_select,
    floppy: floppy_360kb,
    label: "SELECT" )

build_disk_image(
    name: "dos40-360kb-operating-1.img",
    file_list: Distribution360_operating_1,
    floppy: floppy_360kb,
    label: "OPERATING1" )

build_disk_image(
    name: "dos40-360kb-operating-2.img",
    file_list: Distribution360_operating_2,
    floppy: floppy_360kb,
    label: "OPERATING2" )

build_disk_image(
    name: "dos40-360kb-operating-3.img",
    file_list: Distribution360_operating_3,
    floppy: floppy_360kb,
    label: "OPERATING3" )

build_disk_image(
    name: "dos40-720kb-install.img",
    file_list: Distribution720_install,
    floppy: floppy_720kb,
    label: "INSTALL" )

build_disk_image(
    name: "dos40-720kb-operating-1.img",
    file_list: Distribution720_operating,
    floppy: floppy_720kb,
    label: "OPERATING" )

build_disk_image(
    name: "dos40-1200kb.img",
    file_list: Distribution1440, # sic
    floppy: floppy_1200kb,
    label: "INSTALL" )

build_disk_image(
    name: "dos40-1440kb.img",
    file_list: Distribution1440,
    floppy: floppy_1440kb,
    label: "INSTALL" )
