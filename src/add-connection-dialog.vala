using Trilogy.Data;
using Trilogy.Util;

namespace Trilogy {
    [GtkTemplate (ui = "/com/rutins/trilogy/add-connection-dialog.ui")]
    public class AddConnectionDialog : Adw.Window {
        [GtkChild]
        private unowned Gtk.Entry name_entry;
        [GtkChild]
        private unowned Gtk.Entry url_entry;

        public bool valid {get; private set;}

        public signal void add_connection(Connection conn);

        public AddConnectionDialog(Gtk.ApplicationWindow main_window) {
            Object(transient_for: main_window, modal: true);
            validate_input();
        }

        private void add_clicked() {
            add_connection(new Connection(name_entry.text, url_entry.text));
            close();
        }

        private void validate_input() {
            var name = name_entry.text;
            var url = url_entry.text;
            var failed = false;

            if(name == "") {
                failed = true;
                name_entry.add_css_class("error");
            } else {
                name_entry.remove_css_class("error");
            }

            if(Protocol.for_uri(url) == UNKNOWN) {
                failed = true;
                url_entry.add_css_class("error");
            } else {
                url_entry.remove_css_class("error");
            }

            valid = !failed;
        }
    }
}
