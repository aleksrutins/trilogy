from gi.repository import Gtk, GObject, Gio, Adw, Tlg

@Gtk.Template(resource_path='/com/rutins/Trilogy/connectionView.ui')
class ConnectionView(Adw.Bin):
    __gtype_name__ = 'TrilogyConnectionView'
    __gsignals__ = {
        'go-to-navigation': (GObject.SIGNAL_RUN_LAST, GObject.TYPE_NONE, ()),
        'open-settings': (GObject.SIGNAL_RUN_LAST, GObject.TYPE_NONE, (str,))
    }

    _overview_page = None

    tab_view = Gtk.Template.Child()

    connection = GObject.Property(type=Tlg.Connection)
    show_start_title_buttons = GObject.Property(type=bool, default=False)

    def __init__(self, conn):
        super().__init__()
        self.props.connection = conn
        self.refresh_connection()

    @Gtk.Template.Callback()
    def _back_clicked(self, *args):
        self.emit('go-to-navigation')
    
    @Gtk.Template.Callback()
    def _open_settings(self, *args):
        self.emit('open-settings', self.props.connection.props.name)

    def refresh_connection(self):
        conn = self.props.connection

        if not conn.props.connected:
            conn.ensure()
            if self._overview_page is not None:
                page = self.tab_view.get_page(self._overview_page)
                self.tab_view.set_page_pinned(page, False)
                self.tab_view.close_page(page)
            self._overview_page = conn.props.db.overview_page()
            self.tab_view.append_pinned(self._overview_page)
            page = self.tab_view.get_page(self._overview_page)
            page.set_icon(Gio.Icon.new_for_string('about-symbolic'))
            page.set_title('Overview')