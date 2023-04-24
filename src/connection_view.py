from gi.repository import Gtk, GObject, Gio, Adw, Tlg

@Gtk.Template(resource_path='/com/rutins/Trilogy/connectionView.ui')
class ConnectionView(Adw.Bin):
    __gtype_name__ = 'TrilogyConnectionView'
    _connection: Tlg.Connection
    _show_start_title_buttons: bool
    _overview_page = None

    tab_view = Gtk.Template.Child()

    @GObject.Property(type=Tlg.Connection)
    def connection(self):
        return self._connection

    @connection.setter
    def connection(self, new_conn):
        self._connection = new_conn

    @GObject.Property(type=Tlg.Connection)
    def show_start_title_buttons(self) -> bool:
        return self._show_start_title_buttons

    @show_start_title_buttons.setter
    def show_start_title_buttons(self, new_value: bool):
        self._show_start_title_buttons = new_value

    @GObject.Signal()
    def go_to_navigation(self):
        pass

    def refresh_connection(self):
        conn = self.connection()

        if not conn.connected:
            conn.ensure()
            if self._overview_page is not None:
                page = self.tab_view.get_page(self._overview_page)
                self.tab_view.set_page_pinned(page, False)
                self.tab_view.close_page(page)
            self._overview_page = conn.db.overview_page()
            self.tab_view.append_pinned(self._overview_page)
            page = self.tab_view.get_page(self._overview_page)
            page.set_icon(Gio.Icon.new_for_string('about-symbolic'))
            page.set_title('Overview')
