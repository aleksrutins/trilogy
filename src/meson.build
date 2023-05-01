pkgdatadir = join_paths(get_option('prefix'), get_option('datadir'), meson.project_name())
moduledir = join_paths(pkgdatadir, 'trilogy')
gnome = import('gnome')

blueprints = custom_target('blueprints',
  input: files(
    'gtk/help-overlay.blp',
    'window.blp',
    'connection-preview.blp',
    'add-connection-dialog.blp',
    'connection-view.blp',
    'connection-settings.blp'
  ),
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)

data_res = gnome.compile_resources('trilogy',
  'trilogy.gresource.xml',
  gresource_bundle: true,
  install: true,
  dependencies: blueprints,
  install_dir: pkgdatadir,
)

python = import('python')

conf = configuration_data()
conf.set('PYTHON', python.find_installation('python3').path())
conf.set('VERSION', meson.project_version())
conf.set('localedir', join_paths(get_option('prefix'), get_option('localedir')))
conf.set('pkgdatadir', pkgdatadir)

configure_file(
  input: 'com.rutins.Trilogy.in',
  output: 'com.rutins.Trilogy',
  configuration: conf,
  install: true,
  install_dir: get_option('bindir'),
  install_mode: 'r-xr--r--'
)

trilogy_srcs = [
  '__init__.py',
  'main.py',
  'window.py',
  'add_connection_dialog.py',
  'connection_preview.py',
  'connection_view.py',
  'connection_settings.py'
]

install_data(trilogy_srcs, install_dir: moduledir)