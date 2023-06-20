using Trilogy.Data;

namespace Trilogy {
    [GtkTemplate (ui = "/com/rutins/Trilogy/connection-preview.ui")]
    class ConnectionPreview : Gtk.Box {
        public signal void selected(Connection conn);

        public Connection connection {get; construct set;}

        public ConnectionPreview(Connection conn) {
            Object(connection: conn);
        }

        public override signal void clicked() {
            selected(connection);
        }
    }
}
