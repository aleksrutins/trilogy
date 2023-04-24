from gi.repository import Gtk, GObject, Tlg

@Gtk.Template(resource_path = "/com/rutins/Trilogy/connectionPreview.ui")
class ConnectionPreview(Gtk.Box):
    __gtype_name__ = 'TrilogyConnectionPreview'
    _conn: Tlg.Connection

    def __init__(self, conn: Tlg.Connection):
        super().__init__(connection=conn)

    @GObject.Property(type=Tlg.Connection, flags=GObject.ParamFlags.READWRITE|GObject.ParamFlags.CONSTRUCT)
    def connection(self):
        return self._conn
    
    @connection.setter
    def connection(self, value):
        self._conn = value

    @GObject.Signal(arg_types=(Tlg.Connection,))
    def selected(self, *args):
        pass

    def do_clicked(self, *args):
        self.emit('selected', self.connection())
    