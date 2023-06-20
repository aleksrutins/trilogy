/* window.vala
 *
 * Copyright 2023 Aleks Rutins
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
using Trilogy.Data;

namespace Trilogy {
    [GtkTemplate (ui = "/com/rutins/Trilogy/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Adw.Leaflet leaflet;
        [GtkChild]
        private unowned Gtk.ListBox connections_list;
        [GtkChild]
        private unowned Adw.ViewStack view_stack;
        [GtkChild]
        private unowned Gtk.Box navbar;
        [GtkChild]
        private unowned Gtk.Box main_content;

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        private void reload_connections() throws GLib.Error {
            var bucket = Application.connections_bucket;

            Gtk.Widget preview;
            while((preview = connections_list.get_first_child()) != null) {
                connections_list.remove(preview);
            }

            var contents = bucket.list_contents();

            FileInfo item;
            while((item = contents.next_file()) != null) {
                var name = item.get_name();
                var data = (Connection)bucket.read(typeof(Connection), name);
                var new_preview = new ConnectionPreview(data);
                connections_list.append(new_preview);
            }
        }

        void add_connection() {
            var dlg = new AddConnectionDialog(this);
            dlg.add_connection.connect((conn) => {
                Application.connections_bucket.write(conn.name, conn);
                reload_connections();
            });
            dlg.present();
        }

        void open_connection_settings(Object tgt, string conn_name) {
            var settings_wnd = new ConnectionSettings(this, conn_name);
            settings_wnd.present();
        }

        void navigate(Gtk.ListBox _list, Gtk.ListBoxRow row) {
            if(row != null) {
                var conn = ((ConnectionPreview)row.get_child()).connection;
                if(view_stack.get_child_by_name("connection-" + conn.name) == null) {
                    var page = new ConnectionView(conn);
                    var expr = new Gtk.PropertyExpression(typeof(Adw.Leaflet), null, "folded");
                    expr.bind(page, "show_start_title_buttons", leaflet);
                    page.go_to_navigation.connect(go_to_navigation);
                    page.open_settings.connect(open_connection_settings);
                    view_stack.add_named(page, "connection-" + conn.name);
                }
                view_stack.set_visible_child_name("connection-" + conn.name);
            } else {
                view_stack.set_visible_child_name("welcome");
            }
            leaflet.set_visible_child(main_content);
        }

        void go_to_navigation() {
            leaflet.set_visible_child(navbar);
        }
    }
}
