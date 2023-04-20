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

export const TrilogyWindow = GObject.registerClass({
    GTypeName: 'TrilogyWindow',
    Template: 'resource:///com/rutins/Trilogy/window.ui',
    Properties: {

    },
    InternalChildren: ['label'],
}, class TrilogyWindow extends Adw.ApplicationWindow {
    constructor(application) {
        super({ application });

        const bucket = Kaste.Bucket.new('com.rutins.Trilogy.connections', false);
        const contents = bucket.list_contents();
        console.log(contents.next_file(null).get_name());
    }
});

