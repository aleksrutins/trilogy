api_version = '0.1'
libtlg_srcs = [
	'reflection.vala'
]

libtlg_deps = [
  dependency('gio-2.0'),
  dependency('gobject-2.0'),
  dependency('glib-2.0'),
  dependency('json-glib-1.0'),
  dependency('libpq')
]

libtlg_lib = shared_library('tlg-' + api_version,
  libtlg_srcs,
  vala_gir: 'Tlg-' + api_version + '.gir',
  vala_vapi: 'tlg-' + api_version + '.vapi',
  dependencies: libtlg_deps,
  install: true,
  install_dir: [true, true, true, true]
)

g_ir_compiler = find_program('g-ir-compiler')
custom_target('Tlg-' + api_version + '.typelib', command: [g_ir_compiler, '--shared-library', 'lib' + libtlg_lib.name() + '.so', '--output', '@OUTPUT@', meson.current_build_dir() / 'Tlg-' + api_version + '.gir'],
              output: 'Tlg-' + api_version + '.typelib',
              depends: libtlg_lib,
              install: true,
              install_dir: get_option('libdir') / 'girepository-1.0')



pkg = import('pkgconfig')
pkg.generate(
  description: 'Internal library for Trilogy',
    libraries: libtlg_lib,
         name: 'libtlg',
     filebase: 'libtlg-' + api_version,
      version: meson.project_version(),
      subdirs: 'libtlg',
     requires: ['gio-2.0', 'glib-2.0', 'gobject-2.0', 'json-glib-1.0'],
)