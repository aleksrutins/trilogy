using Trilogy.Data;

[GtkTemplate (ui = "/com/rutins/Trilogy/connection-view.ui")]
public class Trilogy.ConnectionView : Adw.Bin {
    public signal void go_to_navigation();
    public signal void open_settings(string name);

    private Gtk.Widget? overview_page = null;

    [GtkChild]
    private unowned Adw.TabView tab_view;

    public Connection connection {get; set;}
    public bool show_start_title_buttons {get; set;}

    public ConnectionView(Connection conn) {
        Object(connection: conn);
        refresh_connection();
    }

    private void back_clicked() {
        go_to_navigation();
    }

    private void handle_open_settings() {
        open_settings(connection.name);
    }

    public void refresh_connection() {
        if(!connection.connected) {
            connection.ensure();
            if(overview_page != null) {
                var page = tab_view.get_page(overview_page);
                tab_view.set_page_pinned(page, false);
                tab_view.close_page(page);
            }
            overview_page = connection.db.overview_page();
            var page = tab_view.append_pinned(overview_page);
            page.set_icon(Icon.new_for_string("about-symbolic"));
            page.set_title("Overview");
        }
    }
}