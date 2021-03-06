#From youcompleteme

import os
import ycm_core

flags = [
'-Wall',
'-Wextra',
'-std=c++11',
'-x',
'c++',
'-I',
'.',
]

compilation_database_folder = os.popen('git rev-parse --show-toplevel').read().replace('\n', '')

if compilation_database_folder:
    database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
    database = None


def DirectoryOfThisScript():
    return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list( flags )
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith( '/' ):
                new_flag = os.path.join( working_directory, flag )

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith( path_flag ):
                path = flag[ len( path_flag ): ]
                new_flag = path_flag + os.path.join( working_directory, path )
                break

        if new_flag:
            new_flags.append( new_flag )
    return new_flags


def FlagsForFile(filename):
    if database:
        if filename[-2:] == ".h":
            filename = filename[:-2] + ".c"
            if not os.path.exists(filename):
                filename = filename[:-2] + ".cpp"
                if not os.path.exists(filename):
                    filename = ""

        if filename[-4:] == ".hpp":
            filename = filename[:-4] + ".cpp"
            if not os.path.exists(filename):
                filename = ""
    else:
        filename = ""

    if filename != "":
        compilation_info = database.GetCompilationInfoForFile(filename)
        final_flags = MakeRelativePathsInFlagsAbsolute(compilation_info.compiler_flags_, compilation_info.compiler_working_dir_)
    else:
        relative_to = DirectoryOfThisScript()
        final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

    return {
        'flags': final_flags,
        'do_cache': True
    }
