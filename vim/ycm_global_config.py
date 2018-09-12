import os.path
import ycm_core
import subprocess as sp

BUILD_DIR_SUSPECTS = ['objdir','buildir','build']
SOURCE_EXTENSIONS = ['.c','.cc','.cpp','.cxx']
HEADER_EXTENSIONS = ['.h','.hpp','.hxx']
def FindProjectRoot():
    try:
        rev_output = sp.check_output(['git','rev-parse','--show-toplevel'])
        return rev_output.decode().strip()
    except sp.CalledProcessError:
        return None

def FindCompileDB(proj_root):
    test_path = None
    for build_dir in BUILD_DIR_SUSPECTS:
        test_path = os.path.join(proj_root, build_dir)
        if os.path.exists(test_path) and os.path.isdir(test_path):
            break
        else:
            continue
    return test_path

def IsHeaderFile( filename ):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS

def SearchDown(root, target_file):
    for (dirpath, dirnames, filenames) in os.walk(root):
        if target_file in filenames:
            return os.path.join(dirpath, target_file)
    return None

def FindSourceForHeader(filename, proj_root):
    file_base = os.path.splitext(filename)[0]
    file_path = os.path.split(os.path.abspath(filename))[0]
    source_path = None
    for ext in HEADER_EXTENSIONS:
        source_name = file_base + ext
        if os.path.exists(source_name):
            source_path = os.path.abspath(source_name)
            return source_path
        else:
            source_path = SearchDown(proj_root, source_name)
            return source_path
    return None

def FlagsForFile(filename, **kwargs):
    project_root = FindProjectRoot()
    project_name = os.path.split(project_root)[1]
    compile_db_path = FindCompileDB(project_root)
    compile_db = ycm_core.CompilationDatabase(compile_db_path)
    flags = ['-Wall','-Wextra','-Werror','-xc++','-std=c++11']
    min_inc_dirs = ["-I"+os.path.dirname(os.path.abspath(filename))]
    project_include = os.path.join(project_root,'include')
    if os.path.exists(project_include):
        min_inc_dirs.append("-I"+project_include)
    flags.append(min_inc_dirs)
    if compile_db:
        if IsHeaderFile(filename):
            source_file = FindSourceForHeader(filename, project_root)
            if source_file:
                source_info =compile_db.GetCompilationInfoForFile(source_file)
                flags = list(source_info.compiler_flags_)
        else:
            info = compile_db.GetCompilationInfoForFile(filename)
            flags = list(info.compiler_flags_)
    return {
            'flags': flags,
            'do_cache': True
            }
