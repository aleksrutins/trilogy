from gi.repository import Gtk, Adw, Kaste, Tlg

from .connection_view import ConnectionView
from .connection_preview import ConnectionPreview
from .add_connection_dialog import AddConnectionDialog
from .connection_settings import ConnectionSettings

@Gtk.Template(resource_path='/com/rutins/Trilogy/window.ui')
class TrilogyWindow(Adw.ApplicationWindow):
    __gtype_name__ = 'TrilogyWindow'

    leaflet = Gtk.Template.Child()
    connections_list = Gtk.Template.Child()
    view_stack = Gtk.Template.Child()
    navbar = Gtk.Template.Child()
    main_content = Gtk.Template.Child()

    bucket = Kaste.Bucket.new('com.rutins.Trilogy.connections', False)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.reload_connections()
    
    def reload_connections(self):
        while (preview := self.connections_list.get_first_child()) != None:
            self.connections_list.remove(preview)
        
        contents = self.bucket.list_contents()

        while (item := contents.next_file()) != None:
            name = item.get_name()
            data = self.bucket.read(Tlg.Connection, name)
            preview = ConnectionPreview(data)
            self.connections_list.append(preview)
    
    def actually_add_connection(self, _, conn):
        self.bucket.write(conn.props.name, conn)
        self.reload_connections()

    @Gtk.Template.Callback()
    def _add_connection(self, *args):
        dlg = AddConnectionDialog(self)
        dlg.connect('add-connection', self.actually_add_connection)
        dlg.present()
    
    def _open_connection_settings(self, _, conn_name: str):
        settings_wnd = ConnectionSettings(self, conn_name)
        settings_wnd.present()
    
    @Gtk.Template.Callback()
    def _navigate(self, _list, row):
        if row != None:
            conn = row.get_child().connection
            if self.view_stack.get_child_by_name('connection-' + conn.props.name) is None:
                page = ConnectionView(conn)
                Tlg.util_bind_leaflet(page, self.leaflet)
                page.connect('go-to-navigation', self._go_to_navigation)
                page.connect('open-settings', self._open_connection_settings)
                self.view_stack.add_named(page, 'connection-' + conn.props.name)
            self.view_stack.set_visible_child_name('connection-' + conn.props.name)
        else:
            self.view_stack.set_visible_child_name('welcome')
        self.leaflet.set_visible_child(self.main_content)

    @Gtk.Template.Callback()
    def _go_to_navigation(self, *args):
        self.leaflet.set_visible_child(self.navbar)
