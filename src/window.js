/* window.js
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

import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import Adw from 'gi://Adw';
import Kaste from 'gi://Kaste';
import Tlg from 'gi://Tlg';

import { ConnectionPreview } from './connectionPreview.js';
import { ConnectionView } from './connectionView.js';
import { AddConnectionDialog } from './addConnectionDialog.js';

export class TrilogyWindow extends Adw.ApplicationWindow {
    bucket = Kaste.Bucket.new('com.rutins.Trilogy.connections', false);

    constructor(application) {
        super({ application });
        this.reloadConnections();
    }

    static {
        GObject.registerClass({
            GTypeName: 'TrilogyWindow',
            Template: 'resource:///com/rutins/Trilogy/window.ui',
            InternalChildren: ['connections_list', 'view_stack', 'leaflet', 'navbar', 'main_content']
        }, this);
    }

    reloadConnections() {
        let preview;
        while((preview = this._connections_list.get_first_child()) != null)
            this._connections_list.remove(preview);

        const contents = this.bucket.list_contents();
        let item;
        while((item = contents.next_file(null)) != null) {
            const name = item.get_name();
            const data = this.bucket.read(Tlg.Connection, name);
            const preview = new ConnectionPreview(data);
            this._connections_list.append(preview);
        }
    }

    addConnection() {
        const dlg = new AddConnectionDialog(this);
        dlg.connect('add-connection', (_, conn) => {
            this.bucket.write(conn.name, conn);
            this.reloadConnections();
        });
        dlg.present();
    }

    navigate(list, row, data) {
        if(row != null) {
            const conn = row.get_child().connection;
            if(!this._view_stack.get_child_by_name('connection-' + conn.name)) {
                const page = new ConnectionView();
                page.connection = conn;
                var sstbExpr = Gtk.PropertyExpression.new(Adw.Leaflet, null, "folded");
                sstbExpr.bind(page, "show-start-title-buttons", this._leaflet);
                page.connect('go-to-navigation', this.goToNavigation.bind(this));
                this._view_stack.add_named(page, 'connection-' + conn.name);
            }
            this._view_stack.set_visible_child_name('connection-' + conn.name);
        } else {
            this._conn_view.connection = null;
            this._view_stack.set_visible_child_name('welcome');
        }
        this._leaflet.set_visible_child(this._main_content);
    }

    goToNavigation() {
        this._leaflet.set_visible_child(this._navbar);
    }
}
